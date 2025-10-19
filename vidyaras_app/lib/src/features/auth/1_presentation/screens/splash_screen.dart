import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../2_application/providers/auth_providers.dart';

/// Splash Screen - App Entry Point
/// Checks authentication status and routes accordingly
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    print('🔍 Starting auth check...');

    // Wait a bit for splash effect
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    try {
      print('📱 Checking current user from provider...');
      // Check if user is logged in
      final currentUserAsync = await ref.read(currentUserProvider.future);
      print('📥 Current user result: $currentUserAsync');

      if (!mounted) return;

      if (currentUserAsync == null) {
        // No user logged in - show intro/auth
        print('✅ No user logged in, navigating to intro');
        context.go('/intro');
      } else {
        // User is logged in - check if profile is complete
        print('✅ User found: ${currentUserAsync.phoneNumber}, name: ${currentUserAsync.name}');
        final hasCompletedProfile = currentUserAsync.name.isNotEmpty;

        if (!hasCompletedProfile) {
          // Profile incomplete - go to registration with phone number
          print('⚠️ User profile incomplete, navigating to registration');
          context.pushReplacement('/auth/register', extra: currentUserAsync.phoneNumber);
        } else {
          // Check if onboarding completed (you can add a flag in user model later)
          // For now, assume if they have a name, they're ready for home
          print('✅ User authenticated and profile complete, navigating to home');
          context.go('/home');
        }
      }
    } catch (error) {
      // Error loading user, go to intro
      print('Error loading user: $error');
      if (!mounted) return;
      context.go('/intro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primary,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),

              // App Name
              const Text(
                'VidyaRas',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // Tagline
              const Text(
                'Learn Traditional Arts',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 48),

              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
