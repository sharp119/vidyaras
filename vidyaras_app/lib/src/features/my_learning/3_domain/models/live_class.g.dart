// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LiveClassImpl _$$LiveClassImplFromJson(Map<String, dynamic> json) =>
    _$LiveClassImpl(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      lectureId: json['lectureId'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      scheduledAt: DateTime.parse(json['scheduledAt'] as String),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 120,
      zoomLink: json['zoomLink'] as String,
      meetingId: json['meetingId'] as String?,
      passcode: json['passcode'] as String?,
      recordingUrl: json['recordingUrl'] as String?,
      status: json['status'] as String? ?? 'upcoming',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LiveClassImplToJson(_$LiveClassImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'lectureId': instance.lectureId,
      'title': instance.title,
      'description': instance.description,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'zoomLink': instance.zoomLink,
      'meetingId': instance.meetingId,
      'passcode': instance.passcode,
      'recordingUrl': instance.recordingUrl,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
