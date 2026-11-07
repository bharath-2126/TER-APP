import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'financial_card.dart';

class TransactionListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String formattedAmount;
  final bool isInflow;
  final VoidCallback? onTap;

  const TransactionListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.formattedAmount,
    required this.isInflow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FinancialCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Squircle icon container
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.cardSurfaceElevated,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.cardBorderSubtle, width: 1),
              ),
              child: Icon(
                icon,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            // Title & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.cardTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTypography.cardSubtitle,
                  ),
                ],
              ),
            ),
            // Trailing Amount
            Text(
              '${isInflow ? '+ ' : '-'}$formattedAmount',
              style: AppTypography.amountMedium.copyWith(
                color: isInflow ? AppColors.inflow : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
