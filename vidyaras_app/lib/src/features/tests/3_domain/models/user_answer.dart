import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_answer.freezed.dart';
part 'user_answer.g.dart';

/// Represents a user's answer to a specific question
@freezed
class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    required int id,
    required String attemptId,
    required String questionId,
    required int selectedOptionId,
    required bool isCorrect,
    @Default(0) int marksAwarded,
    required DateTime answeredAt,
  }) = _UserAnswer;

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);
}
