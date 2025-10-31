import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/live_class.dart';

/// Card widget for displaying an enrolled course
/// Shows thumbnail, title, instructor, progress, and next action
class EnrolledCourseCard extends StatelessWidget {
  const EnrolledCourseCard({
    super.key,
    required this.course,
    required this.onTap,
  });

  final EnrolledCourse course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: course.thumbnailUrl != null
                        ? CachedNetworkImage(
                            imageUrl: course.thumbnailUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.surfaceLight,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.surfaceLight,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          )
                        : Container(
                            color: AppColors.surfaceLight,
                            child: const Icon(
                              Icons.school,
                              size: 40,
                              color: AppColors.textTertiary,
                            ),
                          ),
                  ),
                ),
                // Live/Recorded Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: course.isLive
                          ? AppColors.error.withValues(alpha: 0.9)
                          : AppColors.primary.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          course.isLive
                              ? Icons.videocam
                              : Icons.play_circle_outline,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          course.isLive ? 'LIVE' : 'RECORDED',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Instructor
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          course.instructor,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${course.completedLectures}/${course.totalLectures} lectures',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            course.progressPercentage,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: course.progress,
                          minHeight: 6,
                          backgroundColor: AppColors.surfaceLight,
                          valueColor: AlwaysStoppedAnimation(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Next Action
                  if (course.nextLecture != null ||
                      course.nextLiveClass != null) ...[
                    const SizedBox(height: 12),
                    _NextActionChip(course: course),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextActionChip extends StatelessWidget {
  const _NextActionChip({required this.course});

  final EnrolledCourse course;

  @override
  Widget build(BuildContext context) {
    final nextLiveClass = course.nextLiveClass;
    final nextLecture = course.nextLecture;

    if (nextLiveClass != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.live_tv,
              size: 16,
              color: AppColors.error,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Next Live: ${nextLiveClass.formattedSchedule}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.error,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    if (nextLecture != null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.play_arrow,
              size: 16,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Continue: ${nextLecture.title}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
