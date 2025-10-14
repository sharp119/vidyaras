import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../2_application/notifiers/onboarding_notifier.dart';
import '../../3_domain/models/interest.dart';
import '../../../../shared/presentation/components/cards/selectable_option_card.dart';
import '../widgets/onboarding_layout.dart';

/// Onboarding Screen 1: Interest Selection
/// Allows users to select their areas of interest (Music, Wellness, Yoga, etc.)
class OnboardingInterestsScreen extends ConsumerWidget {
  const OnboardingInterestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return OnboardingLayout(
      currentStep: 1,
      totalSteps: 4,
      title: 'What interests you?',
      subtitle: 'Select all that apply',
      canContinue: state.canProceed,
      onContinue: () {
        notifier.nextStep();
        context.go('/onboarding/goals');
      },
      children: [
        // Interest options
        for (final interest in Interest.values) ...[
          SelectableOptionCard(
            label: interest.displayNameEnglish,
            emoji: interest.emoji,
            isSelected: state.selectedInterests.contains(interest),
            onTap: () => notifier.toggleInterest(interest),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
