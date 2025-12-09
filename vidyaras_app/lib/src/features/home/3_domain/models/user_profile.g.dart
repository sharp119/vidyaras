// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
      enrolledCount: (json['enrolledCount'] as num?)?.toInt() ?? 0,
      completedCount: (json['completedCount'] as num?)?.toInt() ?? 0,
      certificatesCount: (json['certificatesCount'] as num?)?.toInt() ?? 0,
      referralPoints: (json['referralPoints'] as num?)?.toInt() ?? 0,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'isPremium': instance.isPremium,
      'enrolledCount': instance.enrolledCount,
      'completedCount': instance.completedCount,
      'certificatesCount': instance.certificatesCount,
      'referralPoints': instance.referralPoints,
      'interests': instance.interests,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
