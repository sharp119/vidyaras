// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_performance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestPerformanceImpl _$$TestPerformanceImplFromJson(
  Map<String, dynamic> json,
) => _$TestPerformanceImpl(
  testId: json['testId'] as String,
  testTitle: json['testTitle'] as String,
  score: json['score'] as String,
  attemptId: json['attemptId'] as String,
  completedAt: DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$$TestPerformanceImplToJson(
  _$TestPerformanceImpl instance,
) => <String, dynamic>{
  'testId': instance.testId,
  'testTitle': instance.testTitle,
  'score': instance.score,
  'attemptId': instance.attemptId,
  'completedAt': instance.completedAt.toIso8601String(),
};
