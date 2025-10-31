// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LectureCompletionImpl _$$LectureCompletionImplFromJson(
  Map<String, dynamic> json,
) => _$LectureCompletionImpl(
  id: json['id'] as String,
  userId: json['userId'] as String,
  lectureId: json['lectureId'] as String,
  completedAt: DateTime.parse(json['completedAt'] as String),
  watchedSeconds: (json['watchedSeconds'] as num?)?.toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$LectureCompletionImplToJson(
  _$LectureCompletionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'lectureId': instance.lectureId,
  'completedAt': instance.completedAt.toIso8601String(),
  'watchedSeconds': instance.watchedSeconds,
  'createdAt': instance.createdAt?.toIso8601String(),
};
