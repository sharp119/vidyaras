import 'package:freezed_annotation/freezed_annotation.dart';
import 'content_data.dart';
import 'quiz_option.dart';

part 'quiz_question.freezed.dart';
part 'quiz_question.g.dart';

/// Represents a quiz question with flexible content support
@freezed
class QuizQuestion with _$QuizQuestion {
  const factory QuizQuestion({
    required String id,
    required String quizId,
    required int questionNumber,
    required ContentData questionData, // Flexible question content
    required List<QuizOption> options, // List of options with flexible content
    required int correctOptionId, // Index of correct option (0-based)
    ContentData? explanation, // Optional explanation with flexible content
    @Default(1) int marks, // Marks for this question
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _QuizQuestion;

  factory QuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionFromJson(json);
}
