import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../3_domain/models/quiz_result.dart';

/// Screen to display the results of a completed quiz
class QuizResultsScreen extends ConsumerWidget {
  const QuizResultsScreen({super.key, required this.testId});

  final String testId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for now - this will be replaced by data from the notifier
    final mockResult = QuizResult(
      testId: testId,
      testTitle: 'Tabla Rhythm Patterns',
      totalQuestions: 5,
      correctAnswers: 4,
      score: 80,
      completedAt: DateTime.now(),
      timeTakenMinutes: 10,
    );

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
                    mockResult.testTitle,
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
                    '${mockResult.score}%',
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
                        '${mockResult.correctAnswers}/${mockResult.totalQuestions}',
                        'Correct',
                        AppColors.success,
                      ),
                      _buildStatItem(
                        '${mockResult.totalQuestions - mockResult.correctAnswers}',
                        'Incorrect',
                        AppColors.error,
                      ),
                      _buildStatItem(
                        '${mockResult.timeTakenMinutes} mins',
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
                // TODO: Navigate to answer review
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
