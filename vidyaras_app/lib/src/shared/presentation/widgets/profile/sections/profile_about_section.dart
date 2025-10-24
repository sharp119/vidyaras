import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';
import '../profile_list_tile.dart';
import '../profile_section_header.dart';

/// About section for profile screen
/// Contains app info, terms, privacy policy, and rating
class ProfileAboutSection extends StatelessWidget {
  const ProfileAboutSection({
    super.key,
    this.onAboutTap,
    this.onTermsTap,
    this.onPrivacyPolicyTap,
    this.onRateAppTap,
  });

  final VoidCallback? onAboutTap;
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyPolicyTap;
  final VoidCallback? onRateAppTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(
          title: 'About',
          icon: Icons.info_outlined,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              ProfileListTile(
                icon: Icons.info_outlined,
                title: 'About VidyaRas',
                subtitle: 'Version 1.0.0',
                iconColor: AppColors.primary,
                onTap: onAboutTap ?? () => _showAboutDialog(context),
              ),
              ProfileListTile(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                iconColor: AppColors.textSecondary,
                onTap: onTermsTap ?? () => _showComingSoon(context, 'Terms & Conditions'),
              ),
              ProfileListTile(
                icon: Icons.policy_outlined,
                title: 'Privacy Policy',
                iconColor: AppColors.textSecondary,
                onTap: onPrivacyPolicyTap ?? () => _showComingSoon(context, 'Privacy Policy'),
              ),
              ProfileListTile(
                icon: Icons.star_outlined,
                title: 'Rate on Play Store',
                iconColor: AppColors.accent,
                showDivider: false,
                onTap: onRateAppTap ?? () => _showComingSoon(context, 'Rate App'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Column(
          children: [
            Icon(
              Icons.school,
              size: 48,
              color: AppColors.primary,
            ),
            SizedBox(height: 16),
            Text(
              'VidyaRas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'A bilingual learning ecosystem for traditional Indian arts, wellness, and personal development.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              '© 2025 VidyaRas. All rights reserved.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
