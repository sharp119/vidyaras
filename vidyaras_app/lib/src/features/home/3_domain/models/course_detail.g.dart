// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseDetailImpl _$$CourseDetailImplFromJson(Map<String, dynamic> json) =>
    _$CourseDetailImpl(
      basicInfo: Course.fromJson(json['basicInfo'] as Map<String, dynamic>),
      description: json['description'] as String,
      whatYouLearn: (json['whatYouLearn'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      courseIncludes: (json['courseIncludes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      prerequisites: (json['prerequisites'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      curriculum: (json['curriculum'] as List<dynamic>)
          .map((e) => SectionInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      pricing: PricingOption.fromJson(json['pricing'] as Map<String, dynamic>),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => CourseReview.fromJson(e as Map<String, dynamic>))
          .toList(),
      liveBatch: json['liveBatch'] == null
          ? null
          : BatchInfo.fromJson(json['liveBatch'] as Map<String, dynamic>),
      accessDays: (json['accessDays'] as num?)?.toInt(),
      accessExpiryDate: json['accessExpiryDate'] == null
          ? null
          : DateTime.parse(json['accessExpiryDate'] as String),
      language: json['language'] as String?,
      hasCertificate: json['hasCertificate'] as bool? ?? false,
      hasQuizzes: json['hasQuizzes'] as bool? ?? false,
      hasMaterials: json['hasMaterials'] as bool? ?? false,
    );

Map<String, dynamic> _$$CourseDetailImplToJson(_$CourseDetailImpl instance) =>
    <String, dynamic>{
      'basicInfo': instance.basicInfo,
      'description': instance.description,
      'whatYouLearn': instance.whatYouLearn,
      'courseIncludes': instance.courseIncludes,
      'prerequisites': instance.prerequisites,
      'curriculum': instance.curriculum,
      'pricing': instance.pricing,
      'reviews': instance.reviews,
      'liveBatch': instance.liveBatch,
      'accessDays': instance.accessDays,
      'accessExpiryDate': instance.accessExpiryDate?.toIso8601String(),
      'language': instance.language,
      'hasCertificate': instance.hasCertificate,
      'hasQuizzes': instance.hasQuizzes,
      'hasMaterials': instance.hasMaterials,
    };
