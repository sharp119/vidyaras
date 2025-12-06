// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrolled_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnrolledCourseImpl _$$EnrolledCourseImplFromJson(Map<String, dynamic> json) =>
    _$EnrolledCourseImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      enrolledCount: (json['enrolledCount'] as num?)?.toInt() ?? 0,
      price: json['price'] as String?,
      duration: json['duration'] as String?,
      isLive: json['isLive'] as bool? ?? false,
      isRecorded: json['isRecorded'] as bool? ?? false,
      enrollmentId: json['enrollmentId'] as String?,
      enrolledAt: json['enrolledAt'] == null
          ? null
          : DateTime.parse(json['enrolledAt'] as String),
      enrollmentStatus: json['enrollmentStatus'] as String? ?? 'active',
      lastAccessedAt: json['lastAccessedAt'] == null
          ? null
          : DateTime.parse(json['lastAccessedAt'] as String),
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      totalLectures: (json['totalLectures'] as num?)?.toInt() ?? 0,
      completedLectures: (json['completedLectures'] as num?)?.toInt() ?? 0,
      totalDurationMinutes:
          (json['totalDurationMinutes'] as num?)?.toInt() ?? 0,
      sections:
          (json['sections'] as List<dynamic>?)
              ?.map((e) => SectionInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lectures:
          (json['lectures'] as List<dynamic>?)
              ?.map((e) => Lecture.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      liveClasses:
          (json['liveClasses'] as List<dynamic>?)
              ?.map((e) => LiveClass.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      materials:
          (json['materials'] as List<dynamic>?)
              ?.map((e) => CourseMaterial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EnrolledCourseImplToJson(
  _$EnrolledCourseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'instructor': instance.instructor,
  'thumbnailUrl': instance.thumbnailUrl,
  'description': instance.description,
  'rating': instance.rating,
  'reviewCount': instance.reviewCount,
  'enrolledCount': instance.enrolledCount,
  'price': instance.price,
  'duration': instance.duration,
  'isLive': instance.isLive,
  'isRecorded': instance.isRecorded,
  'enrollmentId': instance.enrollmentId,
  'enrolledAt': instance.enrolledAt?.toIso8601String(),
  'enrollmentStatus': instance.enrollmentStatus,
  'lastAccessedAt': instance.lastAccessedAt?.toIso8601String(),
  'progress': instance.progress,
  'totalLectures': instance.totalLectures,
  'completedLectures': instance.completedLectures,
  'totalDurationMinutes': instance.totalDurationMinutes,
  'sections': instance.sections,
  'lectures': instance.lectures,
  'liveClasses': instance.liveClasses,
  'materials': instance.materials,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
