import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/progress/progress_bar.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../2_application/notifiers/quiz_notifier.dart';
import '../../3_domain/models/question.dart';
import '../../3_domain/models/quiz_attempt.dart';
import '../widgets/quiz_header.dart';
import '../widgets/question_card.dart';
import '../widgets/question_navigator.dart';
import '../widgets/submit_quiz_dialog.dart';

/// Quiz taking screen where users answer questions
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({
    super.key,
    required this.testId,
    required this.testTitle,
  });

  final String testId;
  final String testTitle;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();
    // Start the quiz with mock data
    // In production, this would fetch from repository
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startQuiz();
    });
  }

  void _startQuiz() {
    // Mock questions for testing
    final mockQuestions = [
      const Question(
        id: '1',
        questionText:
            'Which pair of instruments is most commonly used in Hindustani classical music?',
        options: [
          'Dayan and Bayan',
          'Tabla and Pakhawaj',
          'Mridangam and Ghatam',
          'Dhol and Dholak',
        ],
        correctAnswerIndex: 0,
      ),
      const Question(
        id: '2',
        questionText: 'Which hand is used to play the Dayan?',
        options: [
          'Left hand',
          'Right hand',
          'Both hands',
          'Either hand',
        ],
        correctAnswerIndex: 1,
      ),
      const Question(
        id: '3',
        questionText: 'What is the main component of the Tabla\'s surface?',
        options: [
          'Leather',
          'Wood',
          'Metal',
          'Plastic',
        ],
        correctAnswerIndex: 0,
      ),
      const Question(
        id: '4',
        questionText: 'What does "Teentaal" consist of?',
        options: [
          '12 beats',
          '16 beats',
          '14 beats',
          '10 beats',
        ],
        correctAnswerIndex: 1,
      ),
      const Question(
        id: '5',
        questionText:
            'Which taal (rhythm cycle) is most commonly used in Hindustani classical music?',
        options: [
          'Dadra',
          'Rupak',
          'Jhaptaal',
          'Teentaal',
        ],
        correctAnswerIndex: 3,
      ),
    ];

    ref.read(quizNotifierProvider(widget.testId).notifier).startQuiz(
          testId: widget.testId,
          testTitle: widget.testTitle,
          questions: mockQuestions,
          durationMinutes: 30,
        );
  }

  Future<void> _handleExitQuiz() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Quiz?'),
        content:
            const Text('Are you sure you want to exit? Your progress will be lost.'),
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

    if (shouldSubmit == true && mounted) {
      await ref.read(quizNotifierProvider(widget.testId).notifier).submitQuiz();
      // Navigate to results screen
      if (mounted) {
        context.go('/test/${widget.testId}/results');
      }
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
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        completed: (result) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 80,
                color: AppColors.success,
              ),
              const SizedBox(height: 24),
              const Text(
                'Quiz Completed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Score: ${result.score}%',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                onPressed: () => context.go('/test/${widget.testId}/results'),
                label: 'View Results',
                fullWidth: false,
              ),
            ],
          ),
        ),
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

    final answeredQuestions = (attempt.userAnswers as Map<int, int>?)?.keys.toSet() ?? {};

    return Column(
      children: [
        // Quiz header with title, progress, and timer
        QuizHeader(
          testTitle: attempt.testTitle,
          answeredCount: attempt.answeredCount,
          totalQuestions: attempt.totalQuestions,
          progress: attempt.progress,
          remainingTimeSeconds: attempt.remainingTimeInSeconds,
          onExitQuiz: _handleExitQuiz,
          onSubmitQuiz: _handleSubmitQuiz,
        ),

        // Question card
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

        // Navigation buttons
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

        // Question navigator
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
