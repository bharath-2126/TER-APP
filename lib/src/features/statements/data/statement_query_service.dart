import '../../transactions/data/ledger_repository.dart';
import '../../transactions/domain/transaction_model.dart';
import '../../lending/domain/lending_engine.dart';
import '../domain/statement_models.dart';

class StatementQueryService {
  final LedgerRepository repo;

  StatementQueryService(this.repo);

  /// Executes queries across the ledger based on granular criteria
  List<StatementEntry> queryStatementEntries(StatementFilterCriteria criteria) {
    final range = criteria.getDateRange();
    final allTxs = repo.transactions;
    final allAccounts = {for (var a in repo.accounts) a.id: a.name};
    final allCards = {for (var c in repo.cards) c.id: c.cardName};
    final allPersons = {for (var p in repo.persons) p.id: p.name};

    // 1. Filter matching transactions
    final filtered = allTxs.where((tx) {
      // Date range check
      if (tx.transactionTimestamp.isBefore(range.start) || tx.transactionTimestamp.isAfter(range.end)) {
        return false;
      }

      // Type filter
      if (criteria.transactionTypes.isNotEmpty) {
        if (!criteria.transactionTypes.contains(tx.type.name)) {
          return false;
        }
      }

      // Person filter
      if (criteria.personId != null && criteria.personId != 'all') {
        if (tx.personId != criteria.personId) return false;
      }

      // Account filter
      if (criteria.accountId != null && criteria.accountId != 'all') {
        if (tx.fromAccountId != criteria.accountId && tx.toAccountId != criteria.accountId) {
          return false;
        }
      }

      // Card filter
      if (criteria.cardId != null && criteria.cardId != 'all') {
        if (tx.cardId != criteria.cardId) return false;
      }

      // Category filter
      if (criteria.categoryId != null && criteria.categoryId != 'all') {
        if (tx.categoryId != criteria.categoryId) return false;
      }

      // Amount bounds
      if (criteria.minAmountPaise != null && tx.amountPaise < criteria.minAmountPaise!) {
        return false;
      }
      if (criteria.maxAmountPaise != null && tx.amountPaise > criteria.maxAmountPaise!) {
        return false;
      }

      return true;
    }).toList();

    // 2. Sort chronologically (oldest first) to compute accurate running balance
    filtered.sort((a, b) => a.transactionTimestamp.compareTo(b.transactionTimestamp));

    int runningBalance = 0;
    final List<StatementEntry> entries = [];

    for (final tx in filtered) {
      final bool isInflow = tx.type == TransactionType.income ||
          tx.type == TransactionType.debtRepayment ||
          (tx.type == TransactionType.transfer && tx.toAccountId == criteria.accountId);

      if (isInflow) {
        runningBalance += tx.amountPaise;
      } else {
        runningBalance -= tx.amountPaise;
      }

      String? accountOrCardName;
      if (tx.cardId != null && allCards.containsKey(tx.cardId)) {
        accountOrCardName = allCards[tx.cardId];
      } else if (tx.fromAccountId != null && allAccounts.containsKey(tx.fromAccountId)) {
        accountOrCardName = allAccounts[tx.fromAccountId];
      } else if (tx.toAccountId != null && allAccounts.containsKey(tx.toAccountId)) {
        accountOrCardName = allAccounts[tx.toAccountId];
      }

      final personName = tx.personId != null ? allPersons[tx.personId] : null;

      String displayType = tx.type.name;
      if (tx.type == TransactionType.splitExpense) displayType = 'Split Expense (My Share)';
      if (tx.type == TransactionType.debtLend) displayType = 'Money Lent (Receivable)';
      if (tx.type == TransactionType.debtRepayment) displayType = 'Repayment Received';
      if (tx.type == TransactionType.debtBorrow) displayType = 'Money Borrowed';

      entries.add(StatementEntry(
        transactionId: tx.id.replaceFirst('tx_', 'TX-'),
        timestamp: tx.transactionTimestamp,
        title: (tx.note != null && tx.note!.isNotEmpty) ? tx.note! : displayType,
        categoryName: tx.categoryId,
        accountOrCardName: accountOrCardName,
        personName: personName,
        typeName: displayType,
        amountPaise: tx.amountPaise,
        isInflow: isInflow,
        runningBalancePaise: runningBalance,
        notes: tx.note,
        splitGroupId: tx.splitGroupId,
        totalBillPaise: tx.totalBillPaise,
      ));
    }

    // Return in reverse chronological order (newest first) for visual display
    return entries.reversed.toList();
  }

