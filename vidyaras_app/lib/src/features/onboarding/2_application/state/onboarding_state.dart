import 'package:freezed_annotation/freezed_annotation.dart';
import '../../3_domain/models/interest.dart';
import '../../3_domain/models/learning_goal.dart';
import '../../3_domain/models/experience_level.dart';
import '../../3_domain/models/language_preference.dart';

part 'onboarding_state.freezed.dart';

/// State class for managing onboarding progress
/// Tracks user selections across all onboarding steps
@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    /// Selected interests (Step 1)
    @Default([]) List<Interest> selectedInterests,

    /// Selected learning goals (Step 2)
    @Default([]) List<LearningGoal> selectedGoals,

    /// Selected experience level (Step 3)
    ExperienceLevel? selectedExperienceLevel,

    /// Selected language preference (Step 4)
    LanguagePreference? selectedLanguagePreference,

    /// Current step in the onboarding flow (1-4)
    @Default(1) int currentStep,

    /// Loading state for save operation
    @Default(false) bool isSaving,

    /// Error message if save fails
    String? errorMessage,
  }) = _OnboardingState;

  const OnboardingState._();

  /// Check if user can proceed to next step
  bool get canProceed {
    switch (currentStep) {
      case 1:
        return selectedInterests.isNotEmpty;
      case 2:
        return selectedGoals.isNotEmpty;
      case 3:
        return selectedExperienceLevel != null;
      case 4:
        return selectedLanguagePreference != null;
      default:
        return false;
    }
  }

  /// Get progress percentage (0.0 to 1.0)
  double get progress => currentStep / 4;

  /// Check if this is the last step
  bool get isLastStep => currentStep == 4;
}
