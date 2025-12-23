import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../buttons/app_text_button.dart';

/// Section header with title and optional action link
/// Design System: H2 (20sp) title, theme-based styling
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
    this.titleStyle,
    this.padding,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ?? theme.textTheme.headlineMedium, // H2: 20sp
          ),
          if (actionLabel != null && onActionTap != null)
            AppTextButton(
              onPressed: onActionTap,
              label: actionLabel!,
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
        ],
      ),
    );
  }
}
