import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';

/// Confirmation dialog for logout action
/// Design System: 16dp radius, theme typography
class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      title: Row(
        children: [
          Icon(
            Icons.logout,
            color: AppColors.error,
            size: AppIconSize.standard,
          ),
          const SizedBox(width: AppSpacing.mdSm),
          Text(
            'Logout?',
            style: theme.textTheme.headlineMedium, // H2: 20sp
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to logout? You will need to sign in again to access your courses.',
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: AppSpacing.mdSm),
              Expanded(
                child: PrimaryButton(
                  label: 'Logout',
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  backgroundColor: AppColors.error,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Helper function to show logout dialog
Future<void> showLogoutDialog(
  BuildContext context, {
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) => LogoutConfirmationDialog(onConfirm: onConfirm),
  );
}
