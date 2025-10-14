import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../2_application/notifiers/onboarding_notifier.dart';
import '../../3_domain/models/experience_level.dart';
import '../../../../shared/presentation/components/cards/selectable_option_card.dart';
import '../widgets/onboarding_layout.dart';

/// Onboarding Screen 3: Experience Level Selection
/// Allows users to select their experience level (Beginner, Intermediate, Advanced)
class OnboardingExperienceScreen extends ConsumerWidget {
  const OnboardingExperienceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return OnboardingLayout(
      currentStep: 3,
      totalSteps: 4,
      title: "What's your experience level?",
      subtitle: 'This helps us recommend the right courses',
      canContinue: state.canProceed,
      onContinue: () {
        notifier.nextStep();
        context.go('/onboarding/language');
      },
      onBack: () {
        notifier.previousStep();
        context.go('/onboarding/goals');
      },
      children: [
        // Experience level options
        for (final level in ExperienceLevel.values) ...[
          SelectableOptionCard(
            label: level.displayNameEnglish,
            emoji: level.emoji,
            isSelected: state.selectedExperienceLevel == level,
            onTap: () => notifier.setExperienceLevel(level),
          ),
          if (state.selectedExperienceLevel == level) ...[
            Padding(
              padding: const EdgeInsets.only(left: 60, top: 4, bottom: 8),
              child: Text(
                level.descriptionEnglish,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 16),
          ],
        ],
      ],
    );
  }
}
