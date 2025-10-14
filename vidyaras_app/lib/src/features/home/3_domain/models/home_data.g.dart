// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeDataImpl _$$HomeDataImplFromJson(Map<String, dynamic> json) =>
    _$HomeDataImpl(
      userProfile: UserProfile.fromJson(
        json['userProfile'] as Map<String, dynamic>,
      ),
      myCourses:
          (json['myCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recommendedCourses:
          (json['recommendedCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      freeCourses:
          (json['freeCourses'] as List<dynamic>?)
              ?.map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$HomeDataImplToJson(_$HomeDataImpl instance) =>
    <String, dynamic>{
      'userProfile': instance.userProfile,
      'myCourses': instance.myCourses,
      'recommendedCourses': instance.recommendedCourses,
      'freeCourses': instance.freeCourses,
    };
