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

/// Phone Authentication Screen
/// Entry point for authentication flow
/// Users enter their phone number to receive OTP
class PhoneAuthScreen extends ConsumerStatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  ConsumerState<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends ConsumerState<PhoneAuthScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      final phoneNumber = _phoneController.text.trim();
      // Format phone number with country code if not present
      final formattedPhone =
          phoneNumber.startsWith('+') ? phoneNumber : '+91$phoneNumber';

      // Send OTP
      ref.read(authNotifierProvider.notifier).sendOTP(formattedPhone);
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
        otpSent: (phoneNumber, requestId) {
          // Navigate to OTP verification screen with both phone and requestId
          context.push('/auth/verify-otp', extra: {
            'phoneNumber': phoneNumber,
            'requestId': requestId,
          });
        },
        verifyingOTP: () {},
        otpVerified: (_) {},
        registering: () {},
        authenticated: (_) {},
        error: (message) {
          // Show error message
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
      sendingOTP: () => true,
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
                    icon: Icons.music_note,
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
                    english: 'Welcome Back!',
                    hindi: 'वापसी पर स्वागत है!',
                    englishStyle: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    hindiStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                    spacing: 8,
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Sign in to continue your learning journey',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),

                // Phone number field
                TextInputField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hintText: '1234567890',
                  leadingIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length < 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  enabled: !isLoading,
                ),
                const SizedBox(height: 16),

                // Info text
                const Text(
                  'We will send you an OTP to verify your number',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 32),

                // Continue button
                PrimaryButton(
                  onPressed: isLoading ? null : _handleContinue,
                  label: 'Continue',
                  isLoading: isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
