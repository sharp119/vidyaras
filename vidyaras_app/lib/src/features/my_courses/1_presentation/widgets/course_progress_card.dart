import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

class CourseProgressCard extends StatelessWidget {
  const CourseProgressCard({
    super.key,
    required this.course,
    required this.onOpenCourse,
    required this.onContinue,
    required this.onGoToTests,
  });

  final EnrolledCourse course;
  final VoidCallback onOpenCourse;
  final VoidCallback onContinue;
  final VoidCallback onGoToTests;

  @override
  Widget build(BuildContext context) {
    final nextLecture = course.nextLecture;
    final isLocked = nextLecture?.isLocked == true;
    final progressPercent =
        course.progressPercent.clamp(0.0, 1.0).toDouble();
    final progressLabel =
        '${course.completedLectures}/${course.totalLectures} Lectures Completed';

    return InkWell(
      onTap: onOpenCourse,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CourseThumbnail(imageUrl: course.thumbnailUrl),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _StatusChip(
                        completed: course.isCompleted,
                        isLive: course.isLive,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        course.instructor,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (course.duration != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          course.duration!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progressPercent,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: AppColors.surfaceLight,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              progressLabel,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            if (course.isCompleted)
              _CompletedFooter(
                onOpenCourse: onOpenCourse,
              )
            else if (nextLecture == null)
              _ContinueFooter(
                buttonLabel: 'View Course',
                helperText: 'Open curriculum to explore lectures.',
                onPressed: onOpenCourse,
              )
            else if (isLocked)
              _LockedFooter(
                quizRequirement: nextLecture.requiredQuiz,
                onGoToTests: onGoToTests,
              )
            else
              _ActiveFooter(
                nextLectureTitle: nextLecture.title,
                sectionTitle: nextLecture.sectionTitle,
                onContinue: onContinue,
              ),
          ],
        ),
      ),
    );
  }
}

class _CourseThumbnail extends StatelessWidget {
  const _CourseThumbnail({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 88,
        height: 88,
        color: AppColors.surfaceLight,
        child: imageUrl == null
            ? const Icon(Icons.menu_book, color: AppColors.primary)
            : CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.menu_book,
                  color: AppColors.primary,
                ),
              ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.completed,
    required this.isLive,
  });

  final bool completed;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    late final (Color bg, Color fg, IconData icon, String label) data;
    if (completed) {
      data = (
        AppColors.success.withOpacity(0.12),
        AppColors.success,
        Icons.check_circle,
        'Completed'
      );
    } else if (isLive) {
      data = (
        const Color(0xFFFFE2E2),
        const Color(0xFFE53935),
        Icons.wifi_tethering,
        'Live + Recorded'
      );
    } else {
      data = (
        AppColors.primary.withOpacity(0.12),
        AppColors.primary,
        Icons.play_circle,
        'In Progress'
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: data.$1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(data.$3, size: 16, color: data.$2),
          const SizedBox(width: 6),
          Text(
            data.$4,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: data.$2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveFooter extends StatelessWidget {
  const _ActiveFooter({
    required this.nextLectureTitle,
    required this.sectionTitle,
    required this.onContinue,
  });

  final String nextLectureTitle;
  final String sectionTitle;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.video_library, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                nextLectureTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        if (sectionTitle.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton(
          onPressed: onContinue,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _LockedFooter extends StatelessWidget {
  const _LockedFooter({
    required this.quizRequirement,
    required this.onGoToTests,
  });

  final QuizRequirement? quizRequirement;
  final VoidCallback onGoToTests;

  @override
  Widget build(BuildContext context) {
    final quizTitle = quizRequirement?.title ?? 'Previous quiz';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFB74D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lock, size: 18, color: Color(0xFFFF8F00)),
              SizedBox(width: 8),
              Text(
                'Lecture Locked',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFEF6C00),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Complete '$quizTitle' in Tests to unlock the next lecture.",
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: onGoToTests,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFEF6C00),
              side: const BorderSide(color: Color(0xFFFFB74D)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Go to Tests',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedFooter extends StatelessWidget {
  const _CompletedFooter({
    required this.onOpenCourse,
  });

  final VoidCallback onOpenCourse;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.emoji_events, size: 20, color: AppColors.success),
            SizedBox(width: 8),
            Text(
              'Course completed',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: onOpenCourse,
          child: const Text(
            'View Course',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _ContinueFooter extends StatelessWidget {
  const _ContinueFooter({
    required this.buttonLabel,
    required this.helperText,
    required this.onPressed,
  });

  final String buttonLabel;
  final String helperText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          helperText,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: Text(
            buttonLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
