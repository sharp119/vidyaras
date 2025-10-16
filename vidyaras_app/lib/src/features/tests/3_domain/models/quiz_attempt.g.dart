// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizAttemptImpl _$$QuizAttemptImplFromJson(Map<String, dynamic> json) =>
    _$QuizAttemptImpl(
      testId: json['testId'] as String,
      testTitle: json['testTitle'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentQuestionIndex: (json['currentQuestionIndex'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      userAnswers: (json['userAnswers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$$QuizAttemptImplToJson(
  _$QuizAttemptImpl instance,
) => <String, dynamic>{
  'testId': instance.testId,
  'testTitle': instance.testTitle,
  'questions': instance.questions,
  'currentQuestionIndex': instance.currentQuestionIndex,
  'totalQuestions': instance.totalQuestions,
  'durationMinutes': instance.durationMinutes,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime?.toIso8601String(),
  'userAnswers': instance.userAnswers?.map((k, e) => MapEntry(k.toString(), e)),
};
