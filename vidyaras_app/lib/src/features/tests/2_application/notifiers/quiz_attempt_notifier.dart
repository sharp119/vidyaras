import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/models/quiz_attempt_record.dart';
import '../../3_domain/models/user_answer.dart';
import '../../3_domain/repositories/quiz_repository.dart';
import '../providers/quiz_providers.dart';

part 'quiz_attempt_notifier.g.dart';

/// State for managing an active quiz attempt
class QuizAttemptState {
  final QuizAttemptRecord? currentAttempt;
  final Map<String, int> userAnswers; // questionId -> selectedOptionId
  final int currentQuestionIndex;
  final bool isSubmitting;
  final String? error;

  const QuizAttemptState({
    this.currentAttempt,
    this.userAnswers = const {},
    this.currentQuestionIndex = 0,
    this.isSubmitting = false,
    this.error,
  });

  QuizAttemptState copyWith({
    QuizAttemptRecord? currentAttempt,
    Map<String, int>? userAnswers,
    int? currentQuestionIndex,
    bool? isSubmitting,
    String? error,
  }) {
    return QuizAttemptState(
      currentAttempt: currentAttempt ?? this.currentAttempt,
      userAnswers: userAnswers ?? this.userAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
    );
  }
}

/// Notifier for managing quiz attempts
@riverpod
class QuizAttemptNotifier extends _$QuizAttemptNotifier {
  QuizRepository get _repository => ref.read(quizRepositoryProvider);

  @override
  QuizAttemptState build() {
    return const QuizAttemptState();
  }

  /// Start a new quiz attempt
  Future<void> startQuizAttempt(String quizId, int totalMarks) async {
    state = state.copyWith(isSubmitting: true, error: null);

    final result = await _repository.createQuizAttempt(
      quizId: quizId,
      totalMarks: totalMarks,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isSubmitting: false,
          error: failure.message,
        );
      },
      (attempt) {
        state = state.copyWith(
          currentAttempt: attempt,
          userAnswers: {},
          currentQuestionIndex: 0,
          isSubmitting: false,
          error: null,
        );
      },
    );
  }

  /// Save an answer for a question
  Future<void> submitAnswer({
    required String questionId,
    required int selectedOptionId,
    required bool isCorrect,
    required int marksAwarded,
  }) async {
    if (state.currentAttempt == null) return;

    final result = await _repository.submitAnswer(
      attemptId: state.currentAttempt!.id,
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      isCorrect: isCorrect,
      marksAwarded: marksAwarded,
    );

    result.fold(
      (failure) {
        state = state.copyWith(error: failure.message);
      },
      (answer) {
        final updatedAnswers = Map<String, int>.from(state.userAnswers);
        updatedAnswers[questionId] = selectedOptionId;
        state = state.copyWith(userAnswers: updatedAnswers);
      },
    );
  }

  /// Complete the quiz attempt
  Future<QuizAttemptRecord?> completeQuiz({
    required int score,
    required int timeTakenSeconds,
  }) async {
    if (state.currentAttempt == null) return null;

    state = state.copyWith(isSubmitting: true);

    final result = await _repository.completeQuizAttempt(
      attemptId: state.currentAttempt!.id,
      score: score,
      timeTakenSeconds: timeTakenSeconds,
    );

    return result.fold(
      (failure) {
        state = state.copyWith(
          isSubmitting: false,
          error: failure.message,
        );
        return null;
      },
      (completedAttempt) {
        state = state.copyWith(
          currentAttempt: completedAttempt,
          isSubmitting: false,
        );
        return completedAttempt;
      },
    );
  }

  /// Navigate to next question
  void nextQuestion() {
    state = state.copyWith(
      currentQuestionIndex: state.currentQuestionIndex + 1,
    );
  }

  /// Navigate to previous question
  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
    }
  }

  /// Jump to a specific question
  void goToQuestion(int index) {
    state = state.copyWith(currentQuestionIndex: index);
  }

  /// Check if a question has been answered
  bool isQuestionAnswered(String questionId) {
    return state.userAnswers.containsKey(questionId);
  }

  /// Get the selected answer for a question
  int? getSelectedAnswer(String questionId) {
    return state.userAnswers[questionId];
  }

  /// Clear the current attempt (for starting a new quiz)
  void clearAttempt() {
    state = const QuizAttemptState();
  }
}
