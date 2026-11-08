import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../accounts/domain/account_model.dart';
import '../../cards_vault/domain/card_model.dart';
import '../../lending/domain/lending_engine.dart';
import '../../budget/domain/daily_budget_engine.dart';
import '../domain/transaction_model.dart';

/// Central Ledger Repository enforcing double-entry rules and financial invariants.
class LedgerRepository {
  // In-memory reactive state backing local Drift storage
  final List<AccountModel> _accounts = [];
  final List<CardModel> _cards = [];
  final List<PersonModel> _persons = [];
  final List<DebtRecord> _debts = [];
  final List<RepaymentRecord> _repayments = [];
  final List<TransactionModel> _transactions = [];
  final Map<int, int> _dailyExpenses = {}; // epochDay -> totalPaise

  final _transactionsStreamController = StreamController<List<TransactionModel>>.broadcast();
  final _accountsStreamController = StreamController<List<AccountModel>>.broadcast();
  final _cardsStreamController = StreamController<List<CardModel>>.broadcast();
  final _debtsStreamController = StreamController<List<DebtRecord>>.broadcast();
  final _personsStreamController = StreamController<List<PersonModel>>.broadcast();

  LedgerRepository() {
    _seedInitialAccountsAndCards();
  }

  void _seedInitialAccountsAndCards() {
    final now = DateTime.now();
    _accounts.addAll([
      AccountModel(
        id: 'acc_hdfc',
        name: 'HDFC Salary A/c',
        type: AccountType.bank,
        openingBalancePaise: 18555000, // ₹1,85,550.00
        currentBalancePaise: 18555000,
        createdAt: now,
        updatedAt: now,
      ),
      AccountModel(
        id: 'acc_icici',
        name: 'ICICI Savings A/c',
        type: AccountType.bank,
        openingBalancePaise: 6500000, // ₹65,000.00
        currentBalancePaise: 6500000,
        createdAt: now,
        updatedAt: now,
      ),
      AccountModel(
        id: 'acc_cash',
        name: 'Cash Wallet',
        type: AccountType.cash,
        openingBalancePaise: 1500000, // ₹15,000.00
        currentBalancePaise: 1500000,
        createdAt: now,
        updatedAt: now,
      ),
    ]);

    _persons.addAll([
      PersonModel(
        id: 'person_rahul',
        name: 'Rahul Kumar',
        phone: '+91 98765 43210',
        outstandingBalancePaise: 30000, // ₹300.00 initial
        avatarColor: '10B981',
      ),
      PersonModel(
        id: 'person_priya',
        name: 'Priya Sharma',
        phone: '+91 91234 56789',
        outstandingBalancePaise: 250000, // ₹2,500.00
        avatarColor: 'F59E0B',
      ),
      PersonModel(
        id: 'person_vikram',
        name: 'Vikram Singh',
        phone: '+91 94567 89012',
        outstandingBalancePaise: 280000, // ₹2,800.00
        avatarColor: '8B5CF6',
      ),
    ]);

    _debts.addAll([
      DebtRecord(
        id: 'debt_prev_rahul',
        personId: 'person_rahul',
        type: DebtType.lent,
        principalPaise: 30000,
        outstandingBalancePaise: 30000,
        initialDate: now.subtract(const Duration(days: 10)),
        status: DebtStatus.active,
        notes: 'Movie Tickets',
      ),
      DebtRecord(
        id: 'debt_prev_priya',
        personId: 'person_priya',
        type: DebtType.lent,
        principalPaise: 250000,
        outstandingBalancePaise: 250000,
        initialDate: now.subtract(const Duration(days: 3)),
        status: DebtStatus.active,
        notes: 'Concert Tickets',
      ),
      DebtRecord(
        id: 'debt_prev_vikram',
        personId: 'person_vikram',
        type: DebtType.borrowed,
        principalPaise: 280000,
        outstandingBalancePaise: 280000,
        initialDate: now.subtract(const Duration(days: 5)),
        status: DebtStatus.active,
        notes: 'Hardware parts advance',
      ),
    ]);

    _cards.addAll([
      CardModel(
        id: 'card_regalia',
        cardName: 'HDFC Regalia Gold',
        cardType: CardType.credit,
        issuerBank: 'HDFC Bank',
        last4Digits: '8821',
        creditLimitPaise: 50000000, // ₹5,00,000.00
        currentOutstandingPaise: 4500000, // ₹45,000.00
        createdAt: now,
        updatedAt: now,
      ),
      CardModel(
        id: 'card_coral',
        accountId: 'acc_icici',
        cardName: 'ICICI Coral Debit',
        cardType: CardType.debit,
        issuerBank: 'ICICI Bank',
        last4Digits: '1942',
        createdAt: now,
        updatedAt: now,
      ),
    ]);

    _notifyAll();
  }

