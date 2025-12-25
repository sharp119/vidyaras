// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonContentImpl _$$LessonContentImplFromJson(Map<String, dynamic> json) =>
    _$LessonContentImpl(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      url: json['url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      orderIndex: (json['orderIndex'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LessonContentImplToJson(_$LessonContentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'type': instance.type,
      'title': instance.title,
      'url': instance.url,
      'duration': instance.duration,
      'orderIndex': instance.orderIndex,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
