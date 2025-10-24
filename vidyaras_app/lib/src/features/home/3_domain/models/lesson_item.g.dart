// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonItemImpl _$$LessonItemImplFromJson(Map<String, dynamic> json) =>
    _$LessonItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      isLocked: json['isLocked'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$LessonItemImplToJson(_$LessonItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'durationMinutes': instance.durationMinutes,
      'isLocked': instance.isLocked,
      'isCompleted': instance.isCompleted,
      'description': instance.description,
    };
