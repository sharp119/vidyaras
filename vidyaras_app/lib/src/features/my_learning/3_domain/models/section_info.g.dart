// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionInfoImpl _$$SectionInfoImplFromJson(Map<String, dynamic> json) =>
    _$SectionInfoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      hindiTitle: json['hindiTitle'] as String?,
      totalDurationMinutes:
          (json['totalDurationMinutes'] as num?)?.toInt() ?? 0,
      lectureCount: (json['lectureCount'] as num?)?.toInt() ?? 0,
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$SectionInfoImplToJson(_$SectionInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hindiTitle': instance.hindiTitle,
      'totalDurationMinutes': instance.totalDurationMinutes,
      'lectureCount': instance.lectureCount,
      'completedCount': instance.completedCount,
    };
