import 'package:flutter/material.dart';

/// The 10 Statement Categories
enum StatementCategoryType {
  allTransactions,
  income,
  expense,
  lending,
  borrowing,
  personWise,
  bankAccount,
  creditCard,
  budgetAudit,
  outstandingBalance,
}

class StatementCategoryMeta {
  final StatementCategoryType type;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color accentColor;
  final bool isFeatured;

  const StatementCategoryMeta({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.accentColor,
    this.isFeatured = false,
  });

  static const List<StatementCategoryMeta> allCategories = [
    StatementCategoryMeta(
      type: StatementCategoryType.personWise,
      title: '6. Person-Wise Statement',
      subtitle: 'Counterparty Audit',
      description: 'Reconcile Rahul, Priya & contacts. Opening balance, split bills, repayments & closing outstanding.',
      icon: Icons.person_search_rounded,
      accentColor: Color(0xFF10B981),
      isFeatured: true,
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.allTransactions,
      title: '1. All Transactions',
      subtitle: 'Complete Ledger',
      description: 'Unified chronological audit trail across all bank accounts, cards & debts.',
      icon: Icons.receipt_long_rounded,
      accentColor: Color(0xFF38BDF8),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.income,
      title: '2. Income Statement',
      subtitle: 'Inflow & Earnings',
      description: 'Salary, freelance inflows, client settlements & monthly earnings overview.',
      icon: Icons.trending_up_rounded,
      accentColor: Color(0xFF10B981),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.expense,
      title: '3. Expense Statement',
      subtitle: 'Outflow Analytics',
      description: 'Daily & monthly category leaks, essentials vs discretionary spend analysis.',
      icon: Icons.shopping_bag_outlined,
      accentColor: Color(0xFFEF4444),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.lending,
      title: '4. Lending Statement',
      subtitle: 'Receivables Asset',
      description: 'Money lent, split bill receivables, active balances & pending settlements.',
      icon: Icons.handshake_outlined,
      accentColor: Color(0xFFF59E0B),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.borrowing,
      title: '5. Borrowing Statement',
      subtitle: 'Payables & Debts',
      description: 'Money borrowed from friends/creditors & repayment commitments.',
      icon: Icons.account_balance_wallet_outlined,
      accentColor: Color(0xFF8B5CF6),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.bankAccount,
      title: '7. Bank Accounts',
      subtitle: 'Passbook Balances',
      description: 'HDFC, ICICI & Cash wallet passbook running balance statements.',
      icon: Icons.account_balance_rounded,
      accentColor: Color(0xFF06B6D4),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.creditCard,
      title: '8. Credit Card Statement',
      subtitle: 'Card Billing Cycles',
      description: 'HDFC Regalia billing cycle, unbilled spends & settlement verification.',
      icon: Icons.credit_card_rounded,
      accentColor: Color(0xFFF43F5E),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.budgetAudit,
      title: '9. Daily Budget Audit',
      subtitle: 'Carry-Forward Flow',
      description: 'Surplus carry-forward audit, daily limits & spend discipline report.',
      icon: Icons.bolt_rounded,
      accentColor: Color(0xFF38BDF8),
    ),
    StatementCategoryMeta(
      type: StatementCategoryType.outstandingBalance,
      title: '10. Outstanding Balance Report',
      subtitle: 'Macro Balance Sheet',
      description: 'Total Receivables vs Total Payables balance sheet & person risk mapping.',
      icon: Icons.balance_rounded,
      accentColor: Color(0xFFF59E0B),
      isFeatured: true,
    ),
  ];
}

/// Date range quick presets
enum StatementDatePreset {
  today('Today'),
  yesterday('Yesterday'),
  last7Days('Last 7 Days'),
  last30Days('Last 30 Days'),
  thisMonth('This Month'),
  previousMonth('Previous Month'),
  custom('Custom Range');

  final String label;
  const StatementDatePreset(this.label);
}

/// Granular filter criteria supporting 7 query vectors
@immutable
class StatementFilterCriteria {
  final StatementDatePreset datePreset;
  final DateTime? customStartDate;
  final DateTime? customEndDate;
  final Set<String> transactionTypes; // 'expense', 'income', 'splitExpense', 'debtLend', 'debtRepayment', etc.
  final String? personId;
  final String? categoryId;
  final String? accountId;
  final String? cardId;
  final int? minAmountPaise;
  final int? maxAmountPaise;
  final String? status; // 'all', 'pending', 'partiallyPaid', 'settled'

  const StatementFilterCriteria({
    this.datePreset = StatementDatePreset.thisMonth,
    this.customStartDate,
    this.customEndDate,
    this.transactionTypes = const {},
    this.personId,
    this.categoryId,
    this.accountId,
    this.cardId,
    this.minAmountPaise,
    this.maxAmountPaise,
    this.status = 'all',
  });

  StatementFilterCriteria copyWith({
    StatementDatePreset? datePreset,
    DateTime? customStartDate,
    DateTime? customEndDate,
    Set<String>? transactionTypes,
    String? personId,
    String? categoryId,
    String? accountId,
    String? cardId,
    int? minAmountPaise,
    int? maxAmountPaise,
    String? status,
  }) {
    return StatementFilterCriteria(
      datePreset: datePreset ?? this.datePreset,
      customStartDate: customStartDate ?? this.customStartDate,
      customEndDate: customEndDate ?? this.customEndDate,
      transactionTypes: transactionTypes ?? this.transactionTypes,
      personId: personId ?? this.personId,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      cardId: cardId ?? this.cardId,
      minAmountPaise: minAmountPaise ?? this.minAmountPaise,
      maxAmountPaise: maxAmountPaise ?? this.maxAmountPaise,
      status: status ?? this.status,
    );
  }

