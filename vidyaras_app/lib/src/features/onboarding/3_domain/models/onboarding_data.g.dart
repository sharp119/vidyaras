// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingDataImpl _$$OnboardingDataImplFromJson(Map<String, dynamic> json) =>
    _$OnboardingDataImpl(
      interests: (json['interests'] as List<dynamic>)
          .map((e) => $enumDecode(_$InterestEnumMap, e))
          .toList(),
      learningGoals: (json['learningGoals'] as List<dynamic>)
          .map((e) => $enumDecode(_$LearningGoalEnumMap, e))
          .toList(),
      experienceLevel: $enumDecode(
        _$ExperienceLevelEnumMap,
        json['experienceLevel'],
      ),
      languagePreference: $enumDecode(
        _$LanguagePreferenceEnumMap,
        json['languagePreference'],
      ),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$OnboardingDataImplToJson(
  _$OnboardingDataImpl instance,
) => <String, dynamic>{
  'interests': instance.interests.map((e) => _$InterestEnumMap[e]!).toList(),
  'learningGoals': instance.learningGoals
      .map((e) => _$LearningGoalEnumMap[e]!)
      .toList(),
  'experienceLevel': _$ExperienceLevelEnumMap[instance.experienceLevel]!,
  'languagePreference':
      _$LanguagePreferenceEnumMap[instance.languagePreference]!,
  'completedAt': instance.completedAt?.toIso8601String(),
};

const _$InterestEnumMap = {
  Interest.music: 'music',
  Interest.wellness: 'wellness',
  Interest.yoga: 'yoga',
  Interest.artsDance: 'artsDance',
  Interest.lifeSkills: 'lifeSkills',
};

const _$LearningGoalEnumMap = {
  LearningGoal.exams: 'exams',
  LearningGoal.hobby: 'hobby',
  LearningGoal.professional: 'professional',
  LearningGoal.cultural: 'cultural',
  LearningGoal.wellness: 'wellness',
};

const _$ExperienceLevelEnumMap = {
  ExperienceLevel.beginner: 'beginner',
  ExperienceLevel.intermediate: 'intermediate',
  ExperienceLevel.advanced: 'advanced',
};

const _$LanguagePreferenceEnumMap = {
  LanguagePreference.hindi: 'hindi',
  LanguagePreference.english: 'english',
  LanguagePreference.both: 'both',
};
