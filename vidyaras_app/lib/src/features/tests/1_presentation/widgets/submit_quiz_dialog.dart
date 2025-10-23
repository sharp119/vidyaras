import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';

/// Dialog to confirm quiz submission
class SubmitQuizDialog extends StatelessWidget {
  const SubmitQuizDialog({
    super.key,
    required this.answeredCount,
    required this.totalQuestions,
    required this.onReviewAnswers,
    required this.onSubmitNow,
  });

  final int answeredCount;
  final int totalQuestions;
  final VoidCallback onReviewAnswers;
  final VoidCallback onSubmitNow;

  @override
  Widget build(BuildContext context) {
    final unansweredCount = totalQuestions - answeredCount;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Submit Quiz?',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            // Message
            Text(
              unansweredCount > 0
                  ? 'You have answered $answeredCount out of $totalQuestions questions.'
                  : 'You have answered all $totalQuestions questions.',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),

            if (unansweredCount > 0) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$unansweredCount question${unansweredCount > 1 ? 's' : ''} not answered',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    onPressed: onReviewAnswers,
                    label: 'Review',
                    fullWidth: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    onPressed: onSubmitNow,
                    label: 'Submit',
                    fullWidth: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Show the submit quiz dialog
  static Future<bool?> show(
    BuildContext context, {
    required int answeredCount,
    required int totalQuestions,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SubmitQuizDialog(
        answeredCount: answeredCount,
        totalQuestions: totalQuestions,
        onReviewAnswers: () => Navigator.of(context).pop(false),
        onSubmitNow: () => Navigator.of(context).pop(true),
      ),
    );
  }
}
