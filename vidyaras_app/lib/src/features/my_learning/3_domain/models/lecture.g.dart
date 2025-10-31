// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LectureImpl _$$LectureImplFromJson(Map<String, dynamic> json) =>
    _$LectureImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      sectionId: json['sectionId'] as String,
      sectionTitle: json['sectionTitle'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      orderIndex: (json['orderIndex'] as num).toInt(),
      type: json['type'] as String? ?? 'video',
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      videoUrl: json['videoUrl'] as String?,
      requiredQuizId: json['requiredQuizId'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      isLocked: json['isLocked'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      watchedSeconds: (json['watchedSeconds'] as num?)?.toInt(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LectureImplToJson(_$LectureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'sectionId': instance.sectionId,
      'sectionTitle': instance.sectionTitle,
      'title': instance.title,
      'description': instance.description,
      'orderIndex': instance.orderIndex,
      'type': instance.type,
      'durationMinutes': instance.durationMinutes,
      'videoUrl': instance.videoUrl,
      'requiredQuizId': instance.requiredQuizId,
      'isCompleted': instance.isCompleted,
      'isLocked': instance.isLocked,
      'completedAt': instance.completedAt?.toIso8601String(),
      'watchedSeconds': instance.watchedSeconds,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
