import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Badge label component for status, membership, tags
/// Used for "Premium Member", course difficulty, etc.
class BadgeLabel extends StatelessWidget {
  const BadgeLabel({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 12,
    this.padding,
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.premiumBadge.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor ?? AppColors.premiumBadge,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Predefined badge styles for common use cases
class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key, this.label = 'Premium Member'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.premiumBadge.withOpacity(0.1),
      textColor: AppColors.premiumBadge,
    );
  }
}

class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.success.withOpacity(0.1),
      textColor: AppColors.success,
    );
  }
}

class ErrorBadge extends StatelessWidget {
  const ErrorBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.error.withOpacity(0.1),
      textColor: AppColors.error,
    );
  }
}
