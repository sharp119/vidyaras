import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../2_application/notifiers/onboarding_notifier.dart';
import '../../3_domain/models/language_preference.dart';
import '../../../../shared/presentation/components/cards/selectable_option_card.dart';
import '../widgets/onboarding_layout.dart';

/// Onboarding Screen 4: Language Preference Selection
/// Allows users to select their preferred language (Hindi, English, Both)
class OnboardingLanguageScreen extends ConsumerWidget {
  const OnboardingLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return OnboardingLayout(
      currentStep: 4,
      totalSteps: 4,
      title: 'Preferred language?',
      subtitle: 'You can change this anytime',
      canContinue: state.canProceed,
      isLastStep: true,
      isLoading: state.isSaving,
      onContinue: () async {
        final success = await notifier.completeOnboarding();
        if (success && context.mounted) {
          // Navigate to home screen after completing onboarding
          context.go('/home');
        } else if (!success && context.mounted) {
          // Show error if save failed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? 'Failed to save onboarding data',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      onBack: () {
        notifier.previousStep();
        context.go('/onboarding/experience');
      },
      children: [
        // Language preference options
        for (final language in LanguagePreference.values) ...[
          SelectableOptionCard(
            label: language.displayNameEnglish,
            emoji: language.emoji,
            isSelected: state.selectedLanguagePreference == language,
            onTap: () => notifier.setLanguagePreference(language),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