  // --- Streams ---
  Stream<List<TransactionModel>> watchTransactions() => _transactionsStreamController.stream;
  Stream<List<AccountModel>> watchAccounts() => _accountsStreamController.stream;
  Stream<List<CardModel>> watchCards() => _cardsStreamController.stream;
  Stream<List<DebtRecord>> watchDebts() => _debtsStreamController.stream;
  Stream<List<PersonModel>> watchPersons() => _personsStreamController.stream;

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  List<AccountModel> get accounts => List.unmodifiable(_accounts);
  List<CardModel> get cards => List.unmodifiable(_cards);
  List<DebtRecord> get debts => List.unmodifiable(_debts);
  List<PersonModel> get persons => List.unmodifiable(_persons);

  /// Records a Split Transaction atomically.
  /// Deducts full bill amount from paying account.
  /// Records personal share as an expense (only your share affects budget/stats).
  /// Records friend shares as money lent (receivables) under their profiles.
  Future<void> recordSplitTransaction({
    required int totalBillPaise,
    required int mySharePaise,
    required String description,
    required String fromAccountId,
    String? cardId,
    String? categoryId,
    required Map<String, int> participantShares,
    required DateTime transactionTimestamp,
  }) async {
    final splitGroupId = 'split_${DateTime.now().millisecondsSinceEpoch}';

    // 1. Deduct FULL bill amount from account/card
    _applyExpense(TransactionModel(
      id: 'tx_bill_deduct',
      type: TransactionType.expense,
      amountPaise: totalBillPaise,
      fromAccountId: fromAccountId,
      cardId: cardId,
      transactionTimestamp: transactionTimestamp,
      createdAt: transactionTimestamp,
      updatedAt: transactionTimestamp,
    ));

    // 2. Insert Personal Share as the official Expense transaction
    final personalTx = TransactionModel(
      id: 'tx_my_share_${DateTime.now().millisecondsSinceEpoch}',
      type: TransactionType.splitExpense,
      amountPaise: mySharePaise,
      fromAccountId: fromAccountId,
      cardId: cardId,
      categoryId: categoryId ?? 'cat_food',
      splitGroupId: splitGroupId,
      totalBillPaise: totalBillPaise,
      note: '$description (Personal share of ₹${totalBillPaise ~/ 100} bill)',
      transactionTimestamp: transactionTimestamp,
      createdAt: transactionTimestamp,
      updatedAt: transactionTimestamp,
    );
    _transactions.insert(0, personalTx);

    // Track personal share in daily expenses
    final epochDay = transactionTimestamp.millisecondsSinceEpoch ~/ 86400000;
    _dailyExpenses[epochDay] = (_dailyExpenses[epochDay] ?? 0) + mySharePaise;

    // 3. For each participant, create a lending record and update person profile
    participantShares.forEach((personId, sharePaise) {
      if (sharePaise <= 0) return;

      final pIdx = _persons.indexWhere((p) => p.id == personId);
      String personName = 'Friend';
      if (pIdx != -1) {
        personName = _persons[pIdx].name;
        _persons[pIdx] = _persons[pIdx].copyWith(
          outstandingBalancePaise: _persons[pIdx].outstandingBalancePaise + sharePaise,
        );
      } else {
        _persons.add(PersonModel(
          id: personId,
          name: personName,
          outstandingBalancePaise: sharePaise,
        ));
      }

      final debt = DebtRecord(
        id: 'debt_${DateTime.now().millisecondsSinceEpoch}_$personId',
        personId: personId,
        type: DebtType.lent,
        principalPaise: sharePaise,
        outstandingBalancePaise: sharePaise,
        initialDate: transactionTimestamp,
        status: DebtStatus.active,
        notes: 'Split Bill: $description (Total ₹${totalBillPaise ~/ 100})',
        splitGroupId: splitGroupId,
      );
      _debts.insert(0, debt);

      _transactions.insert(1, TransactionModel(
        id: 'tx_lent_${DateTime.now().millisecondsSinceEpoch}_$personId',
        type: TransactionType.debtLend,
        amountPaise: sharePaise,
        personId: personId,
        splitGroupId: splitGroupId,
        note: 'Lent to $personName via split ($description)',
        transactionTimestamp: transactionTimestamp,
        createdAt: transactionTimestamp,
        updatedAt: transactionTimestamp,
      ));
    });

    _notifyAll();
  }

