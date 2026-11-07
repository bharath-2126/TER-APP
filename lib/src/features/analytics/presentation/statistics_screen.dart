import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/components/financial_card.dart';
import '../../../shared/components/segmented_pill_control.dart';
import '../../../shared/components/fintech_bar_chart.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  final VoidCallback? onBack;

  const StatisticsScreen({super.key, this.onBack});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  int _selectedSegmentIndex = 0; // 0: Daily, 1: Weekly, 2: Monthly
  int _selectedBarIndex = 2; // Wednesday selected by default

  @override
  Widget build(BuildContext context) {
    final dailyBudget = ref.watch(dailyBudgetProvider);

    final List<BarChartItem> chartItems = [
      const BarChartItem(label: 'Mon', value: 0.75, amountPaise: 310000),
      const BarChartItem(label: 'Tue', value: 0.50, amountPaise: 210000),
      BarChartItem(label: 'Wed', value: 0.85, amountPaise: dailyBudget.spentPaise), // Live budget spend
      const BarChartItem(label: 'Thu', value: 0.60, amountPaise: 260000),
      const BarChartItem(label: 'Fri', value: 0.80, amountPaise: 380000),
    ];

    final activeItem = chartItems[_selectedBarIndex];

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
            // Segmented Pill Control (Daily / Weekly / Monthly)
            SegmentedPillControl(
              segments: const ['Daily', 'Weekly', 'Monthly'],
              selectedIndex: _selectedSegmentIndex,
              onSegmentSelected: (index) {
                setState(() => _selectedSegmentIndex = index);
              },
            ),
            const SizedBox(height: 24),
            // Stat Hero Amount & Date
            _buildHeroSpendAmount(activeItem.amountPaise),
            const SizedBox(height: 20),
            // Fintech Bar Chart
            FintechBarChart(
              items: chartItems,
              selectedIndex: _selectedBarIndex,
              onBarSelected: (index) {
                setState(() => _selectedBarIndex = index);
              },
            ),
            const SizedBox(height: 24),
            // Category Breakdown Items
            _buildCategoryBreakdown(),
            const SizedBox(height: 100), // padding for floating bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCircleButton(
          icon: Icons.chevron_left,
          onTap: widget.onBack ?? () {},
        ),
        const Text(
          'Statistics',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        _buildCircleButton(
          icon: Icons.more_horiz,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onTap}) {
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
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }

  Widget _buildHeroSpendAmount(int amountPaise) {
    return Column(
      children: [
        Text(
          CurrencyFormatter.formatPaise(amountPaise, symbol: '₹'),
          style: AppTypography.statHeroAmount,
        ),
        const SizedBox(height: 6),
        const Text(
          'November • 24,Wed • 2025',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBreakdown() {
    return Column(
      children: [
        _buildCategoryCard(
          icon: Icons.shopping_cart_outlined,
          title: 'Shopping',
          totalAmountPaise: 485000,
          trendPercent: 18,
          isPositiveTrend: true,
        ),
        const SizedBox(height: 12),
        _buildCategoryCard(
          icon: Icons.restaurant_outlined,
          title: 'Food & Dining',
          totalAmountPaise: 320000,
          trendPercent: -6,
          isPositiveTrend: false,
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String title,
    required int totalAmountPaise,
    required int trendPercent,
    required bool isPositiveTrend,
  }) {
    return FinancialCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.cardSurfaceElevated,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.cardBorderSubtle, width: 1),
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.cardTitle),
                const SizedBox(height: 4),
                Text(
                  'Total : ${CurrencyFormatter.formatPaise(totalAmountPaise, symbol: '₹', showDecimals: false)}',
                  style: AppTypography.cardSubtitle,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isPositiveTrend ? const Color(0x1F10B981) : const Color(0x1FEF4444),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositiveTrend ? Icons.trending_up : Icons.trending_down,
                  color: isPositiveTrend ? AppColors.inflow : AppColors.outflow,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  '${isPositiveTrend ? '+' : ''}$trendPercent%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isPositiveTrend ? AppColors.inflow : AppColors.outflow,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
