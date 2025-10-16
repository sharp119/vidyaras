import 'package:freezed_annotation/freezed_annotation.dart';
import 'question.dart';

part 'quiz_attempt.freezed.dart';
part 'quiz_attempt.g.dart';

/// QuizAttempt model representing an active quiz session
@freezed
class QuizAttempt with _$QuizAttempt {
  const QuizAttempt._(); // Private constructor for custom methods

  const factory QuizAttempt({
    required String testId,
    required String testTitle,
    required List<Question> questions,
    required int currentQuestionIndex,
    required int totalQuestions,
    required int durationMinutes,
    required DateTime startTime,
    DateTime? endTime,
    Map<int, int>? userAnswers, // Map of questionIndex -> selectedOptionIndex
  }) = _QuizAttempt;

  factory QuizAttempt.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptFromJson(json);

  /// Get the number of answered questions
  int get answeredCount => userAnswers?.length ?? 0;

  /// Get the progress (0.0 to 1.0)
  double get progress => answeredCount / totalQuestions;

  /// Check if a question at given index is answered
  bool isQuestionAnswered(int index) => userAnswers?.containsKey(index) ?? false;

  /// Get the remaining time in seconds
  int get remainingTimeInSeconds {
    final now = DateTime.now();
    final elapsedSeconds = now.difference(startTime).inSeconds;
    final totalSeconds = durationMinutes * 60;
    return totalSeconds - elapsedSeconds;
  }

  /// Check if the quiz time has expired
  bool get isTimeExpired => remainingTimeInSeconds <= 0;

  /// Check if all questions are answered
  bool get isAllAnswered => answeredCount == totalQuestions;
}
