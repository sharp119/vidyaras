import 'package:flutter/material.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../../../shared/presentation/components/progress/step_indicator.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Common layout for onboarding screens
/// Provides consistent structure with header, step indicator, and navigation buttons
class OnboardingLayout extends StatelessWidget {
  const OnboardingLayout({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.onContinue,
    this.onBack,
    this.canContinue = true,
    this.isLastStep = false,
    this.isLoading = false,
    this.showLanguageToggle = true,
  });

  final int currentStep;
  final int totalSteps;
  final String title;
  final String subtitle;
  final List<Widget> children;
  final VoidCallback onContinue;
  final VoidCallback? onBack;
  final bool canContinue;
  final bool isLastStep;
  final bool isLoading;
  final bool showLanguageToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with app name and language toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VidyaRas',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accent,
                    ),
                  ),
                  if (showLanguageToggle)
                    TextButton(
                      onPressed: () {
                        // TODO: Toggle language
                      },
                      child: Text(
                        'हिंदी',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Step Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: StepIndicator(
                currentStep: currentStep,
                totalSteps: totalSteps,
              ),
            ),

            const SizedBox(height: 32),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Custom content
                    ...children,
                  ],
                ),
              ),
            ),

            // Bottom navigation buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Back button (show if not first step)
                  if (onBack != null) ...[
                    Expanded(
                      child: SecondaryButton(
                        onPressed: onBack,
                        label: 'Back',
                        fullWidth: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],

                  // Continue/Complete button
                  Expanded(
                    flex: onBack != null ? 1 : 2,
                    child: PrimaryButton(
                      onPressed: canContinue ? onContinue : null,
                      label: isLastStep ? 'Complete' : 'Continue',
                      fullWidth: true,
                      isLoading: isLoading,
                      icon: isLastStep ? null : Icons.arrow_forward,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
