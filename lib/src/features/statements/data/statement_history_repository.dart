import 'package:flutter/material.dart';
import '../domain/statement_models.dart';

class StatementHistoryRepository {
  final List<StatementHistoryItem> _history = [];
  final List<SavedFilterPreset> _presets = [];

  StatementHistoryRepository() {
    _seedDefaultPresets();
    _seedInitialHistory();
  }

  List<StatementHistoryItem> get history => List.unmodifiable(_history);
  List<SavedFilterPreset> get presets => List.unmodifiable(_presets);

  void addHistory(StatementHistoryItem item) {
    _history.insert(0, item);
  }

  void addPreset(SavedFilterPreset preset) {
    _presets.insert(0, preset);
  }

  void _seedDefaultPresets() {
    _presets.addAll([
      const SavedFilterPreset(
        id: 'preset_monthly_expense',
        name: 'Monthly Expenses Audit',
        description: 'Current Month • Expense Only • All Accounts',
        icon: Icons.calendar_month_rounded,
        accentColor: Color(0xFF38BDF8),
        criteria: StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'expense', 'splitExpense'},
        ),
      ),
      const SavedFilterPreset(
        id: 'preset_rahul_lending',
        name: 'Rahul Lending Ledger',
        description: 'All Time • Rahul Kumar • Lent & Repaid',
        icon: Icons.person_rounded,
        accentColor: Color(0xFF10B981),
        criteria: StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          personId: 'person_rahul',
          transactionTypes: {'debtLend', 'debtRepayment', 'splitExpense'},
        ),
      ),
      const SavedFilterPreset(
        id: 'preset_pending_receivables',
        name: 'Pending Receivables Report',
        description: 'Status: Active/Partial • Type: Lent',
        icon: Icons.handshake_outlined,
        accentColor: Color(0xFFF59E0B),
        criteria: StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'debtLend'},
          status: 'pending',
        ),
      ),
      const SavedFilterPreset(
        id: 'preset_credit_card_dues',
        name: 'Credit Card Dues & Billing',
        description: 'Account: HDFC Regalia • Last 30 Days',
        icon: Icons.credit_card_rounded,
        accentColor: Color(0xFFF43F5E),
        criteria: StatementFilterCriteria(
          datePreset: StatementDatePreset.last30Days,
          cardId: 'card_regalia',
        ),
      ),
    ]);
  }

  void _seedInitialHistory() {
    final now = DateTime.now();
    _history.addAll([
      StatementHistoryItem(
        id: 'stmt_hist_1',
        title: 'Rahul Kumar Reconciliation Statement',
        categoryType: StatementCategoryType.personWise,
        generatedAt: now.subtract(const Duration(hours: 1)),
        periodDescription: '01 Nov 2026 - Today',
        filterSummary: 'Person: Rahul Kumar • Split Lent + Repaid',
        recordCount: 3,
        totalAmountPaise: 120000,
        filePath: 'TER_Statements/TER_Statement_Rahul_Kumar.pdf',
        format: 'PDF',
      ),
      StatementHistoryItem(
        id: 'stmt_hist_2',
        title: 'October 2026 Expense Statement',
        categoryType: StatementCategoryType.expense,
        generatedAt: now.subtract(const Duration(days: 2)),
        periodDescription: '01 Oct 2026 - 31 Oct 2026',
        filterSummary: 'Type: Expense • All Accounts',
        recordCount: 42,
        totalAmountPaise: 4210000,
        filePath: 'TER_Statements/TER_October_Expense.pdf',
        format: 'PDF',
      ),
    ]);
  }
}
