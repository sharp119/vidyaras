import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';

/// Card component for completed tests
class CompletedTestCard extends StatelessWidget {
  const CompletedTestCard({
    super.key,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.bestScore,
    this.attemptCount = 1,
    this.onViewHistory,
    required this.onRetake,
  });

  final String title;
  final String category;
  final String difficulty;
  final String bestScore;
  final int attemptCount;
  final VoidCallback? onViewHistory;
  final VoidCallback onRetake;

  Color _getDifficultyColor() {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.warning;
      case 'advanced':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textTertiary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkmark icon container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              size: 32,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                // Category, Difficulty, and Attempt Count badges
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        difficulty,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _getDifficultyColor(),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.history,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$attemptCount ${attemptCount == 1 ? 'Attempt' : 'Attempts'}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Best Score
                Row(
                  children: [
                    const Text(
                      'Best Score',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      bestScore,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Action buttons
                if (attemptCount > 1 && onViewHistory != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SecondaryButton(
                      label: 'View History',
                      onPressed: onViewHistory!,
                      icon: Icons.history,
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        label: 'Retake',
                        onPressed: onRetake,
                        icon: Icons.refresh,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
