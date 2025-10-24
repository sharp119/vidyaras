// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseReviewImpl _$$CourseReviewImplFromJson(Map<String, dynamic> json) =>
    _$CourseReviewImpl(
      id: json['id'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String?,
      rating: (json['rating'] as num).toDouble(),
      reviewText: json['reviewText'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CourseReviewImplToJson(_$CourseReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'rating': instance.rating,
      'reviewText': instance.reviewText,
      'createdAt': instance.createdAt.toIso8601String(),
    };
