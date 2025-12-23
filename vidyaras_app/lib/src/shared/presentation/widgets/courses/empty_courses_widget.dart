import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../components/buttons/primary_button.dart';

/// Empty state widget for courses screen
/// Design System: Theme typography, 48dp icon, proper spacing
class EmptyCoursesWidget extends StatelessWidget {
  const EmptyCoursesWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionText,
    this.onActionPressed,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: AppSpacing.mdLg),
            Text(
              title,
              style: theme.textTheme.headlineMedium, // H2: 20sp
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionPressed != null) ...[
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(label: actionText!, onPressed: onActionPressed!),
            ],
          ],
        ),
      ),
    );
  }
}
