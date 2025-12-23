import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../profile_list_tile.dart';
import '../profile_section_header.dart';

/// Settings section for profile screen
/// Design System: Theme typography, proper spacing
class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({
    super.key,
    this.onAccountSettingsTap,
    this.onNotificationsTap,
    this.onLanguageTap,
    this.onPrivacyTap,
    this.onHelpSupportTap,
  });

  final VoidCallback? onAccountSettingsTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onLanguageTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onHelpSupportTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(
          title: 'Settings',
          icon: Icons.settings_outlined,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.card),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              ProfileListTile(
                icon: Icons.person_outline,
                title: 'Account Settings',
                subtitle: 'Edit profile, change password',
                iconColor: AppColors.primary,
                onTap:
                    onAccountSettingsTap ??
                    () => _showComingSoon(context, 'Account Settings'),
              ),
              ProfileListTile(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Manage notification preferences',
                iconColor: AppColors.accent,
                onTap:
                    onNotificationsTap ??
                    () => _showComingSoon(context, 'Notifications'),
              ),
              ProfileListTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English / हिंदी',
                iconColor: AppColors.success,
                onTap:
                    onLanguageTap ??
                    () => _showComingSoon(context, 'Language Settings'),
              ),
              ProfileListTile(
                icon: Icons.lock_outlined,
                title: 'Privacy & Security',
                subtitle: 'Password, data, permissions',
                iconColor: AppColors.error,
                onTap:
                    onPrivacyTap ??
                    () => _showComingSoon(context, 'Privacy & Security'),
              ),
              ProfileListTile(
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'FAQs, contact us',
                iconColor: const Color(0xFF8B5CF6), // Purple
                showDivider: false,
                onTap: onHelpSupportTap ?? () => _handleHelpSupport(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleHelpSupport(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@vidyaras.com',
      queryParameters: {'subject': 'VidyaRas Support Request'},
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (context.mounted) {
        _showComingSoon(context, 'Help & Support');
      }
    }
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
    );
  }
}
