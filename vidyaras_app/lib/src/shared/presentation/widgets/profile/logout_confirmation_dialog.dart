import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../components/buttons/primary_button.dart';
import '../../components/buttons/secondary_button.dart';

/// Confirmation dialog for logout action
class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({
    super.key,
    required this.onConfirm,
  });

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Row(
        children: [
          Icon(
            Icons.logout,
            color: AppColors.error,
            size: 24,
          ),
          SizedBox(width: 12),
          Text(
            'Logout?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: const Text(
        'Are you sure you want to logout? You will need to sign in again to access your courses.',
        style: TextStyle(
          fontSize: 16,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  label: 'Cancel',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 12),
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
