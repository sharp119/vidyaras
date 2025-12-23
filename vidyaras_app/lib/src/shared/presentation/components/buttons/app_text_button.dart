import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Text button with no background or border
/// Design System: Orange or gray text, used for Skip, Forgot Password, View All
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: effectiveColor,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 0.1,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppIconSize.small),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(label),
        ],
      ),
    );
  }
}
