import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'financial_card.dart';

class BarChartItem {
  final String label;
  final double value; // 0.0 to 1.0 relative height
  final int amountPaise;

  const BarChartItem({
    required this.label,
    required this.value,
    required this.amountPaise,
  });
}

class FintechBarChart extends StatelessWidget {
  final List<BarChartItem> items;
  final int selectedIndex;
  final ValueChanged<int> onBarSelected;

  const FintechBarChart({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onBarSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FinancialCard(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        children: [
          // Bars Row
          SizedBox(
            height: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () => onBarSelected(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // The Vertical Pill Bar
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        width: 44,
                        height: 120 * item.value.clamp(0.15, 1.0),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.chartBarActive : AppColors.chartBarMuted,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryBlue.withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Day Label
                      Text(
                        item.label,
                        style: AppTypography.cardSubtitle.copyWith(
                          color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 14),
          // Helper prompt
          Text(
            'Tap any segment to view details',
            style: AppTypography.cardSubtitle.copyWith(
              color: AppColors.textTertiary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
