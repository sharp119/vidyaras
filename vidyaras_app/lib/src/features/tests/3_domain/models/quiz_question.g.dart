// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizQuestionImpl _$$QuizQuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuizQuestionImpl(
      id: json['id'] as String,
      quizId: json['quizId'] as String,
      questionNumber: (json['questionNumber'] as num).toInt(),
      questionData: ContentData.fromJson(
        json['questionData'] as Map<String, dynamic>,
      ),
      options: (json['options'] as List<dynamic>)
          .map((e) => QuizOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctOptionId: (json['correctOptionId'] as num).toInt(),
      explanation: json['explanation'] == null
          ? null
          : ContentData.fromJson(json['explanation'] as Map<String, dynamic>),
      marks: (json['marks'] as num?)?.toInt() ?? 1,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$QuizQuestionImplToJson(_$QuizQuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quizId': instance.quizId,
      'questionNumber': instance.questionNumber,
      'questionData': instance.questionData,
      'options': instance.options,
      'correctOptionId': instance.correctOptionId,
      'explanation': instance.explanation,
      'marks': instance.marks,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
