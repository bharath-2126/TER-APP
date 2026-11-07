import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/formatting/date_formatter.dart';
import '../../../core/providers/app_providers.dart';
import '../../transactions/domain/transaction_model.dart';
import '../../../shared/components/financial_card.dart';
import '../../../shared/components/quick_action_button.dart';
import '../../../shared/components/transaction_list_tile.dart';
import '../../../shared/components/numpad_entry_sheet.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final VoidCallback? onViewAllPressed;

  const DashboardScreen({super.key, this.onViewAllPressed});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  void _openQuickEntry(String title, bool isInflow) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return NumpadEntrySheet(
          title: title,
          onSave: (paise, note) {
            final repo = ref.read(ledgerRepositoryProvider);
            final accounts = repo.accounts;
            final defaultAccId = accounts.isNotEmpty ? accounts.first.id : 'acc_default';

            final tx = TransactionModel(
              id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
              type: isInflow ? TransactionType.income : TransactionType.expense,
              amountPaise: paise,
              fromAccountId: isInflow ? null : defaultAccId,
              toAccountId: isInflow ? defaultAccId : null,
              transactionTimestamp: DateTime.now(),
              note: note ?? (isInflow ? 'Quick Income' : 'Quick Expense'),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );

            repo.logTransaction(tx);

            if (!isInflow) {
              ref.read(dailyBudgetProvider.notifier).recordExpense(paise);
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${isInflow ? 'Income' : 'Expense'} recorded: ${CurrencyFormatter.formatPaise(paise)}',
                ),
                backgroundColor: isInflow ? AppColors.inflow : AppColors.primaryBlueDark,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalBalancePaise = ref.watch(totalNetWorthProvider);
    final transactionsAsync = ref.watch(transactionsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildBalanceHeroCard(totalBalancePaise),
            const SizedBox(height: 24),
            _buildQuickActionsRow(),
            const SizedBox(height: 28),
            _buildLatestTransactionsSection(transactionsAsync),
            const SizedBox(height: 100), // padding for floating bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.inflow, width: 2),
            color: AppColors.cardSurfaceElevated,
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 12),
        const Text(
          'Hello Rakib',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        _buildCircleIconButton(
          icon: Icons.notifications_none,
          hasBadge: true,
          onTap: () {},
        ),
        const SizedBox(width: 10),
        _buildCircleIconButton(
          icon: Icons.search,
          hasBadge: false,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required bool hasBadge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.cardBorderSubtle, width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            if (hasBadge)
              Positioned(
                top: 9,
                right: 9,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryBlueGlow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceHeroCard(int totalBalancePaise) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const RadialGradient(
          center: Alignment(-0.6, -0.6),
          radius: 1.2,
          colors: [
            Color(0xFF1E3A8A), // Rich Navy Blue Glow
            Color(0xFF0F172A), // Dark Slate
            Color(0xFF090D1A), // Deep Background
          ],
        ),
        border: Border.all(color: const Color(0x333B82F6), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F2563EB),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            CurrencyFormatter.formatPaise(totalBalancePaise, symbol: '₹'),
            style: AppTypography.heroBalance,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.trending_up, color: AppColors.inflow, size: 16),
              const SizedBox(width: 4),
              Text(
                '+₹6,258.28(14.4%) | Last Week',
                style: AppTypography.cardSubtitle.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuickActionButton(
          icon: Icons.north_east,
          label: 'Send',
          onTap: () => _openQuickEntry('Send Funds', false),
        ),
        QuickActionButton(
          icon: Icons.add,
          label: 'Add Funds',
          onTap: () => _openQuickEntry('Add Income', true),
        ),
        QuickActionButton(
          icon: Icons.qr_code_scanner,
          label: 'Scan & Pay',
          onTap: () => _openQuickEntry('Scan & Pay', false),
        ),
        QuickActionButton(
          icon: Icons.arrow_downward,
          label: 'Withdraw',
          onTap: () => _openQuickEntry('Withdraw Funds', false),
        ),
      ],
    );
  }

  Widget _buildLatestTransactionsSection(AsyncValue<List<TransactionModel>> transactionsAsync) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Latest Transaction',
              style: AppTypography.sectionHeader,
            ),
            GestureDetector(
              onTap: widget.onViewAllPressed,
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No transactions yet. Tap + to add one!',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              );
            }

            return Column(
              children: transactions.take(5).map((tx) {
                return TransactionListTile(
                  icon: tx.isInflow ? Icons.arrow_downward : Icons.restaurant,
                  title: tx.note ?? (tx.isInflow ? 'Income' : 'Expense'),
                  subtitle: AppDateFormatter.formatTransactionTimestamp(tx.transactionTimestamp),
                  formattedAmount: CurrencyFormatter.formatPaise(
                    tx.amountPaise,
                    symbol: '₹',
                    showDecimals: true,
                  ),
                  isInflow: tx.isInflow,
                );
              }).toList(),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primaryBlue),
          ),
          error: (err, _) => Center(
            child: Text('Error loading transactions: $err', style: const TextStyle(color: AppColors.outflow)),
          ),
        ),
      ],
    );
  }
}
