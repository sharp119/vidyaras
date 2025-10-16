// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestImpl _$$TestImplFromJson(Map<String, dynamic> json) => _$TestImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  titleHindi: json['titleHindi'] as String,
  category: json['category'] as String,
  difficulty: json['difficulty'] as String,
  questionCount: (json['questionCount'] as num).toInt(),
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  bestScore: json['bestScore'] as String?,
  isCompleted: json['isCompleted'] as bool?,
);

Map<String, dynamic> _$$TestImplToJson(_$TestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleHindi': instance.titleHindi,
      'category': instance.category,
      'difficulty': instance.difficulty,
      'questionCount': instance.questionCount,
      'durationMinutes': instance.durationMinutes,
      'bestScore': instance.bestScore,
      'isCompleted': instance.isCompleted,
    };
