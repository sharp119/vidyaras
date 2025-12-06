import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../theme/app_colors.dart';
import '../profile_list_tile.dart';
import '../profile_section_header.dart';
import '../../../../constants/app_constants.dart';
import '../../../../utils/url_launcher_helper.dart';

/// About section for profile screen
/// Contains app info, contact, privacy policy, and rating
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
                iconColor: AppColors.textSecondary,
                onTap: onPrivacyPolicyTap ??
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
                onTap: onRateAppTap ??
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.appName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Version ${AppConstants.appVersion}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.appDescription,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
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
                const SizedBox(width: 16),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.facebook,
                  'Facebook',
                  AppConstants.facebookUrl,
                ),
                const SizedBox(width: 16),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.instagram,
                  'Instagram',
                  AppConstants.instagramUrl,
                ),
                const SizedBox(width: 16),
                _buildSocialIcon(
                  context,
                  FontAwesomeIcons.youtube,
                  'YouTube',
                  AppConstants.youtubeUrl,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.copyrightText,
              style: const TextStyle(
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

  Widget _buildSocialIcon(
    BuildContext context,
    IconData icon,
    String tooltip,
    String url, {
    bool isIcon = false,
  }) {
    return InkWell(
      onTap: () => UrlLauncherHelper.launchWebUrl(url, context: context),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: isIcon
            ? Icon(
                icon,
                size: 20,
                color: AppColors.primary,
              )
            : FaIcon(
                icon,
                size: 20,
                color: AppColors.primary,
              ),
      ),
    );
  }

  void _showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Choose how you\'d like to reach us',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
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
            const SizedBox(height: 20),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
