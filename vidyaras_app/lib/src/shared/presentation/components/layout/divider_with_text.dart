import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Horizontal divider with centered text
/// Design System: 12sp helper text, theme styling
class DividerWithText extends StatelessWidget {
  const DividerWithText({
    super.key,
    required this.text,
    this.color,
    this.thickness = 1,
    this.spacing = AppSpacing.md,
  });

  final String text;
  final Color? color;
  final double thickness;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = color ?? AppColors.border;

    return Row(
      children: [
        Expanded(
          child: Divider(color: dividerColor, thickness: thickness),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Text(
            text,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: dividerColor, thickness: thickness),
        ),
      ],
    );
  }
}
