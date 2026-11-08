import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/statement_models.dart';
import 'statement_providers.dart';
import 'pdf_preview_screen.dart';
import 'advanced_filter_sheet.dart';
import 'person_selector_sheet.dart';
import 'outstanding_balance_screen.dart';
import 'saved_presets_sheet.dart';
import 'statement_history_screen.dart';

/// Dedicated Financial Statement Generation Dashboard
/// Acts as the central hub for the 10 Statement categories, custom filter builder,
/// preset configurations, and historical statement archive.
class StatementDashboardScreen extends ConsumerStatefulWidget {
  const StatementDashboardScreen({super.key});

  @override
  ConsumerState<StatementDashboardScreen> createState() => _StatementDashboardScreenState();
}

class _StatementDashboardScreenState extends ConsumerState<StatementDashboardScreen> {
  void _openAdvancedFilters() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AdvancedFilterSheet(),
    );
  }

  void _openPresets() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SavedPresetsSheet(),
    );
  }

  void _openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StatementHistoryScreen(),
      ),
    );
  }

  void _handleCategoryTap(StatementCategoryMeta meta) {
    if (meta.type == StatementCategoryType.personWise) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const PersonSelectorSheet(),
      );
      return;
    }

    if (meta.type == StatementCategoryType.outstandingBalance) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OutstandingBalanceScreen(),
        ),
      );
      return;
    }

    // Configure criteria based on the category
    StatementFilterCriteria criteria;
    switch (meta.type) {
      case StatementCategoryType.allTransactions:
        criteria = const StatementFilterCriteria(datePreset: StatementDatePreset.thisMonth);
        break;
      case StatementCategoryType.income:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'income'},
        );
        break;
      case StatementCategoryType.expense:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'expense', 'splitExpense'},
        );
        break;
      case StatementCategoryType.lending:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'debtLend'},
        );
        break;
      case StatementCategoryType.borrowing:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'debtBorrow'},
        );
        break;
      case StatementCategoryType.bankAccount:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          accountId: 'acc_hdfc_bank', // Primary bank account
        );
        break;
      case StatementCategoryType.creditCard:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          cardId: 'card_regalia', // Primary credit card
        );
        break;
      case StatementCategoryType.budgetAudit:
        criteria = const StatementFilterCriteria(
          datePreset: StatementDatePreset.thisMonth,
          transactionTypes: {'expense', 'splitExpense'},
        );
        break;
      default:
        criteria = const StatementFilterCriteria();
    }

    ref.read(activeStatementFilterProvider.notifier).state = criteria;
    final queryService = ref.read(statementQueryServiceProvider);
    final entries = queryService.queryStatementEntries(criteria);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          title: meta.title.replaceAll(RegExp(r'^\d+\.\s*'), ''),
          periodDescription: criteria.datePreset.label,
          entries: entries,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = StatementCategoryMeta.allCategories;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1422),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statement Generator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Offline Audit & Financial Document Suite',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmarks_rounded, color: Color(0xFFF59E0B)),
            tooltip: 'Saved Presets',
            onPressed: _openPresets,
          ),
          IconButton(
            icon: const Icon(Icons.history_rounded, color: AppColors.primaryBlueGlow),
            tooltip: 'Statement History',
            onPressed: _openHistory,
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        children: [
          // Hero Card: Custom Statement Builder
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryBlueGlow.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune_rounded, color: AppColors.primaryBlueGlow, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Custom Statement Builder',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Filter by Date, Type, Contact, Account, Range & Status',
                            style: TextStyle(color: Colors.white54, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Build customized offline PDF & CSV reports matching any financial criteria.',
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton.icon(
                    onPressed: _openAdvancedFilters,
                    icon: const Icon(Icons.filter_list_rounded, size: 18, color: Colors.white),
                    label: const Text(
                      'Configure Filters & Generate',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          // Section Title: 10 Statement Categories
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STATEMENT CATEGORIES',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              Text(
                '10 Dedicated Engines',
                style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 10 Statement Cards
          ...categories.map((meta) => _buildCategoryCard(meta)),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(StatementCategoryMeta meta) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF161F30),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: meta.isFeatured
              ? meta.accentColor.withOpacity(0.4)
              : Colors.white10,
        ),
        boxShadow: meta.isFeatured
            ? [
                BoxShadow(
                  color: meta.accentColor.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleCategoryTap(meta),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: meta.accentColor.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: meta.accentColor.withOpacity(0.25)),
                  ),
                  child: Icon(meta.icon, color: meta.accentColor, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              meta.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (meta.isFeatured)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: meta.accentColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'KEY AUDIT',
                                style: TextStyle(
                                  color: meta.accentColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        meta.subtitle,
                        style: TextStyle(
                          color: meta.accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        meta.description,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.picture_as_pdf_outlined, color: Colors.white70, size: 12),
                                SizedBox(width: 4),
                                Text('PDF', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                                SizedBox(width: 8),
                                Icon(Icons.table_chart_outlined, color: Colors.white70, size: 12),
                                SizedBox(width: 4),
                                Text('CSV', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            'Generate',
                            style: TextStyle(
                              color: AppColors.primaryBlueGlow,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.primaryBlueGlow,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
