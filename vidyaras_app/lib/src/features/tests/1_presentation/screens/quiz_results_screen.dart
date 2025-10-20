import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../3_domain/models/quiz_result.dart';

/// Screen to display the results of a completed quiz
class QuizResultsScreen extends ConsumerWidget {
  const QuizResultsScreen({
    super.key,
    required this.testId,
    this.result,
    this.userAnswers,
  });

  final String testId;
  final QuizResult? result;
  final Map<int, int>? userAnswers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use passed result or fallback to mock data
    final quizResult = result ??
        QuizResult(
          testId: testId,
          testTitle: 'Quiz',
          totalQuestions: 0,
          correctAnswers: 0,
          score: 0,
          completedAt: DateTime.now(),
          timeTakenMinutes: 0,
        );

    final answers = userAnswers ?? <int, int>{};

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Test Results'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () =>
              context.go('/main', extra: 3), // Navigate to Test Series tab
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with score
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Text(
                    quizResult.testTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${quizResult.score}%',
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        '${quizResult.correctAnswers}/${quizResult.totalQuestions}',
                        'Correct',
                        AppColors.success,
                      ),
                      _buildStatItem(
                        '${quizResult.totalQuestions - quizResult.correctAnswers}',
                        'Incorrect',
                        AppColors.error,
                      ),
                      _buildStatItem(
                        '${quizResult.timeTakenMinutes} mins',
                        'Time Taken',
                        AppColors.textPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Action buttons
            PrimaryButton(
              onPressed: () {
                // Navigate to the answer review screen
                context.push('/test/$testId/review', extra: answers);
              },
              label: 'Review Answers',
              icon: Icons.rate_review,
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              onPressed: () {
                context.go('/main', extra: 3); // Navigate to Test Series tab
              },
              label: 'Back to Tests',
              icon: Icons.arrow_back,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
