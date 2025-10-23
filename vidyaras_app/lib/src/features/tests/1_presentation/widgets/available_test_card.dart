import 'package:flutter/material.dart';
// Make sure this path matches your project structure
import '../../../../shared/presentation/theme/app_colors.dart';

/// Card component for available tests, now clickable
class AvailableTestCard extends StatelessWidget {
  const AvailableTestCard({
    super.key,
    required this.title,
    required this.category,
    required this.description,
    required this.difficulty,
    required this.questionCount,
    required this.durationMinutes,
    this.onTap,
  });

  final String title;
  final String category;
  final String description;
  final String difficulty;
  final int questionCount;
  final int durationMinutes;
  final VoidCallback? onTap; // Callback for the whole card tap

  Color _getDifficultyColor() {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
      case 'easy':
        return AppColors.success;
      case 'medium': // Orange for medium
      case 'intermediate': // Orange for intermediate
        return AppColors.warning;
      case 'advanced':
      case 'hard':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getDifficultyTextColor() {
    switch (difficulty.toLowerCase()) {
      case 'medium':
      case 'intermediate':
        return AppColors.textPrimary; // Dark text on orange
      default:
        return Colors.white; // White text on other colors
    }
  }

  // NEW: Helper function to get the correct display label
  String _getDifficultyLabel() {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
      case 'easy':
        return 'Easy';
      case 'medium':
      case 'intermediate':
        return 'Medium';
      case 'advanced':
      case 'hard':
        return 'Hard';
      default:
        // Capitalize the first letter as a fallback
        return difficulty.isNotEmpty
            ? difficulty[0].toUpperCase() + difficulty.substring(1)
            : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.textTertiary.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.language, // Globe icon from image
                    size: 32,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(width: 16),
                // Main Content (Title, Category, Description)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // Title and Difficulty badge on the same line
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Expanded to allow title to wrap if needed
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Space before badge
                          // Difficulty Badge (aligned to right)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              // MODIFIED: Use the new label function
                              _getDifficultyLabel(),
                              style: TextStyle(
                                fontSize: 13, // Match image
                                fontWeight: FontWeight.w600,
                                color: _getDifficultyTextColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Category Badge (commented out as in your code)
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 12,
                      //     vertical: 6,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.textSecondary.withOpacity(0.1),
                      //     borderRadius: BorderRadius.circular(6),
                      //   ),
                      //   child: Text(
                      //     category,
                      //     style: const TextStyle(
                      //       fontSize: 13,
                      //       fontWeight: FontWeight.w600,
                      //       color: AppColors.textPrimary,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Divider line
            Divider(
              color: AppColors.textTertiary.withOpacity(
                0.5,
              ), // Made divider subtler
              height: 1, // Keep it thin
              thickness: 1,
            ),
            const SizedBox(height: 16), // Space after divider
            // Footer: Time on left, Questions on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LEFT: Time
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '$durationMinutes min',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // RIGHT: Questions
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.trending_up, // Graph icon
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '$questionCount questions',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