  /// Records partial or full repayment from a borrower (e.g. Rahul returning ₹300)
  Future<void> recordLendingRepayment({
    required String personId,
    required int amountPaise,
    required String toAccountId,
    String? notes,
  }) async {
    final now = DateTime.now();

    // 1. Inflow money into receiving account
    final toIdx = _accounts.indexWhere((a) => a.id == toAccountId);
    if (toIdx != -1) {
      _accounts[toIdx] = _accounts[toIdx].copyWith(
        currentBalancePaise: _accounts[toIdx].currentBalancePaise + amountPaise,
        updatedAt: now,
      );
    }

    // 2. Reduce person's outstanding balance
    final pIdx = _persons.indexWhere((p) => p.id == personId);
    if (pIdx != -1) {
      _persons[pIdx] = _persons[pIdx].copyWith(
        outstandingBalancePaise: (_persons[pIdx].outstandingBalancePaise - amountPaise).clamp(0, 999999999).toInt(),
      );
    }

    // 3. Update debt record(s)
    int remainingToCredit = amountPaise;
    for (int i = 0; i < _debts.length; i++) {
      if (_debts[i].personId == personId && _debts[i].outstandingBalancePaise > 0) {
        final deduct = remainingToCredit <= _debts[i].outstandingBalancePaise
            ? remainingToCredit
            : _debts[i].outstandingBalancePaise;
        
        final result = LendingEngine.applyRepayment(
          debt: _debts[i],
          repaymentId: 'rep_${DateTime.now().millisecondsSinceEpoch}',
          repaymentAmountPaise: deduct,
          repaymentDate: now,
          notes: notes,
        );

        _debts[i] = _debts[i].copyWithOutstanding(
          newOutstanding: result.newOutstandingPaise,
          newStatus: result.newStatus,
        );
        _repayments.add(result.repayment);

        remainingToCredit -= deduct;
        if (remainingToCredit <= 0) break;
      }
    }

    // 4. Log transaction
    _transactions.insert(0, TransactionModel(
      id: 'tx_rep_${DateTime.now().millisecondsSinceEpoch}',
      type: TransactionType.debtRepayment,
      amountPaise: amountPaise,
      toAccountId: toAccountId,
      personId: personId,
      note: notes ?? 'Repayment received',
      transactionTimestamp: now,
      createdAt: now,
      updatedAt: now,
    ));

    _notifyAll();
  }

  /// Computes aggregate Liquid Cash Net Worth
  int calculateTotalLiquidBalancePaise() {
    int total = 0;
    for (final acc in _accounts) {
      if (!acc.isArchived) total += acc.currentBalancePaise;
    }
    return total;
  }

  /// Logs a transaction enforcing atomic ledger updates
  Future<void> logTransaction(TransactionModel tx) async {
    switch (tx.type) {
      case TransactionType.expense:
      case TransactionType.splitExpense:
        _applyExpense(tx);
        break;
      case TransactionType.income:
        _applyIncome(tx);
        break;
      case TransactionType.transfer:
        _applyTransfer(tx);
        break;
      case TransactionType.creditCardPayment:
        _applyCreditCardSettlement(tx);
        break;
      case TransactionType.debtLend:
      case TransactionType.debtBorrow:
      case TransactionType.debtRepayment:
        _applyDebtTransaction(tx);
        break;
    }

    _transactions.insert(0, tx);

    // Track daily budget expense if not excluded
    if ((tx.type == TransactionType.expense || tx.type == TransactionType.splitExpense) && !tx.isExcludedFromBudget) {
      final epochDay = tx.transactionTimestamp.millisecondsSinceEpoch ~/ 86400000;
      _dailyExpenses[epochDay] = (_dailyExpenses[epochDay] ?? 0) + tx.amountPaise;
    }

    _notifyAll();
  }

