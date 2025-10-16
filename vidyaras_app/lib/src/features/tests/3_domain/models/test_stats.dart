import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_stats.freezed.dart';
part 'test_stats.g.dart';

/// Overall test statistics for the user
@freezed
class TestStats with _$TestStats {
  const factory TestStats({
    required int totalTests,
    required int completedTests,
    required String averageScore, // e.g., "89%"
  }) = _TestStats;

  factory TestStats.fromJson(Map<String, dynamic> json) =>
      _$TestStatsFromJson(json);
}
