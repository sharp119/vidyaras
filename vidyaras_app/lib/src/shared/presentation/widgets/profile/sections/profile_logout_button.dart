import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../features/auth/2_application/notifiers/auth_notifier.dart';
import '../../../theme/app_colors.dart';
import '../logout_confirmation_dialog.dart';

/// Logout button for profile screen
/// Shows confirmation dialog before logging out
class ProfileLogoutButton extends ConsumerWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton.icon(
        onPressed: () => _handleLogout(context, ref),
        icon: const Icon(Icons.logout, color: AppColors.error),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.error,
          ),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: AppColors.error, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context, WidgetRef ref) {
    showLogoutDialog(
      context,
      onConfirm: () async {
        // Show loading indicator
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('Logging out...'),
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: AppColors.primary,
            ),
          );
        }

        // Perform logout
        final authNotifier = ref.read(authNotifierProvider.notifier);
        await authNotifier.signOut();

        // Navigate to auth screen
        if (context.mounted) {
          context.go('/auth');
        }
      },
    );
  }
}
