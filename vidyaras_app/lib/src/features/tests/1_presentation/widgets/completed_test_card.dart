import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // You may need to add 'intl' to your pubspec.yaml
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/primary_button.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';

// Data class to hold all the necessary information for the result card.
class QuizResult {
  final String id;
  final String title;
  final String category;
  final String icon; // For emoji icon
  final int score; // Score as a percentage (0-100)
  final int correctAnswers;
  final int totalQuestions;
  final int timeSpent; // in minutes
  final DateTime completedAt;
  final String difficulty;
  final bool passed;

  QuizResult({
    required this.id,
    required this.title,
    required this.category,
    required this.icon,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeSpent,
    required this.completedAt,
    required this.difficulty,
    required this.passed,
  });
}

/// A modern card component for displaying a completed quiz result.
class CompletedTestCard extends StatelessWidget {
  const CompletedTestCard({
    super.key,
    required this.result,
    this.onRetake,
    this.onViewDetails,
  });

  final QuizResult result;
  final VoidCallback? onRetake;
  final VoidCallback? onViewDetails;

  // Helper to get styling for the top-right performance badge
  ({String label, Color bgColor, Color textColor}) _getPerformanceBadge(
    int score,
  ) {
    if (score >= 90)
      return (
        label: 'Excellent',
        bgColor: AppColors.success,
        textColor: Colors.white,
      );
    if (score >= 80)
      return (
        label: 'Great',
        bgColor: AppColors.primary,
        textColor: Colors.white,
      );
    if (score >= 70)
      return (
        label: 'Good',
        bgColor: AppColors.warning,
        textColor: AppColors.textPrimary,
      );
    if (score >= 60)
      return (
        label: 'Pass',
        bgColor: AppColors.textSecondary.withOpacity(0.7),
        textColor: Colors.white,
      );
    return (
      label: 'Needs Work',
      bgColor: AppColors.error,
      textColor: Colors.white,
    );
  }

  // Helper to get the color for the score text and progress bar
  Color _getScoreColor(int score) {
    if (score >= 90) return AppColors.success;
    if (score >= 70) return AppColors.warning;
    return AppColors.error;
  }

  // Helper to get styling for the difficulty badge
  ({Color bgColor, Color textColor}) _getDifficultyStyling() {
    switch (result.difficulty.toLowerCase()) {
      case 'easy':
      case 'beginner':
        return (bgColor: AppColors.success, textColor: Colors.white);
      case 'medium':
      case 'intermediate':
        return (bgColor: AppColors.warning, textColor: AppColors.textPrimary);
      case 'hard':
      case 'advanced':
        return (bgColor: AppColors.error, textColor: Colors.white);
      default:
        return (bgColor: AppColors.textSecondary, textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    final performance = _getPerformanceBadge(result.score);
    final difficultyStyle = _getDifficultyStyling();
    final formattedDate = DateFormat('MMM d, yyyy').format(result.completedAt);
    final formattedTime = DateFormat('h:mm a').format(result.completedAt);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textTertiary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      result.icon,
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          // _buildBadge(
                          //   result.category,
                          //   AppColors.textSecondary.withOpacity(0.1),
                          //   AppColors.textPrimary,
                          // ),
                          _buildBadge(
                            result.difficulty,
                            difficultyStyle.bgColor,
                            difficultyStyle.textColor,
                            capitalize: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildBadge(
                  performance.label,
                  performance.bgColor,
                  performance.textColor,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // --- SCORE DISPLAY ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Score',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '${result.score}%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(result.score),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: result.score / 100.0,
              backgroundColor: AppColors.textTertiary.withOpacity(0.2),
              color: _getScoreColor(result.score),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${result.correctAnswers}/${result.totalQuestions} correct',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (result.passed)
                  Row(
                    children: [
                      const Icon(
                        Icons.emoji_events_outlined,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Passed',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                else
                  const Text(
                    'Failed',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            // --- STATS ---
            Divider(color: AppColors.textTertiary.withOpacity(0.5)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  _buildStatItem(Icons.calendar_today_outlined, formattedDate),
                  const SizedBox(width: 16),
                  _buildStatItem(
                    Icons.access_time_outlined,
                    '${result.timeSpent} min',
                  ),
                  const Spacer(),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // --- ACTIONS ---
            Row(
              children: [
                if (onViewDetails != null)
                  Expanded(
                    child: SecondaryButton(
                      label: 'View Details',
                      onPressed: onViewDetails,
                      icon: Icons.trending_up,
                    ),
                  ),
                if (onViewDetails != null) const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
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
    );
  }

  Widget _buildBadge(
    String label,
    Color bgColor,
    Color textColor, {
    bool capitalize = false,
  }) {
    final text = capitalize && label.isNotEmpty
        ? label[0].toUpperCase() + label.substring(1)
        : label;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
