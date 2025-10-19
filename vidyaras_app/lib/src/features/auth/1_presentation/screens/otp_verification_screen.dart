import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/app_text_button.dart';
import '../../../../shared/presentation/components/buttons/app_back_button.dart';
import '../../../../shared/presentation/components/layout/feature_icon_container.dart';
import '../../../../shared/presentation/components/typography/bilingual_text.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../2_application/notifiers/auth_notifier.dart';

/// OTP Verification Screen
/// Users enter the 6-digit OTP sent to their phone
class OTPVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String requestId;

  const OTPVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.requestId,
  });

  @override
  ConsumerState<OTPVerificationScreen> createState() =>
      _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends ConsumerState<OTPVerificationScreen> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<FocusNode> _keyboardFocusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Add listeners to each controller to handle input properly
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].addListener(() => _onOTPChanged(i));
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var node in _keyboardFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otpCode {
    return _otpControllers.map((c) => c.text).join();
  }

  void _onOTPChanged(int index) {
    final text = _otpControllers[index].text;

    // If more than 1 character, keep only the last one
    if (text.length > 1) {
      _otpControllers[index].text = text.substring(text.length - 1);
      _otpControllers[index].selection = TextSelection.fromPosition(
        TextPosition(offset: _otpControllers[index].text.length),
      );
    }
  }

  void _handleVerifyOTP() {
    final otp = _otpCode;
    if (otp.length == 6) {
      ref.read(authNotifierProvider.notifier).verifyOTP(
            requestId: widget.requestId,
            otp: otp,
            phoneNumber: widget.phoneNumber,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter complete OTP'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _handleResendOTP() {
    // Clear all OTP fields
    for (var controller in _otpControllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();

    // Resend OTP
    ref.read(authNotifierProvider.notifier).sendOTP(widget.phoneNumber);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP sent successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
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
        otpVerified: (authResult) {
          if (authResult.needsRegistration) {
            // New user - navigate to registration
            context.pushReplacement(
              '/auth/register',
              extra: widget.phoneNumber,
            );
          } else {
            // Existing user - check if needs onboarding
            if (authResult.needsOnboarding) {
              context.go('/onboarding/interests');
            } else {
              context.go('/home');
            }
          }
        },
        registering: () {},
        authenticated: (_) {},
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
      verifyingOTP: () => true,
      orElse: () => false,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
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
                  icon: Icons.lock_outline,
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
                  english: 'Verify OTP',
                  hindi: 'OTP सत्यापित करें',
                  englishStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  hindiStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  spacing: 8,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Enter the 6-digit code sent to\n${widget.phoneNumber}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),

              // OTP input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    height: 60,
                    child: KeyboardListener(
                      focusNode: _keyboardFocusNodes[index],
                      onKeyEvent: (event) {
                        // Handle backspace on empty field
                        if (event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.backspace) {
                          if (_otpControllers[index].text.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        }
                      },
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        enabled: !isLoading,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A), // Dark color for visibility
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.border,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: AppColors.border.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            // Move to next field if not last
                            if (index < 5) {
                              _focusNodes[index + 1].requestFocus();
                            } else {
                              // Last field - unfocus and auto-submit
                              _focusNodes[index].unfocus();
                              if (_otpCode.length == 6) {
                                _handleVerifyOTP();
                              }
                            }
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              // Verify button
              PrimaryButton(
                onPressed: isLoading ? null : _handleVerifyOTP,
                label: 'Verify & Continue',
                isLoading: isLoading,
              ),
              const SizedBox(height: 24),

              // Resend OTP
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Didn't receive OTP? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    AppTextButton(
                      onPressed: isLoading ? null : _handleResendOTP,
                      label: 'Resend',
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Development note
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Development Mode',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Enter OTP: 123456\n+911234567890 is a registered user\nAll other numbers are new users',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
