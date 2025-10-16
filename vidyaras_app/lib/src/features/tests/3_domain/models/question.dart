import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

/// Question model representing a quiz question with multiple choice options
@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String questionText,
    required List<String> options, // List of answer options
    required int correctAnswerIndex, // Index of the correct answer in options
    String? selectedAnswerIndex, // Index of user's selected answer (null if not answered)
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
