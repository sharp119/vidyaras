import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_performance.freezed.dart';
part 'test_performance.g.dart';

/// Individual test performance item for the Performance Overview section
@freezed
class TestPerformance with _$TestPerformance {
  const factory TestPerformance({
    required String testId,
    required String testTitle,
    required String score, // e.g., "85%"
  }) = _TestPerformance;

  factory TestPerformance.fromJson(Map<String, dynamic> json) =>
      _$TestPerformanceFromJson(json);
}
