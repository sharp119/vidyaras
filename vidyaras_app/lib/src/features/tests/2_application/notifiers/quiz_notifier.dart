import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/models/quiz_attempt.dart';
import '../../3_domain/models/question.dart';
import '../../3_domain/models/quiz_result.dart';
import '../state/quiz_state.dart';

part 'quiz_notifier.g.dart';

/// Notifier for managing quiz taking state
@riverpod
class QuizNotifier extends _$QuizNotifier {
  Timer? _timer;

  @override
  QuizState build(String testId) {
    // Clean up timer when provider is disposed
    ref.onDispose(() {
      _timer?.cancel();
    });

    return const QuizState.initial();
  }

  /// Start a quiz with given test data
  Future<void> startQuiz({
    required String testId,
    required String testTitle,
    required List<Question> questions,
    required int durationMinutes,
  }) async {
    state = const QuizState.loading();

    final attempt = QuizAttempt(
      testId: testId,
      testTitle: testTitle,
      questions: questions,
      currentQuestionIndex: 0,
      totalQuestions: questions.length,
      durationMinutes: durationMinutes,
      startTime: DateTime.now(),
      userAnswers: {},
    );

    state = QuizState.active(attempt);

    // Start timer to auto-submit when time expires
    _startTimer();
  }

  /// Start the countdown timer
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state.whenOrNull(
        active: (attempt) {
          // Check if time expired
          if (attempt.isTimeExpired) {
            _timer?.cancel();
            submitQuiz(); // Auto-submit when time expires
          } else {
            // Update state to trigger UI rebuild for timer display
            // Create a new instance to trigger Riverpod rebuild
            state = QuizState.active(attempt.copyWith());
          }
        },
      );
    });
  }

  /// Navigate to specific question
  void goToQuestion(int index) {
    state.whenOrNull(
      active: (attempt) {
        if (index >= 0 && index < attempt.totalQuestions) {
          state = QuizState.active(
            attempt.copyWith(currentQuestionIndex: index),
          );
        }
      },
    );
  }

  /// Navigate to next question
  void nextQuestion() {
    state.whenOrNull(
      active: (attempt) {
        final nextIndex = attempt.currentQuestionIndex + 1;
        if (nextIndex < attempt.totalQuestions) {
          goToQuestion(nextIndex);
        }
      },
    );
  }

  /// Navigate to previous question
  void previousQuestion() {
    state.whenOrNull(
      active: (attempt) {
        final previousIndex = attempt.currentQuestionIndex - 1;
        if (previousIndex >= 0) {
          goToQuestion(previousIndex);
        }
      },
    );
  }

  /// Select an answer for the current question
  void selectAnswer(int optionIndex) {
    state.whenOrNull(
      active: (attempt) {
        final questionIndex = attempt.currentQuestionIndex;

        // Update user answers map
        final updatedAnswers = Map<int, int>.from(attempt.userAnswers ?? {});
        updatedAnswers[questionIndex] = optionIndex;

        state = QuizState.active(
          attempt.copyWith(userAnswers: updatedAnswers),
        );
      },
    );
  }

  /// Submit the quiz
  Future<void> submitQuiz() async {
    await state.whenOrNull(
      active: (attempt) async {
        _timer?.cancel(); // Stop the timer

        state = QuizState.submitting(attempt);

        // Calculate score
        int correctAnswers = 0;
        final userAnswers = attempt.userAnswers ?? {};

        for (int i = 0; i < attempt.questions.length; i++) {
          final question = attempt.questions[i];
          final userAnswer = userAnswers[i];

          if (userAnswer != null && userAnswer == question.correctAnswerIndex) {
            correctAnswers++;
          }
        }

        final score = ((correctAnswers / attempt.totalQuestions) * 100).round();
        final timeTaken = DateTime.now().difference(attempt.startTime).inMinutes;

        final result = QuizResult(
          testId: attempt.testId,
          testTitle: attempt.testTitle,
          totalQuestions: attempt.totalQuestions,
          correctAnswers: correctAnswers,
          score: score,
          completedAt: DateTime.now(),
          timeTakenMinutes: timeTaken,
        );

        // Simulate API call delay
        await Future.delayed(const Duration(milliseconds: 500));

        state = QuizState.completed(result);
      },
    );
  }

  /// Get the current quiz attempt (if active)
  QuizAttempt? getCurrentAttempt() {
    return state.whenOrNull(
      active: (attempt) => attempt,
      submitting: (attempt) => attempt,
    );
  }

  /// Check if a specific question is answered
  bool isQuestionAnswered(int index) {
    final attempt = getCurrentAttempt();
    return attempt?.isQuestionAnswered(index) ?? false;
  }

  /// Get user's answer for a specific question
  int? getUserAnswer(int questionIndex) {
    final attempt = getCurrentAttempt();
    return attempt?.userAnswers?[questionIndex];
  }
}