  /// Builds a complete Person-Wise Statement Summary for any counterparty (e.g. Rahul Kumar)
  PersonStatementSummary queryPersonStatement({
    required String personId,
    required StatementFilterCriteria criteria,
  }) {
    final range = criteria.getDateRange();
    final person = repo.persons.firstWhere(
      (p) => p.id == personId,
      orElse: () => PersonModel(id: personId, name: 'Contact', outstandingBalancePaise: 0),
    );

    final allTxs = repo.transactions.where((t) => t.personId == personId).toList();

    // 1. Calculate Opening Balance prior to period start date
    int openingDue = 0;
    int lifetimeLent = 0;
    int lifetimeRepaid = 0;

    for (final tx in allTxs) {
      if (tx.type == TransactionType.debtLend || (tx.type == TransactionType.splitExpense && tx.personId == personId)) {
        lifetimeLent += tx.amountPaise;
        if (tx.transactionTimestamp.isBefore(range.start)) {
          openingDue += tx.amountPaise;
        }
      } else if (tx.type == TransactionType.debtRepayment) {
        lifetimeRepaid += tx.amountPaise;
        if (tx.transactionTimestamp.isBefore(range.start)) {
          openingDue -= tx.amountPaise;
        }
      }
    }

    // Also include initial seed debt balance if prior to range
    for (final d in repo.debts) {
      if (d.personId == personId && d.type == DebtType.lent) {
        if (d.initialDate.isBefore(range.start) && !allTxs.any((t) => t.id.contains(d.id))) {
          // Unlogged historical principal
          openingDue += d.outstandingBalancePaise;
          lifetimeLent += d.principalPaise;
        }
      }
    }

    // 2. Filter transactions strictly within the selected date range
    final periodTxs = allTxs.where((tx) =>
      !tx.transactionTimestamp.isBefore(range.start) && !tx.transactionTimestamp.isAfter(range.end)
    ).toList();

    // Sort chronologically to compute running outstanding balance
    periodTxs.sort((a, b) => a.transactionTimestamp.compareTo(b.transactionTimestamp));

    int runningDue = openingDue;
    int periodLent = 0;
    int periodRepaid = 0;
    final List<StatementEntry> entries = [];

    for (final tx in periodTxs) {
      final isRepayment = tx.type == TransactionType.debtRepayment;
      if (isRepayment) {
        periodRepaid += tx.amountPaise;
        runningDue -= tx.amountPaise;
      } else {
        periodLent += tx.amountPaise;
        runningDue += tx.amountPaise;
      }

      entries.add(StatementEntry(
        transactionId: tx.id.replaceFirst('tx_', 'TX-'),
        timestamp: tx.transactionTimestamp,
        title: (tx.note != null && tx.note!.isNotEmpty) ? tx.note! : (isRepayment ? 'Repayment Received' : 'Money Lent'),
        personName: person.name,
        typeName: isRepayment ? 'Repayment' : (tx.splitGroupId != null ? 'Split Lent' : 'Direct Loan'),
        amountPaise: tx.amountPaise,
        isInflow: isRepayment, // true if repayment received
        runningBalancePaise: runningDue,
        notes: tx.note,
        splitGroupId: tx.splitGroupId,
        totalBillPaise: tx.totalBillPaise,
      ));
    }

    return PersonStatementSummary(
      personId: person.id,
      personName: person.name,
      phone: person.phone,
      openingOutstandingPaise: openingDue,
      periodLentPaise: periodLent,
      periodRepaidPaise: periodRepaid,
      closingOutstandingPaise: runningDue,
      lifetimeTotalLentPaise: lifetimeLent,
      lifetimeTotalRepaidPaise: lifetimeRepaid,
      entries: entries.reversed.toList(),
    );
  }

  /// Compiles macro-level Outstanding Balance report (Balance Sheet)
  OutstandingBalanceSummary queryOutstandingBalanceReport() {
    int totalReceivables = 0;
    int totalPayables = 0;
    final List<PersonBalanceItem> items = [];

    for (final p in repo.persons) {
      if (p.outstandingBalancePaise > 0) {
        totalReceivables += p.outstandingBalancePaise;
        items.add(PersonBalanceItem(
          personId: p.id,
          name: p.name,
          phone: p.phone,
          isReceivable: true,
          outstandingPaise: p.outstandingBalancePaise,
          status: 'Active (Owes You)',
        ));
      }
    }

    for (final d in repo.debts) {
      if (d.type == DebtType.borrowed && d.outstandingBalancePaise > 0) {
        totalPayables += d.outstandingBalancePaise;
        final person = repo.persons.cast<PersonModel?>().firstWhere(
          (p) => p?.id == d.personId,
          orElse: () => null,
        );
        items.add(PersonBalanceItem(
          personId: d.personId,
          name: person?.name ?? 'Creditor',
          phone: person?.phone,
          isReceivable: false,
          outstandingPaise: d.outstandingBalancePaise,
          status: 'Payable (You Owe)',
        ));
      }
    }

    return OutstandingBalanceSummary(
      totalReceivablesPaise: totalReceivables,
      totalPayablesPaise: totalPayables,
      netPositionPaise: totalReceivables - totalPayables,
      personBalances: items,
    );
  }
}