  void _applyExpense(TransactionModel tx) {
    if (tx.cardId != null) {
      final cardIdx = _cards.indexWhere((c) => c.id == tx.cardId);
      if (cardIdx != -1) {
        final card = _cards[cardIdx];
        if (card.cardType == CardType.credit) {
          // Increase card outstanding balance
          _cards[cardIdx] = card.copyWith(
            currentOutstandingPaise: card.currentOutstandingPaise + tx.amountPaise,
            updatedAt: DateTime.now(),
          );
          return;
        } else if (card.accountId != null) {
          // Debit card directly charges linked bank account
          _deductAccountBalance(card.accountId!, tx.amountPaise);
          return;
        }
      }
    }

    if (tx.fromAccountId != null) {
      _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    }
  }

  void _applyIncome(TransactionModel tx) {
    final targetAccountId = tx.toAccountId ?? _accounts.first.id;
    final accIdx = _accounts.indexWhere((a) => a.id == targetAccountId);
    if (accIdx != -1) {
      _accounts[accIdx] = _accounts[accIdx].copyWith(
        currentBalancePaise: _accounts[accIdx].currentBalancePaise + tx.amountPaise,
        updatedAt: DateTime.now(),
      );
    }
  }

  void _applyTransfer(TransactionModel tx) {
    if (tx.fromAccountId == null || tx.toAccountId == null) return;
    _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    final toIdx = _accounts.indexWhere((a) => a.id == tx.toAccountId);
    if (toIdx != -1) {
      _accounts[toIdx] = _accounts[toIdx].copyWith(
        currentBalancePaise: _accounts[toIdx].currentBalancePaise + tx.amountPaise,
        updatedAt: DateTime.now(),
      );
    }
  }

  void _applyCreditCardSettlement(TransactionModel tx) {
    // 1. Deduct money from paying bank account
    if (tx.fromAccountId != null) {
      _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    }
    // 2. Reduce outstanding on credit card
    if (tx.cardId != null) {
      final cardIdx = _cards.indexWhere((c) => c.id == tx.cardId);
      if (cardIdx != -1) {
        final card = _cards[cardIdx];
        final newOutstanding = (card.currentOutstandingPaise - tx.amountPaise).clamp(0, card.creditLimitPaise ?? 999999999).toInt();
        _cards[cardIdx] = card.copyWith(
          currentOutstandingPaise: newOutstanding,
          updatedAt: DateTime.now(),
        );
      }
    }
  }

  void _applyDebtTransaction(TransactionModel tx) {
    if (tx.type == TransactionType.debtLend && tx.fromAccountId != null) {
      _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    } else if (tx.type == TransactionType.debtBorrow && tx.toAccountId != null) {
      final toIdx = _accounts.indexWhere((a) => a.id == tx.toAccountId);
      if (toIdx != -1) {
        _accounts[toIdx] = _accounts[toIdx].copyWith(
          currentBalancePaise: _accounts[toIdx].currentBalancePaise + tx.amountPaise,
          updatedAt: DateTime.now(),
        );
      }
    }
  }

  void _deductAccountBalance(String accountId, int amountPaise) {
    final accIdx = _accounts.indexWhere((a) => a.id == accountId);
    if (accIdx != -1) {
      _accounts[accIdx] = _accounts[accIdx].copyWith(
        currentBalancePaise: _accounts[accIdx].currentBalancePaise - amountPaise,
        updatedAt: DateTime.now(),
      );
    }
  }

  void _notifyAll() {
    _transactionsStreamController.add(List.unmodifiable(_transactions));
    _accountsStreamController.add(List.unmodifiable(_accounts));
    _cardsStreamController.add(List.unmodifiable(_cards));
    _debtsStreamController.add(List.unmodifiable(_debts));
    _personsStreamController.add(List.unmodifiable(_persons));
  }

  void dispose() {
    _transactionsStreamController.close();
    _accountsStreamController.close();
    _cardsStreamController.close();
    _debtsStreamController.close();
    _personsStreamController.close();
  }
}
