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
  description: json['description'] as String?,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  enrolledCount: (json['enrolledCount'] as num?)?.toInt() ?? 0,
  price: json['price'] as String?,
  originalPrice: (json['originalPrice'] as num?)?.toDouble(),
  duration: json['duration'] as String?,
  isFree: json['isFree'] as bool? ?? false,
  isLive: json['isLive'] as bool? ?? false,
  hasFreeTrial: json['hasFreeTrial'] as bool? ?? false,
  isRecorded: json['isRecorded'] as bool? ?? false,
  hasCertificate: json['hasCertificate'] as bool? ?? false,
  hasQuizzes: json['hasQuizzes'] as bool? ?? false,
  hasMaterials: json['hasMaterials'] as bool? ?? false,
  category: json['category'] as String?,
  language: json['language'] as String? ?? 'Bilingual (Hindi + English)',
  status: json['status'] as String? ?? 'published',
  accessDays: (json['accessDays'] as num?)?.toInt(),
  progress: (json['progress'] as num?)?.toDouble(),
  createdBy: json['createdBy'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'instructor': instance.instructor,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'enrolledCount': instance.enrolledCount,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'duration': instance.duration,
      'isFree': instance.isFree,
      'isLive': instance.isLive,
      'hasFreeTrial': instance.hasFreeTrial,
      'isRecorded': instance.isRecorded,
      'hasCertificate': instance.hasCertificate,
      'hasQuizzes': instance.hasQuizzes,
      'hasMaterials': instance.hasMaterials,
      'category': instance.category,
      'language': instance.language,
      'status': instance.status,
      'accessDays': instance.accessDays,
      'progress': instance.progress,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
