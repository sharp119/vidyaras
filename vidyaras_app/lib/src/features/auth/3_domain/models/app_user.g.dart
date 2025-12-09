// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      referralPoints: (json['referralPoints'] as num?)?.toInt() ?? 0,
      isOnboarded: json['isOnboarded'] as bool? ?? false,
      preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
      role: json['role'] as String? ?? 'student',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'phoneNumber': instance.phoneNumber,
      'bio': instance.bio,
      'referralPoints': instance.referralPoints,
      'isOnboarded': instance.isOnboarded,
      'preferences': instance.preferences,
      'role': instance.role,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
