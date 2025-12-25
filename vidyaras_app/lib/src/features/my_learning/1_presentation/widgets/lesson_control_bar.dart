import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../3_domain/models/lecture.dart';

/// Navigation control bar for lesson navigation
/// Displays: [ < Prev | Lesson X/Y | Next > | Mark Complete ]
class LessonControlBar extends StatelessWidget {
  const LessonControlBar({
    super.key,
    required this.currentLecture,
    required this.currentIndex,
    required this.totalLessons,
    required this.onPrevious,
    required this.onNext,
    required this.onToggleComplete,
  });

  /// The currently playing lecture
  final Lecture currentLecture;

  /// Current lesson index (0-based)
  final int currentIndex;

  /// Total number of lessons
  final int totalLessons;

  /// Callback when previous button is pressed
  final VoidCallback? onPrevious;

  /// Callback when next button is pressed
  final VoidCallback? onNext;

  /// Callback when complete toggle is pressed
  final VoidCallback onToggleComplete;

  bool get _isFirst => currentIndex <= 0;
  bool get _isLast => currentIndex >= totalLessons - 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Previous Button
          _buildNavButton(
            icon: Icons.skip_previous_rounded,
            onPressed: _isFirst ? null : onPrevious,
            tooltip: 'Previous Lesson',
          ),

          // Lesson Counter
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Could open lesson list modal in future
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentLecture.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Lesson ${currentIndex + 1} of $totalLessons',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Next Button
          _buildNavButton(
            icon: Icons.skip_next_rounded,
            onPressed: _isLast ? null : onNext,
            tooltip: 'Next Lesson',
          ),

          // Divider
          Container(width: 1, height: 32, color: AppColors.border),

          // Mark Complete Toggle
          _buildCompleteButton(),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    final isEnabled = onPressed != null;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 28,
              color: isEnabled ? AppColors.textPrimary : AppColors.helperText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteButton() {
    final isCompleted = currentLecture.isCompleted;

    return Tooltip(
      message: isCompleted ? 'Completed' : 'Mark as Complete',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggleComplete,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 56,
            height: 48,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.success : AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted ? AppColors.success : AppColors.border,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 18,
                color: isCompleted ? Colors.white : AppColors.helperText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
