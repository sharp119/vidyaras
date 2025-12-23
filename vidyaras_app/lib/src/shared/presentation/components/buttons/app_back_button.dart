import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Back button with icon and "Back" text
/// Design System: Theme-based styling
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.onPressed, this.label = 'Back'});

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back,
              color: theme.colorScheme.onSurfaceVariant,
              size: AppIconSize.small,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
