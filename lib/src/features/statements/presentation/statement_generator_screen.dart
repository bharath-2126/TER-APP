import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../shared/components/financial_card.dart';
import '../domain/statement_filter_engine.dart';

class StatementGeneratorScreen extends StatefulWidget {
  const StatementGeneratorScreen({super.key});

  @override
  State<StatementGeneratorScreen> createState() => _StatementGeneratorScreenState();
}

class _StatementGeneratorScreenState extends State<StatementGeneratorScreen> {
  StatementTxType _selectedType = StatementTxType.all;

  final List<StatementEntry> _entries = [
    StatementEntry(
      transactionId: 'TX1001',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      title: 'Salary Credit',
      categoryName: 'Income',
      accountOrCardName: 'HDFC Bank',
      typeName: 'Income',
      amountPaise: 8500000, // ₹85,000
      isInflow: true,
      runningBalancePaise: 8500000,
    ),
    StatementEntry(
      transactionId: 'TX1002',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      title: 'Monthly Rent',
      categoryName: 'Housing',
      accountOrCardName: 'HDFC Bank',
      typeName: 'Expense',
      amountPaise: 2500000, // ₹25,000
      isInflow: false,
      runningBalancePaise: 6000000,
    ),
    StatementEntry(
      transactionId: 'TX1003',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      title: 'Lent to Rahul',
      categoryName: 'Lending',
      personName: 'Rahul',
      accountOrCardName: 'Cash',
      typeName: 'Debt Lent',
      amountPaise: 1000000, // ₹10,000
      isInflow: false,
      runningBalancePaise: 5000000,
    ),
  ];

  void _exportCsv() {
    final csvContent = StatementEngine.generateCsv(
      entries: _entries,
      openingBalancePaise: 0,
      currencySymbol: '₹',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Generated CSV (${csvContent.length} bytes ready to share/save)'),
        backgroundColor: AppColors.primaryBlueDark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Statement Generator',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.download, color: AppColors.primaryBlueGlow),
                  onPressed: _exportCsv,
                  tooltip: 'Export CSV',
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Quick Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', StatementTxType.all),
                  const SizedBox(width: 8),
                  _buildFilterChip('Income', StatementTxType.income),
                  const SizedBox(width: 8),
                  _buildFilterChip('Expenses', StatementTxType.expense),
                  const SizedBox(width: 8),
                  _buildFilterChip('Lending', StatementTxType.debtLend),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Statement Entries Table
            ...List.generate(_entries.length, (index) {
              final entry = _entries[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FinancialCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.title, style: AppTypography.cardTitle),
                          Text(
                            '${entry.isInflow ? '+' : '-'}${CurrencyFormatter.formatPaise(entry.amountPaise)}',
                            style: AppTypography.amountMedium.copyWith(
                              color: entry.isInflow ? AppColors.inflow : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${entry.categoryName ?? entry.typeName} • ${entry.accountOrCardName}',
                            style: AppTypography.cardSubtitle,
                          ),
                          Text(
                            'Balance: ${CurrencyFormatter.formatPaise(entry.runningBalancePaise)}',
                            style: AppTypography.cardSubtitle.copyWith(color: AppColors.primaryBlueGlow),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, StatementTxType type) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorderSubtle, width: 1),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
