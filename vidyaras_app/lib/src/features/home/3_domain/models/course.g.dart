// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  instructor: json['instructor'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String?,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  enrolledCount: (json['enrolledCount'] as num?)?.toInt() ?? 0,
  price: json['price'] as String?,
  duration: json['duration'] as String?,
  isFree: json['isFree'] as bool? ?? false,
  isLive: json['isLive'] as bool? ?? false,
  hasFreeTrial: json['hasFreeTrial'] as bool? ?? false,
  isRecorded: json['isRecorded'] as bool? ?? false,
  progress: (json['progress'] as num?)?.toDouble(),
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'instructor': instance.instructor,
      'thumbnailUrl': instance.thumbnailUrl,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'enrolledCount': instance.enrolledCount,
      'price': instance.price,
      'duration': instance.duration,
      'isFree': instance.isFree,
      'isLive': instance.isLive,
      'hasFreeTrial': instance.hasFreeTrial,
      'isRecorded': instance.isRecorded,
      'progress': instance.progress,
      'categories': instance.categories,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
