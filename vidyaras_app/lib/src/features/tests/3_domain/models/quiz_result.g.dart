// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizResultImpl _$$QuizResultImplFromJson(Map<String, dynamic> json) =>
    _$QuizResultImpl(
      testId: json['testId'] as String,
      testTitle: json['testTitle'] as String,
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      correctAnswers: (json['correctAnswers'] as num).toInt(),
      score: (json['score'] as num).toInt(),
      completedAt: DateTime.parse(json['completedAt'] as String),
      timeTakenMinutes: (json['timeTakenMinutes'] as num).toInt(),
    );

Map<String, dynamic> _$$QuizResultImplToJson(_$QuizResultImpl instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'testTitle': instance.testTitle,
      'totalQuestions': instance.totalQuestions,
      'correctAnswers': instance.correctAnswers,
      'score': instance.score,
      'completedAt': instance.completedAt.toIso8601String(),
      'timeTakenMinutes': instance.timeTakenMinutes,
    };
