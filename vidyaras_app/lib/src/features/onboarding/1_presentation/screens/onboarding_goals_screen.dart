import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../2_application/notifiers/onboarding_notifier.dart';
import '../../3_domain/models/learning_goal.dart';
import '../../../../shared/presentation/components/cards/selectable_option_card.dart';
import '../widgets/onboarding_layout.dart';

/// Onboarding Screen 2: Learning Goals Selection
/// Allows users to select their learning goals (Exams, Hobby, Professional, etc.)
class OnboardingGoalsScreen extends ConsumerWidget {
  const OnboardingGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return OnboardingLayout(
      currentStep: 2,
      totalSteps: 4,
      title: 'What are your learning goals?',
      subtitle: 'Help us personalize your experience',
      canContinue: state.canProceed,
      onContinue: () {
        notifier.nextStep();
        context.go('/onboarding/experience');
      },
      onBack: () {
        notifier.previousStep();
        context.go('/onboarding/interests');
      },
      children: [
        // Learning goal options
        for (final goal in LearningGoal.values) ...[
          SelectableOptionCard(
            label: goal.displayNameEnglish,
            emoji: goal.emoji,
            isSelected: state.selectedGoals.contains(goal),
            onTap: () => notifier.toggleGoal(goal),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
