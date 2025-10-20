// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizImpl _$$QuizImplFromJson(Map<String, dynamic> json) => _$QuizImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  courseId: json['courseId'] as String?,
  fullMarks: (json['fullMarks'] as num?)?.toInt() ?? 100,
  timeAllottedMinutes: (json['timeAllottedMinutes'] as num?)?.toInt() ?? 30,
  isPublished: json['isPublished'] as bool? ?? false,
  isPublic: json['isPublic'] as bool? ?? true,
  difficultyLevel: json['difficultyLevel'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$QuizImplToJson(_$QuizImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'courseId': instance.courseId,
      'fullMarks': instance.fullMarks,
      'timeAllottedMinutes': instance.timeAllottedMinutes,
      'isPublished': instance.isPublished,
      'isPublic': instance.isPublic,
      'difficultyLevel': instance.difficultyLevel,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
