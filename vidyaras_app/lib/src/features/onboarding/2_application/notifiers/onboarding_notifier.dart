import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/models/interest.dart';
import '../../3_domain/models/learning_goal.dart';
import '../../3_domain/models/experience_level.dart';
import '../../3_domain/models/language_preference.dart';
import '../../3_domain/models/onboarding_data.dart';
import '../providers/onboarding_providers.dart';
import '../state/onboarding_state.dart';

part 'onboarding_notifier.g.dart';

/// Notifier for managing onboarding flow state
/// Handles user selections and navigation between onboarding steps
@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  /// Toggle interest selection
  void toggleInterest(Interest interest) {
    final currentInterests = state.selectedInterests;
    final newInterests = currentInterests.contains(interest)
        ? currentInterests.where((i) => i != interest).toList()
        : [...currentInterests, interest];

    state = state.copyWith(selectedInterests: newInterests);
  }

  /// Toggle learning goal selection
  void toggleGoal(LearningGoal goal) {
    final currentGoals = state.selectedGoals;
    final newGoals = currentGoals.contains(goal)
        ? currentGoals.where((g) => g != goal).toList()
        : [...currentGoals, goal];

    state = state.copyWith(selectedGoals: newGoals);
  }

  /// Set experience level
  void setExperienceLevel(ExperienceLevel level) {
    state = state.copyWith(selectedExperienceLevel: level);
  }

  /// Set language preference
  void setLanguagePreference(LanguagePreference preference) {
    state = state.copyWith(selectedLanguagePreference: preference);
  }

  /// Navigate to next step
  void nextStep() {
    if (state.canProceed && !state.isLastStep) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  /// Navigate to previous step
  void previousStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  /// Go to specific step
  void goToStep(int step) {
    if (step >= 1 && step <= 4) {
      state = state.copyWith(currentStep: step);
    }
  }

  /// Save onboarding data and complete onboarding
  /// Returns true if successful, false otherwise
  Future<bool> completeOnboarding() async {
    if (!state.canProceed || !state.isLastStep) {
      return false;
    }

    state = state.copyWith(isSaving: true, errorMessage: null);

    final repository = ref.read(onboardingRepositoryProvider);

    final onboardingData = OnboardingData(
      interests: state.selectedInterests,
      learningGoals: state.selectedGoals,
      experienceLevel: state.selectedExperienceLevel!,
      languagePreference: state.selectedLanguagePreference!,
      completedAt: DateTime.now(),
    );

    final result = await repository.saveOnboardingData(onboardingData);

    return result.fold(
      (failure) {
        state = state.copyWith(
          isSaving: false,
          errorMessage: failure.message,
        );
        return false;
      },
      (_) {
        state = state.copyWith(isSaving: false);
        return true;
      },
    );
  }

  /// Reset onboarding state
  void reset() {
    state = const OnboardingState();
  }
}
