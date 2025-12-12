// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseMaterialImpl _$$CourseMaterialImplFromJson(Map<String, dynamic> json) =>
    _$CourseMaterialImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      type: json['type'] as String? ?? 'pdf',
      fileUrl: json['fileUrl'] as String,
      fileSizeMb: (json['fileSizeMb'] as num?)?.toDouble(),
      moduleId: json['moduleId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CourseMaterialImplToJson(
  _$CourseMaterialImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'courseId': instance.courseId,
  'title': instance.title,
  'type': instance.type,
  'fileUrl': instance.fileUrl,
  'fileSizeMb': instance.fileSizeMb,
  'moduleId': instance.moduleId,
  'createdAt': instance.createdAt?.toIso8601String(),
};
