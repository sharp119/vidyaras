import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/components/progress/progress_bar.dart';
import '../../3_domain/models/test_performance.dart';

/// Recent Activity section showing latest test attempts with enhanced visuals
class PerformanceOverview extends StatelessWidget {
  const PerformanceOverview({
    super.key,
    required this.performances,
    this.onTapPerformance,
  });

  final List<TestPerformance> performances;
  final void Function(TestPerformance)? onTapPerformance;

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
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Icon(
                Icons.history,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Performance items
          ...performances.asMap().entries.map((entry) {
            final index = entry.key;
            final performance = entry.value;
            final isLast = index == performances.length - 1;

            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: _PerformanceItem(
                performance: performance,
                onTap: onTapPerformance != null
                    ? () => onTapPerformance!(performance)
                    : null,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _PerformanceItem extends StatelessWidget {
  const _PerformanceItem({
    required this.performance,
    this.onTap,
  });

  final TestPerformance performance;
  final VoidCallback? onTap;

  double _getProgressValue(String score) {
    // Extract percentage value from string like "85%"
    final numericString = score.replaceAll('%', '');
    final value = double.tryParse(numericString);
    return value != null ? value / 100 : 0.0;
  }

  Color _getProgressColor(double progressValue) {
    // Gradient color based on score
    if (progressValue >= 0.8) {
      return AppColors.success;
    } else if (progressValue >= 0.6) {
      return AppColors.accent;
    } else if (progressValue >= 0.4) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = _getProgressValue(performance.score);
    final progressColor = _getProgressColor(progressValue);

    final widget = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textTertiary.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Score
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  performance.testTitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                performance.score,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          ProgressBar(
            progress: progressValue,
            height: 10,
            backgroundColor: AppColors.textTertiary.withOpacity(0.1),
            progressColor: progressColor,
          ),
          const SizedBox(height: 10),
          // Completed Date
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              Text(
                'Completed: ${_formatDate(performance.completedAt)}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              if (onTap != null) ...[
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.textSecondary,
                ),
              ],
            ],
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: widget,
      );
    }

    return widget;
  }
}
