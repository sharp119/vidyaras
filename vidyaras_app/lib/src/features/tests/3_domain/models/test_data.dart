import 'package:freezed_annotation/freezed_annotation.dart';
import 'test.dart';
import 'test_stats.dart';
import 'test_performance.dart';

part 'test_data.freezed.dart';
part 'test_data.g.dart';

/// Container for all test-related data shown on the test series screen
@freezed
class TestData with _$TestData {
  const factory TestData({
    required TestStats stats,
    required List<TestPerformance> performanceOverview,
    required List<Test> availableTests,
    required List<Test> completedTests,
  }) = _TestData;

  factory TestData.fromJson(Map<String, dynamic> json) =>
      _$TestDataFromJson(json);
}
