// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionInfoImpl _$$SectionInfoImplFromJson(Map<String, dynamic> json) =>
    _$SectionInfoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDurationMinutes: (json['totalDurationMinutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SectionInfoImplToJson(_$SectionInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lessons': instance.lessons,
      'totalDurationMinutes': instance.totalDurationMinutes,
    };
