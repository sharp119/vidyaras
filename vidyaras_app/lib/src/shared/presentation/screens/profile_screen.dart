import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../features/home/2_application/notifiers/home_notifier.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../components/cards/profile_card.dart';
import '../components/cards/referral_card.dart';
import '../widgets/profile/sections/profile_my_learning_section.dart';
import '../widgets/profile/sections/profile_settings_section.dart';
import '../widgets/profile/sections/profile_about_section.dart';
import '../widgets/profile/sections/profile_logout_button.dart';

/// Profile screen
/// Design System: Theme-based typography, proper spacing
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: theme.textTheme.headlineLarge, // H1: 24sp
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: false,
      ),
      body: homeState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => _buildErrorState(context, ref, message),
        loaded: (homeData) {
          final userProfile = homeData.userProfile;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.lg),

                // Profile Header Card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: ProfileCard(
                    name: userProfile.name,
                    email: userProfile.email ?? 'No email provided',
                    imageUrl: userProfile.avatarUrl,
                    isPremium: userProfile.isPremium,
                    enrolledCount: userProfile.enrolledCount,
                    completedCount: userProfile.completedCount,
                    certificatesCount: userProfile.certificatesCount,
                    onEditTap: () => context.push('/profile/edit'),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Referral Card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: ReferralCard(
                    points: userProfile.referralPoints,
                    onInviteTap: () =>
                        _handleShareReferral(context, userProfile.name),
                  ),
                ),

                // My Learning Section
                ProfileMyLearningSection(
                  enrolledCount: userProfile.enrolledCount,
                  certificatesCount: userProfile.certificatesCount,
                  onCertificatesTap: () =>
                      _showComingSoonSnackbar(context, 'Certificates'),
                ),

                ProfileSettingsSection(
                  onAccountSettingsTap: () => context.push('/profile/edit'),
                ),

                // About Section
                const ProfileAboutSection(),

                const SizedBox(height: AppSpacing.lg),

                // Logout Button
                const ProfileLogoutButton(),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String message) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: AppSpacing.mdLg),
            Text(
              'Unable to load profile',
              style: theme.textTheme.headlineMedium,
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
            const SizedBox(height: AppSpacing.mdLg),
            ElevatedButton(
              onPressed: () {
                ref.read(homeNotifierProvider.notifier).loadHomeData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleShareReferral(BuildContext context, String userName) {
    final referralCode = userName.toUpperCase().replaceAll(' ', '');
    final message =
        '''
Join VidyaRas and explore traditional Indian arts, wellness, and personal development!

🎵 Music • 🧘 Wellness • 🎨 Arts • 💃 Dance

Use my referral code: $referralCode

Download the app and start your learning journey today!
''';

    Share.share(message, subject: 'Join VidyaRas with me!');
  }

  void _showComingSoonSnackbar(BuildContext context, String feature) {
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