  /// Calculates actual DateTime bounds
  DateTimeRange getDateRange() {
    final now = DateTime.now();
    switch (datePreset) {
      case StatementDatePreset.today:
        final start = DateTime(now.year, now.month, now.day);
        return DateTimeRange(start: start, end: now);
      case StatementDatePreset.yesterday:
        final y = now.subtract(const Duration(days: 1));
        final start = DateTime(y.year, y.month, y.day);
        final end = DateTime(y.year, y.month, y.day, 23, 59, 59);
        return DateTimeRange(start: start, end: end);
      case StatementDatePreset.last7Days:
        final start = now.subtract(const Duration(days: 7));
        return DateTimeRange(start: start, end: now);
      case StatementDatePreset.last30Days:
        final start = now.subtract(const Duration(days: 30));
        return DateTimeRange(start: start, end: now);
      case StatementDatePreset.thisMonth:
        final start = DateTime(now.year, now.month, 1);
        return DateTimeRange(start: start, end: now);
      case StatementDatePreset.previousMonth:
        final prevMonthYear = now.month == 1 ? now.year - 1 : now.year;
        final prevMonth = now.month == 1 ? 12 : now.month - 1;
        final start = DateTime(prevMonthYear, prevMonth, 1);
        final lastDay = DateTime(prevMonthYear, prevMonth + 1, 0).day;
        final end = DateTime(prevMonthYear, prevMonth, lastDay, 23, 59, 59);
        return DateTimeRange(start: start, end: end);
      case StatementDatePreset.custom:
        return DateTimeRange(
          start: customStartDate ?? DateTime(now.year, now.month, 1),
          end: customEndDate ?? now,
        );
    }
  }
}

/// Unified entry row for reports and PDFs
@immutable
class StatementEntry {
  final String transactionId;
  final DateTime timestamp;
  final String title;
  final String? categoryName;
  final String? accountOrCardName;
  final String? personName;
  final String typeName;
  final int amountPaise;
  final bool isInflow; // true: credit/repayment/income, false: debit/expense/loan
  final int runningBalancePaise;
  final String? notes;
  final String? splitGroupId;
  final int? totalBillPaise;

  const StatementEntry({
    required this.transactionId,
    required this.timestamp,
    required this.title,
    this.categoryName,
    this.accountOrCardName,
    this.personName,
    required this.typeName,
    required this.amountPaise,
    required this.isInflow,
    required this.runningBalancePaise,
    this.notes,
    this.splitGroupId,
    this.totalBillPaise,
  });
}

/// Person-wise Reconciliation Summary
class PersonStatementSummary {
  final String personId;
  final String personName;
  final String? phone;
  final int openingOutstandingPaise;
  final int periodLentPaise;
  final int periodRepaidPaise;
  final int closingOutstandingPaise;
  final int lifetimeTotalLentPaise;
  final int lifetimeTotalRepaidPaise;
  final List<StatementEntry> entries;

  const PersonStatementSummary({
    required this.personId,
    required this.personName,
    this.phone,
    required this.openingOutstandingPaise,
    required this.periodLentPaise,
    required this.periodRepaidPaise,
    required this.closingOutstandingPaise,
    required this.lifetimeTotalLentPaise,
    required this.lifetimeTotalRepaidPaise,
    required this.entries,
  });
}

/// Outstanding Balance Balance Sheet Summary
class OutstandingBalanceSummary {
  final int totalReceivablesPaise; // Money you are owed
  final int totalPayablesPaise;    // Money you owe
  final int netPositionPaise;      // Receivables - Payables
  final List<PersonBalanceItem> personBalances;

  const OutstandingBalanceSummary({
    required this.totalReceivablesPaise,
    required this.totalPayablesPaise,
    required this.netPositionPaise,
    required this.personBalances,
  });
}

class PersonBalanceItem {
  final String personId;
  final String name;
  final String? phone;
  final bool isReceivable; // true: they owe you, false: you owe them
  final int outstandingPaise;
  final String status;

  const PersonBalanceItem({
    required this.personId,
    required this.name,
    this.phone,
    required this.isReceivable,
    required this.outstandingPaise,
    required this.status,
  });
}

/// Metadata record for Statement History archive
class StatementHistoryItem {
  final String id;
  final String title;
  final StatementCategoryType categoryType;
  final DateTime generatedAt;
  final String periodDescription;
  final String filterSummary;
  final int recordCount;
  final int totalAmountPaise;
  final String filePath;
  final String format; // 'PDF' or 'CSV'

  const StatementHistoryItem({
    required this.id,
    required this.title,
    required this.categoryType,
    required this.generatedAt,
    required this.periodDescription,
    required this.filterSummary,
    required this.recordCount,
    required this.totalAmountPaise,
    required this.filePath,
    required this.format,
  });
}

/// Saved Filter Preset for 1-tap statement generation
class SavedFilterPreset {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color accentColor;
  final StatementFilterCriteria criteria;

  const SavedFilterPreset({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.criteria,
  });
}
