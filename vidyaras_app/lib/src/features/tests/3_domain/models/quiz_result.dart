import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_result.freezed.dart';
part 'quiz_result.g.dart';

/// QuizResult model representing the result of a completed quiz
@freezed
class QuizResult with _$QuizResult {
  const QuizResult._(); // Private constructor for custom methods

  const factory QuizResult({
    required String testId,
    required String testTitle,
    required int totalQuestions,
    required int correctAnswers,
    required int score, // Percentage score (0-100)
    required DateTime completedAt,
    required int timeTakenMinutes,
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);

  /// Get the percentage of correct answers
  double get percentage => (correctAnswers / totalQuestions) * 100;

  /// Check if the user passed (score >= 50%)
  bool get isPassed => score >= 50;
}
