import 'package:freezed_annotation/freezed_annotation.dart';
import '../../3_domain/models/quiz_attempt.dart';
import '../../3_domain/models/quiz_result.dart';

part 'quiz_state.freezed.dart';

/// State for the quiz taking screen
@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;
  const factory QuizState.loading() = _Loading;
  const factory QuizState.active(QuizAttempt attempt) = _Active;
  const factory QuizState.submitting(QuizAttempt attempt) = _Submitting;
  const factory QuizState.completed(QuizResult result) = _Completed;
  const factory QuizState.error(String message) = _Error;
}
