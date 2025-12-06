import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/components/buttons/social_login_button.dart';
import '../../../../shared/presentation/components/typography/bilingual_text.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/auth_providers.dart';

/// Google Login Screen
/// Entry point for authentication - users sign in with Google OAuth
class GoogleLoginScreen extends ConsumerStatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  ConsumerState<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends ConsumerState<GoogleLoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              // TODO: Replace with actual logo asset
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.music_note,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 48),

              // Welcome Text (Bilingual)
              const BilingualText(
                english: 'Welcome to VidyaRas',
                hindi: 'विद्यारास में आपका स्वागत है',
                englishStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                hindiStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 16),

              // Subtitle
              const BilingualText(
                english: 'Traditional Indian Arts & Wellness',
                hindi: 'पारंपरिक भारतीय कला और कल्याण',
                englishStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                hindiStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textTertiary,
                ),
                spacing: 4,
              ),

              const Spacer(),

              // Google Sign-In Button
              if (_isLoading)
                const CircularProgressIndicator()
              else
                SocialLoginButton(
                  label: 'Continue with Google',
                  icon: SvgPicture.asset(
                    'assets/svgs/google_logo.svg',
                    width: 24,
                    height: 24,
                  ),
                  onPressed: _handleGoogleSignIn,
                ),

              const SizedBox(height: 24),

              // Terms & Privacy
              const Text(
                'By continuing, you agree to our Terms & Privacy Policy',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      final authRepository = ref.read(authRepositoryProvider);
      final result = await authRepository.signInWithGoogle();

      result.fold(
        (error) {
          // Sign-in failed
          if (mounted) {
            setState(() => _isLoading = false);
            _showError(error);
          }
        },
        (user) {
          // Sign-in successful
          // Note: After successful OAuth, user is redirected back to app
          // Splash screen routing logic will handle navigation based on user state
          // (phone verification, onboarding, etc.)
          if (mounted) {
            setState(() => _isLoading = false);
            // The splash screen routing will handle navigation
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showError('Unexpected error: $e');
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
