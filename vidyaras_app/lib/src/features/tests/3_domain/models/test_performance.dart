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
    required String attemptId, // For navigating to specific attempt results
    required DateTime completedAt, // When this attempt was completed
  }) = _TestPerformance;

  factory TestPerformance.fromJson(Map<String, dynamic> json) =>
      _$TestPerformanceFromJson(json);
}
