// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAnswerImpl _$$UserAnswerImplFromJson(Map<String, dynamic> json) =>
    _$UserAnswerImpl(
      id: (json['id'] as num).toInt(),
      attemptId: json['attemptId'] as String,
      questionId: json['questionId'] as String,
      selectedOptionId: (json['selectedOptionId'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
      marksAwarded: (json['marksAwarded'] as num?)?.toInt() ?? 0,
      answeredAt: DateTime.parse(json['answeredAt'] as String),
    );

Map<String, dynamic> _$$UserAnswerImplToJson(_$UserAnswerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attemptId': instance.attemptId,
      'questionId': instance.questionId,
      'selectedOptionId': instance.selectedOptionId,
      'isCorrect': instance.isCorrect,
      'marksAwarded': instance.marksAwarded,
      'answeredAt': instance.answeredAt.toIso8601String(),
    };
