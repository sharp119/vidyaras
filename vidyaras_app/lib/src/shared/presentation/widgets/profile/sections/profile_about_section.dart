import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../profile_list_tile.dart';
import '../profile_section_header.dart';
import '../../../../constants/app_constants.dart';
import '../../../../utils/url_launcher_helper.dart';

/// About section for profile screen
/// Design System: Theme typography, proper spacing
class ProfileAboutSection extends StatelessWidget {
  const ProfileAboutSection({
    super.key,
    this.onAboutTap,
    this.onContactTap,
    this.onPrivacyPolicyTap,
    this.onRateAppTap,
  });

  final VoidCallback? onAboutTap;
  final VoidCallback? onContactTap;
  final VoidCallback? onPrivacyPolicyTap;
  final VoidCallback? onRateAppTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(title: 'About', icon: Icons.info_outlined),
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
                icon: Icons.info_outlined,
                title: 'About VidyaRas',
                subtitle: 'Version ${AppConstants.appVersion}',
                iconColor: AppColors.primary,
                onTap: onAboutTap ?? () => _showAboutDialog(context),
              ),
              ProfileListTile(
                icon: Icons.contact_support_outlined,
                title: 'Contact Us',
                subtitle: 'Get in touch with us',
                iconColor: AppColors.accent,
                onTap: onContactTap ?? () => _showContactOptions(context),
              ),
              ProfileListTile(
                icon: Icons.policy_outlined,
                title: 'Privacy Policy',
                onTap:
                    onPrivacyPolicyTap ??
                    () => UrlLauncherHelper.launchWebUrl(
                      AppConstants.privacyPolicyUrl,
                      context: context,
                    ),
              ),
              ProfileListTile(
                icon: Icons.star_outlined,
                title: 'Rate on Play Store',
                iconColor: AppColors.accent,
                showDivider: false,
                onTap:
                    onRateAppTap ??
                    () => UrlLauncherHelper.launchAppStore(
                      playStoreUrl: AppConstants.playStoreUrl,
                      appStoreUrl: AppConstants.appStoreUrl,
                      context: context,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.mdSm),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school,
                size: AppIconSize.large,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.appName,
              style: theme.textTheme.headlineLarge, // H1: 24sp
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Version ${AppConstants.appVersion}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.appDescription,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.mdLg),
            // Social Media Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(
                  context,
                  Icons.public,
                  'Website',
                  AppConstants.companyWebsite,
                  isIcon: true,
                ),
                const SizedBox(width: AppSpacing.md),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.facebook,
                  'Facebook',
                  AppConstants.facebookUrl,
                ),
                const SizedBox(width: AppSpacing.md),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.instagram,
                  'Instagram',
                  AppConstants.instagramUrl,
                ),
                const SizedBox(width: AppSpacing.md),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.youtube,
                  'YouTube',
                  AppConstants.youtubeUrl,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              AppConstants.copyrightText,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
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

  Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    String tooltip,
    String url, {
    bool isIcon = false,
  }) {
    return InkWell(
      onTap: () => UrlLauncherHelper.launchWebUrl(url, context: context),
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        child: isIcon
            ? Icon(icon, size: AppIconSize.small, color: AppColors.primary)
            : FaIcon(icon, size: AppIconSize.small, color: AppColors.primary),
      ),
    );
  }

  void _showContactOptions(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Contact Us',
                style: theme.textTheme.headlineMedium, // H2: 20sp
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: Text(
                'Choose how you\'d like to reach us',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.mdLg),
            _buildContactOption(
              context,
              icon: Icons.email_outlined,
              title: 'Email',
              subtitle: AppConstants.supportEmail,
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.launchEmail(
                  email: AppConstants.supportEmail,
                  subject: 'Support Request - VidyaRas App',
                  context: context,
                );
              },
            ),
            const SizedBox(height: AppSpacing.mdSm),
            _buildContactOption(
              context,
              icon: Icons.phone_outlined,
              title: 'Phone',
              subtitle: AppConstants.phoneNumber,
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.launchPhone(
                  AppConstants.phoneNumber,
                  context: context,
                );
              },
            ),
            const SizedBox(height: AppSpacing.mdSm),
            _buildContactOption(
              context,
              icon: Icons.chat_outlined,
              title: 'WhatsApp',
              subtitle: 'Chat with us on WhatsApp',
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.launchWhatsApp(
                  AppConstants.whatsappUrl,
                  context: context,
                );
              },
            ),
            const SizedBox(height: AppSpacing.mdSm),
            _buildContactOption(
              context,
              icon: Icons.language_outlined,
              title: 'Website',
              subtitle: 'Visit our contact page',
              onTap: () {
                Navigator.pop(context);
                UrlLauncherHelper.launchWebUrl(
                  AppConstants.contactUsUrl,
                  context: context,
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm + 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.sm + 2),
              ),
              child: Icon(
                icon,
                size: AppIconSize.standard,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge, // 16sp
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: AppIconSize.small,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
