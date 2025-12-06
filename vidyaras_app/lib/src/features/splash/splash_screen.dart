import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../shared/presentation/theme/app_colors.dart';
import '../../shared/presentation/theme/app_gradients.dart';

/// Splash Screen - App Entry Point
/// Implements 4-gate routing logic for Google OAuth flow:
/// GATE 1: Check Supabase session → null? → /login
/// GATE 2: Fetch profile → null? → sign out + /login
/// GATE 3: Check phone_number → null? → /phone-binding
/// GATE 4: Check is_onboarded → false? → /onboarding/interests
/// All gates passed → /home
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.primary),
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

  Future<void> _checkAuthAndRoute() async {
    // Small delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final supabase = Supabase.instance.client;

    try {
      // GATE 1: Check Supabase session
      final session = supabase.auth.currentSession;
      if (session == null) {
        print('🚪 GATE 1: No session → Navigate to /intro');
        if (mounted) context.go('/intro');
        return;
      }

      print('✅ GATE 1 PASSED: Session exists for ${session.user.email}');

      // GATE 2: Fetch profile from profiles table
      final profile = await supabase
          .from('profiles')
          .select()
          .eq('id', session.user.id)
          .maybeSingle();

      if (profile == null) {
        // This shouldn't happen (trigger auto-creates profile)
        // But handle gracefully by signing out and forcing re-login
        print('⚠️ GATE 2: Profile not found → Sign out and retry');
        await supabase.auth.signOut();
        if (mounted) context.go('/login');
        return;
      }

      print('✅ GATE 2 PASSED: Profile found for user ${profile['email']}');

      // GATE 3: Check phone verification
      if (profile['phone_number'] == null) {
        print('🚪 GATE 3: No phone number → Navigate to /phone-binding');
        if (mounted) context.go('/phone-binding');
        return;
      }

      print('✅ GATE 3 PASSED: Phone verified (${profile['phone_number']})');

      // GATE 4: Check onboarding completion
      if (profile['is_onboarded'] != true) {
        print('🚪 GATE 4: Not onboarded → Navigate to /onboarding/interests');
        if (mounted) context.go('/onboarding/interests');
        return;
      }

      print('✅ GATE 4 PASSED: User is onboarded');

      // All gates passed → Home
      print('🎉 ALL GATES PASSED → Navigate to /home');
      if (mounted) context.go('/home');
    } catch (e) {
      // Error fetching profile - sign out and restart
      print('❌ ERROR in routing: $e');
      await supabase.auth.signOut();
      if (mounted) context.go('/login');
    }
  }
}
