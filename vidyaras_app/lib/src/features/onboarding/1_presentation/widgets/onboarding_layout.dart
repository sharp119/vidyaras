import 'package:flutter/material.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../../../shared/presentation/components/progress/step_indicator.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';

/// Common layout for onboarding screens
/// Design System: Theme-based typography, proper spacing
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with app name and language toggle
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.mdLg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'VidyaRas',
                    style: theme.textTheme.headlineLarge?.copyWith(
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
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Step Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.mdLg),
              child: StepIndicator(
                currentStep: currentStep,
                totalSteps: totalSteps,
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.mdLg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Subtitle
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Custom content
                    ...children,
                  ],
                ),
              ),
            ),

            // Bottom navigation buttons
            Padding(
              padding: const EdgeInsets.all(AppSpacing.mdLg),
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
                    const SizedBox(width: AppSpacing.md),
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
