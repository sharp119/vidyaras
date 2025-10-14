import 'package:freezed_annotation/freezed_annotation.dart';
import 'interest.dart';
import 'learning_goal.dart';
import 'experience_level.dart';
import 'language_preference.dart';

part 'onboarding_data.freezed.dart';
part 'onboarding_data.g.dart';

/// Domain model representing user's onboarding selections
/// This data is used for personalized course recommendations
@freezed
class OnboardingData with _$OnboardingData {
  const factory OnboardingData({
    /// Selected interests (Music, Wellness, Yoga, etc.)
    required List<Interest> interests,

    /// Selected learning goals (Hobby, Professional, etc.)
    required List<LearningGoal> learningGoals,

    /// Selected experience level
    required ExperienceLevel experienceLevel,

    /// Selected language preference
    required LanguagePreference languagePreference,

    /// Timestamp when onboarding was completed
    DateTime? completedAt,
  }) = _OnboardingData;

  factory OnboardingData.fromJson(Map<String, dynamic> json) =>
      _$OnboardingDataFromJson(json);

  /// Create an empty onboarding data object
  factory OnboardingData.empty() => const OnboardingData(
        interests: [],
        learningGoals: [],
        experienceLevel: ExperienceLevel.beginner,
        languagePreference: LanguagePreference.english,
      );
}
