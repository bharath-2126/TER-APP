import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class FinancialCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Border? border;

  const FinancialCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.cardSurface,
          borderRadius: BorderRadius.circular(18),
          border: border ?? Border.all(color: AppColors.cardBorderSubtle, width: 1),
        ),
        child: child,
      ),
    );
  }
}
