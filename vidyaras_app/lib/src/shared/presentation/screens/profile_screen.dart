import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../features/home/2_application/notifiers/home_notifier.dart';
import '../theme/app_colors.dart';
import '../components/cards/profile_card.dart';
import '../components/cards/referral_card.dart';
import '../widgets/profile/sections/profile_my_learning_section.dart';
import '../widgets/profile/sections/profile_settings_section.dart';
import '../widgets/profile/sections/profile_about_section.dart';
import '../widgets/profile/sections/profile_logout_button.dart';

/// Profile screen
/// Shows user profile, stats, settings, and account management
/// Refactored for better organization with extracted components
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
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
                const SizedBox(height: 20),

                // Profile Header Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ProfileCard(
                    name: userProfile.name,
                    email: userProfile.email ?? 'No email provided',
                    imageUrl: userProfile.avatarUrl,
                    isPremium: userProfile.isPremium,
                    enrolledCount: userProfile.enrolledCount,
                    completedCount: userProfile.completedCount,
                    certificatesCount: userProfile.certificatesCount,
                    onEditTap: () => _showComingSoonSnackbar(context, 'Edit Profile'),
                  ),
                ),

                const SizedBox(height: 20),

                // Referral Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ReferralCard(
                    points: userProfile.referralPoints,
                    onInviteTap: () => _handleShareReferral(context, userProfile.name),
                  ),
                ),

                // My Learning Section
                ProfileMyLearningSection(
                  enrolledCount: userProfile.enrolledCount,
                  certificatesCount: userProfile.certificatesCount,
                  onCertificatesTap: () => _showComingSoonSnackbar(context, 'Certificates'),
                ),

                // Settings Section
                const ProfileSettingsSection(),

                // About Section
                const ProfileAboutSection(),

                const SizedBox(height: 32),

                // Logout Button
                const ProfileLogoutButton(),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 24),
            const Text(
              'Unable to load profile',
              style: TextStyle(
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
            const SizedBox(height: 24),
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
    final message = '''
Join VidyaRas and explore traditional Indian arts, wellness, and personal development!

🎵 Music • 🧘 Wellness • 🎨 Arts • 💃 Dance

Use my referral code: $referralCode

Download the app and start your learning journey today!
''';

    Share.share(
      message,
      subject: 'Join VidyaRas with me!',
    );
  }

  void _showComingSoonSnackbar(BuildContext context, String feature) {
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
