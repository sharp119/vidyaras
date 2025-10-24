import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/buttons/primary_button.dart';

/// Empty state widget for courses screen
/// Shows when no courses are found or user has no enrolled courses
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionPressed != null) ...[
              const SizedBox(height: 32),
              PrimaryButton(
                label: actionText!,
                onPressed: onActionPressed!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
