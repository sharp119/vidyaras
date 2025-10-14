import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'progress_bar.dart';

/// Step indicator with progress bar
/// Used for onboarding multi-step forms
class StepIndicator extends StatelessWidget {
  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    this.showLabel = true,
  });

  final int currentStep;
  final int totalSteps;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;
    final percentage = (progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $currentStep of $totalSteps',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        const SizedBox(height: 8),
        ProgressBar(
          progress: progress,
          height: 8,
        ),
      ],
    );
  }
}
