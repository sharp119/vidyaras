import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/app_text_button.dart';
import '../../../../shared/presentation/components/inputs/text_input_field.dart';
import '../../../../shared/presentation/components/typography/bilingual_text.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/auth_providers.dart';

/// Phone Binding Screen
/// Mandatory screen after Google sign-in
/// Users must verify their phone number via OTP before proceeding
class PhoneBindingScreen extends ConsumerStatefulWidget {
  const PhoneBindingScreen({super.key});

  @override
  ConsumerState<PhoneBindingScreen> createState() => _PhoneBindingScreenState();
}

class _PhoneBindingScreenState extends ConsumerState<PhoneBindingScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _otpSent = false;
  String? _requestId;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const BilingualText(
          english: 'Verify Phone Number',
          hindi: 'फ़ोन नंबर सत्यापित करें',
          englishStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          hindiStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          spacing: 4,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Instruction Text
              BilingualText(
                english: _otpSent
                    ? 'Enter the 6-digit code sent to your phone'
                    : 'We need to verify your phone number to secure your account',
                hindi: _otpSent
                    ? 'अपने फ़ोन पर भेजा गया 6 अंकों का कोड दर्ज करें'
                    : 'आपके खाते को सुरक्षित रखने के लिए हमें आपके फ़ोन नंबर को सत्यापित करना होगा',
                englishStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                hindiStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textTertiary,
                ),
                alignment: CrossAxisAlignment.start,
              ),

              const SizedBox(height: 32),

              if (!_otpSent) ...[
                // Phone Input
                TextInputField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hint: '+91XXXXXXXXXX',
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone, size: 20),
                  enabled: !_isLoading,
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  text: 'Send OTP',
                  onPressed: _isLoading ? null : _sendOTP,
                  isLoading: _isLoading,
                  fullWidth: true,
                ),
              ] else ...[
                // OTP Input
                TextInputField(
                  controller: _otpController,
                  label: 'Enter OTP',
                  hint: '6-digit code',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.lock, size: 20),
                  maxLength: 6,
                  enabled: !_isLoading,
                ),

                const SizedBox(height: 16),

                // Resend OTP
                Center(
                  child: AppTextButton(
                    text: 'Resend OTP',
                    onPressed: _isLoading ? null : _sendOTP,
                  ),
                ),

                const SizedBox(height: 24),

                PrimaryButton(
                  text: 'Verify & Continue',
                  onPressed: _isLoading ? null : _verifyOTP,
                  isLoading: _isLoading,
                  fullWidth: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    final phone = _phoneController.text.trim();

    // Validate phone format
    if (!phone.startsWith('+91') || phone.length != 13) {
      _showError('Please enter a valid phone number starting with +91');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Use MSG91 service to send OTP
      final msg91Service = ref.read(msg91ServiceProvider);

      // Initialize if needed
      await msg91Service.initialize();

      final requestId = await msg91Service.sendOTP(phoneNumber: phone);

      setState(() {
        _otpSent = true;
        _requestId = requestId;
        _isLoading = false;
      });

      _showSuccess('OTP sent to $phone');
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Failed to send OTP: $e');
    }
  }

  Future<void> _verifyOTP() async {
    final otp = _otpController.text.trim();

    if (otp.length != 6) {
      _showError('Please enter the 6-digit OTP');
      return;
    }

    setState(() => _isLoading = false);

    try {
      // Verify OTP with MSG91
      final msg91Service = ref.read(msg91ServiceProvider);
      await msg91Service.verifyOTP(requestId: _requestId!, otp: otp);

      // OTP verified! Now update profiles table
      await _updatePhoneInProfile(_phoneController.text.trim());
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Verification failed: $e');
    }
  }

  Future<void> _updatePhoneInProfile(String verifiedPhone) async {
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final result = await authRepository.updatePhoneNumber(verifiedPhone);

      result.fold(
        (error) {
          // Failed to update phone
          setState(() => _isLoading = false);
          _showError(error);
        },
        (_) {
          // Phone updated successfully
          setState(() => _isLoading = false);

          // Navigate to onboarding
          if (mounted) {
            context.go('/onboarding/interests');
          }
        },
      );
    } catch (e) {
      setState(() => _isLoading = false);
      _showError('Unexpected error: $e');
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

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
