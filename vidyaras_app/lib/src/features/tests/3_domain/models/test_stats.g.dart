// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestStatsImpl _$$TestStatsImplFromJson(Map<String, dynamic> json) =>
    _$TestStatsImpl(
      totalTests: (json['totalTests'] as num).toInt(),
      completedTests: (json['completedTests'] as num).toInt(),
      averageScore: json['averageScore'] as String,
    );

Map<String, dynamic> _$$TestStatsImplToJson(_$TestStatsImpl instance) =>
    <String, dynamic>{
      'totalTests': instance.totalTests,
      'completedTests': instance.completedTests,
      'averageScore': instance.averageScore,
    };
