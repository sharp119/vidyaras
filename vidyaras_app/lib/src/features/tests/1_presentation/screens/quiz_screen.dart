import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../2_application/notifiers/quiz_notifier.dart';
import '../../2_application/providers/test_providers.dart';
import '../widgets/quiz_header.dart';
import '../widgets/question_card.dart';
import '../widgets/question_navigator.dart';
import '../widgets/submit_quiz_dialog.dart';

/// Quiz taking screen where users answer questions
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key, required this.testId, required this.testTitle});

  final String testId;
  final String testTitle;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startQuiz();
    });
  }

  void _startQuiz() async {
    // Get current user
    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not logged in')),
        );
      }
      return;
    }

    // First, get the quiz details to fetch the correct duration
    final quizRepository = ref.read(testRepositoryProvider);

    // We need to get the quiz metadata from test repository
    // For now, let's fetch from the test data
    final testDataEither = await quizRepository.getTestData(userId: currentUser.id);

    int quizDuration = 30; // Default fallback

    testDataEither.fold(
      (failure) => null,
      (testData) {
        // Find the quiz in available or completed tests
        final allTests = [...testData.availableTests, ...testData.completedTests];
        final quiz = allTests.firstWhere(
          (test) => test.id == widget.testId,
          orElse: () => allTests.first,
        );
        quizDuration = quiz.durationMinutes;
      },
    );

    final questionsEither = await quizRepository.getQuizQuestions(widget.testId);

    questionsEither.fold(
      (failure) {
        // Handle error, maybe show a dialog
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (questions) {
        ref
            .read(quizNotifierProvider(widget.testId).notifier)
            .startQuiz(
              testId: widget.testId,
              testTitle: widget.testTitle,
              questions: questions,
              durationMinutes: quizDuration,
            );
      },
    );
  }

  Future<void> _handleExitQuiz() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Quiz?'),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    if (shouldExit == true && mounted) {
      context.pop();
    }
  }

  Future<void> _handleSubmitQuiz() async {
    final attempt = ref
        .read(quizNotifierProvider(widget.testId).notifier)
        .getCurrentAttempt();
    if (attempt == null) return;

    final shouldSubmit = await SubmitQuizDialog.show(
      context,
      answeredCount: attempt.answeredCount,
      totalQuestions: attempt.totalQuestions,
    );

    if (shouldSubmit == true) {
      final quizNotifier = ref.read(
        quizNotifierProvider(widget.testId).notifier,
      );
      await quizNotifier.submitQuiz();

      // After submission, get the final result from the state
      final finalState = ref.read(quizNotifierProvider(widget.testId));
      finalState.whenOrNull(
        completed: (result) {
          if (mounted) {
            // Pass the result and userAnswers to the results screen
            context.go(
              '/test/${widget.testId}/results',
              extra: {'result': result, 'userAnswers': attempt.userAnswers},
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizNotifierProvider(widget.testId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: quizState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        active: (attempt) => _buildActiveQuiz(attempt),
        submitting: (attempt) => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Submitting quiz...',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
        completed: (result) {
          // This state should ideally not be seen here as we navigate away.
          // It's a fallback.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: AppColors.success,
                ),
                const SizedBox(height: 24),
                const Text('Quiz Completed!'),
                const SizedBox(height: 16),
                PrimaryButton(
                  onPressed: () => context.go(
                    '/test/${widget.testId}/results',
                    extra: {'result': result},
                  ),
                  label: 'View Results',
                  fullWidth: false,
                ),
              ],
            ),
          );
        },
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveQuiz(attempt) {
    final currentQuestion = attempt.questions[attempt.currentQuestionIndex];
    final userAnswer = ref
        .read(quizNotifierProvider(widget.testId).notifier)
        .getUserAnswer(attempt.currentQuestionIndex);

    final answeredQuestions =
        (attempt.userAnswers as Map<int, int>?)?.keys.toSet() ?? {};

    return Column(
      children: [
        QuizHeader(
          testTitle: attempt.testTitle,
          answeredCount: attempt.answeredCount,
          totalQuestions: attempt.totalQuestions,
          progress: attempt.progress,
          remainingTimeSeconds: attempt.remainingTimeInSeconds,
          onExitQuiz: _handleExitQuiz,
          onSubmitQuiz: _handleSubmitQuiz,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: QuestionCard(
              question: currentQuestion,
              questionNumber: attempt.currentQuestionIndex + 1,
              totalQuestions: attempt.totalQuestions,
              selectedOptionIndex: userAnswer,
              onOptionSelected: (index) {
                ref
                    .read(quizNotifierProvider(widget.testId).notifier)
                    .selectAnswer(index);
              },
              isAnswered: userAnswer != null,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              if (attempt.currentQuestionIndex > 0)
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      ref
                          .read(quizNotifierProvider(widget.testId).notifier)
                          .previousQuestion();
                    },
                    label: 'Previous',
                    icon: Icons.chevron_left,
                    fullWidth: true,
                  ),
                ),
              if (attempt.currentQuestionIndex > 0 &&
                  attempt.currentQuestionIndex < attempt.totalQuestions - 1)
                const SizedBox(width: 12),
              if (attempt.currentQuestionIndex < attempt.totalQuestions - 1)
                Expanded(
                  child: SecondaryButton(
                    onPressed: () {
                      ref
                          .read(quizNotifierProvider(widget.testId).notifier)
                          .nextQuestion();
                    },
                    label: 'Next',
                    icon: Icons.chevron_right,
                    fullWidth: true,
                  ),
                ),
            ],
          ),
        ),
        QuestionNavigator(
          totalQuestions: attempt.totalQuestions,
          currentQuestionIndex: attempt.currentQuestionIndex,
          answeredQuestions: answeredQuestions,
          onQuestionTap: (index) {
            ref
                .read(quizNotifierProvider(widget.testId).notifier)
                .goToQuestion(index);
          },
        ),
      ],
    );
  }
}
