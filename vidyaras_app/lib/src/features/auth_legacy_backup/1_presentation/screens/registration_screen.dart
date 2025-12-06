import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/app_back_button.dart';
import '../../../../shared/presentation/components/inputs/text_input_field.dart';
import '../../../../shared/presentation/components/layout/feature_icon_container.dart';
import '../../../../shared/presentation/components/typography/bilingual_text.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../2_application/notifiers/auth_notifier.dart';

/// Registration Screen
/// New users enter their profile information
class RegistrationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const RegistrationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  ConsumerState<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();

      ref.read(authNotifierProvider.notifier).registerUser(
            phoneNumber: widget.phoneNumber,
            name: name,
            email: email.isEmpty ? null : email,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    // Listen to state changes and navigate accordingly
    ref.listen(authNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        sendingOTP: () {},
        otpSent: (phoneNumber, requestId) {},
        verifyingOTP: () {},
        otpVerified: (_) {},
        registering: () {},
        authenticated: (user) {
          // User registered successfully - navigate to onboarding
          context.go('/onboarding/interests');
        },
        error: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: AppColors.error,
            ),
          );
        },
      );
    });

    final isLoading = authState.maybeWhen(
      registering: () => true,
      orElse: () => false,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(
                  onPressed: () => context.pop(),
                ),
                const SizedBox(height: 40),

                // Feature icon
                const Center(
                  child: FeatureIconContainer(
                    icon: Icons.person_add,
                    gradient: AppGradients.primary,
                    size: 100,
                    iconSize: 50,
                    iconColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                const Center(
                  child: BilingualText(
                    english: 'Complete Your Profile',
                    hindi: 'अपनी प्रोफ़ाइल पूरी करें',
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
                    spacing: 8,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Tell us a bit about yourself',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Name field
                TextInputField(
                  controller: _nameController,
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  leadingIcon: Icons.person,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 20),

                // Email field (optional)
                TextInputField(
                  controller: _emailController,
                  label: 'Email (Optional)',
                  hintText: 'your.email@example.com',
                  leadingIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),

                // Info text
                const Text(
                  'Your email will be used for important updates and notifications',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 32),

                // Register button
                PrimaryButton(
                  onPressed: isLoading ? null : _handleRegister,
                  label: 'Continue to Personalization',
                  isLoading: isLoading,
                ),
                const SizedBox(height: 24),

                // Phone number display
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          widget.phoneNumber,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
