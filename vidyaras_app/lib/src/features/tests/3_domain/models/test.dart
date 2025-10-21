import 'package:freezed_annotation/freezed_annotation.dart';

part 'test.freezed.dart';
part 'test.g.dart';

/// Test/Quiz model representing a test in the system
@freezed
class Test with _$Test {
  const factory Test({
    required String id,
    required String title,
    required String titleHindi,
    required String category,
    required String difficulty, // beginner, intermediate, advanced
    required int questionCount,
    required int durationMinutes,
    String? bestScore, // e.g., "85%" or null if not attempted
    bool? isCompleted,
    @Default(0) int attemptCount, // Number of times this test has been attempted
  }) = _Test;

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
}
