// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestDataImpl _$$TestDataImplFromJson(Map<String, dynamic> json) =>
    _$TestDataImpl(
      stats: TestStats.fromJson(json['stats'] as Map<String, dynamic>),
      performanceOverview: (json['performanceOverview'] as List<dynamic>)
          .map((e) => TestPerformance.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableTests: (json['availableTests'] as List<dynamic>)
          .map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
      completedTests: (json['completedTests'] as List<dynamic>)
          .map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TestDataImplToJson(_$TestDataImpl instance) =>
    <String, dynamic>{
      'stats': instance.stats,
      'performanceOverview': instance.performanceOverview,
      'availableTests': instance.availableTests,
      'completedTests': instance.completedTests,
    };
