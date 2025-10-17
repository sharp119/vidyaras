import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../3_domain/models/question.dart';

/// A card that displays a question and its options for review,
/// highlighting the correct answer and the user's selected answer.
class AnswerReviewCard extends StatelessWidget {
  const AnswerReviewCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    this.userAnswerIndex,
  });

  final Question question;
  final int questionNumber;
  final int totalQuestions;
  final int? userAnswerIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Text(
            'Question $questionNumber of $totalQuestions',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),

          // Question text
          Text(
            question.questionText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          // Options
          ...List.generate(question.options.length, (index) {
            final isCorrect = index == question.correctAnswerIndex;
            final isUserAnswer = index == userAnswerIndex;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _AnswerOptionTile(
                option: question.options[index],
                isCorrect: isCorrect,
                isUserAnswer: isUserAnswer,
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// An option tile used in the AnswerReviewCard to show the status of each answer.
class _AnswerOptionTile extends StatelessWidget {
  const _AnswerOptionTile({
    required this.option,
    required this.isCorrect,
    required this.isUserAnswer,
  });

  final String option;
  final bool isCorrect;
  final bool isUserAnswer;

  @override
  Widget build(BuildContext context) {
    Color borderColor = AppColors.border;
    Color backgroundColor = AppColors.background;
    Widget? trailingIcon;

    if (isCorrect) {
      borderColor = AppColors.success;
      backgroundColor = AppColors.success.withOpacity(0.1);
      trailingIcon = const Icon(Icons.check_circle, color: AppColors.success);
    } else if (isUserAnswer) {
      borderColor = AppColors.error;
      backgroundColor = AppColors.error.withOpacity(0.1);
      trailingIcon = const Icon(Icons.cancel, color: AppColors.error);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: isCorrect || isUserAnswer ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Option text
          Expanded(
            child: Text(
              option,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCorrect || isUserAnswer
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 12),
            trailingIcon,
          ],
        ],
      ),
    );
  }
}
