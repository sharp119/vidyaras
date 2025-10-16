import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/progress/progress_bar.dart';
import '../../3_domain/models/test_performance.dart';

/// Performance overview section showing completed test scores with progress bars
class PerformanceOverview extends StatelessWidget {
  const PerformanceOverview({
    super.key,
    required this.performances,
  });

  final List<TestPerformance> performances;

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
                'Performance Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Icon(
                Icons.bar_chart,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Performance items
          ...performances.asMap().entries.map((entry) {
            final index = entry.key;
            final performance = entry.value;
            final isLast = index == performances.length - 1;

            return Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: _PerformanceItem(performance: performance),
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
  });

  final TestPerformance performance;

  double _getProgressValue(String score) {
    // Extract percentage value from string like "85%"
    final numericString = score.replaceAll('%', '');
    final value = double.tryParse(numericString);
    return value != null ? value / 100 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Score
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                performance.testTitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              performance.score,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Progress Bar
        ProgressBar(
          progress: _getProgressValue(performance.score),
          height: 8,
          backgroundColor: AppColors.textTertiary.withOpacity(0.1),
          progressColor: AppColors.textPrimary,
        ),
      ],
    );
  }
}
