import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../../3_domain/models/lecture.dart';
import '../../3_domain/models/enrolled_course.dart';

/// Tab content showing course lessons/lectures
/// Displays sections with lectures, showing completion and lock status
class LessonsTabContent extends ConsumerWidget {
  const LessonsTabContent({super.key, required this.courseId});

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseAsync = ref.watch(courseDetailsProvider(courseId: courseId));

    return courseAsync.when(
      data: (course) {
        if (course.sections.isEmpty && course.lectures.isEmpty) {
          return _EmptyState();
        }

        // Use pre-grouped lectures from the course model
        final lecturesByModule = course.lecturesBySection;

        // If we have sections, use them to order the display
        if (course.sections.isNotEmpty) {
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: course.sections.length,
            itemBuilder: (context, index) {
              final section = course.sections[index];
              final sectionLectures = lecturesByModule[section.id] ?? [];

              if (sectionLectures.isEmpty) {
                // Skip empty sections if desired, or show empty state
                // For now we show them as they might have description
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _SectionCard(
                  title: section.title,
                  completed: section.completedCount,
                  total: section.lectureCount,
                  lectures: sectionLectures,
                  courseId: courseId,
                ),
              );
            },
          );
        }

        // Fallback for courses without sections (shouldn't happen with new architecture, but safe to handle)
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _SectionCard(
              title: 'Course Content',
              completed: course.lectures.where((l) => l.isCompleted).length,
              total: course.lectures.length,
              lectures: course.lectures,
              courseId: courseId,
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          Center(child: Text('Error: ${error.toString()}')),
    );
  }
}

class _SectionCard extends StatefulWidget {
  const _SectionCard({
    required this.title,
    required this.completed,
    required this.total,
    required this.lectures,
    required this.courseId,
  });

  final String title;
  final int completed;
  final int total;
  final List<Lecture> lectures;
  final String courseId;

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Section Header
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.completed}/${widget.total} lectures completed',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Progress Circle
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          value: widget.total > 0
                              ? widget.completed / widget.total
                              : 0,
                          strokeWidth: 3,
                          backgroundColor: AppColors.surfaceLight,
                          valueColor: AlwaysStoppedAnimation(AppColors.primary),
                        ),
                      ),
                      Text(
                        '${((widget.completed / widget.total) * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),

          // Lectures List
          if (_isExpanded) ...[
            const Divider(height: 1),
            ...widget.lectures.map(
              (lecture) =>
                  _LectureItem(lecture: lecture, courseId: widget.courseId),
            ),
          ],
        ],
      ),
    );
  }
}

class _LectureItem extends StatelessWidget {
  const _LectureItem({required this.lecture, required this.courseId});

  final Lecture lecture;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: lecture.isLocked
          ? null
          : () {
              // TODO: Navigate to video player or lecture details
              // For now, just show a message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Playing: ${lecture.title}'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.surfaceLight, width: 1),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: lecture.isCompleted
                        ? AppColors.success.withValues(alpha: 0.1)
                        : lecture.isLocked
                        ? AppColors.surfaceLight
                        : AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    lecture.isCompleted
                        ? Icons.check_circle
                        : lecture.isLocked
                        ? Icons.lock
                        : Icons.play_circle_outline,
                    size: 20,
                    color: lecture.isCompleted
                        ? AppColors.success
                        : lecture.isLocked
                        ? AppColors.textTertiary
                        : AppColors.primary,
                  ),
                ),

                const SizedBox(width: 12),

                // Lecture Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lecture.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: lecture.isLocked
                              ? AppColors.textTertiary
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (lecture.durationMinutes != null) ...[
                            Icon(
                              Icons.schedule,
                              size: 14,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${lecture.durationMinutes} min',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Icon(
                            _getTypeIcon(lecture.type),
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getTypeLabel(lecture.type),
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Quiz Prompt (if lecture requires quiz)
            if (lecture.requiredQuizId != null) ...[
              const SizedBox(height: 12),
              _QuizPrompt(
                lectureId: lecture.id,
                quizId: lecture.requiredQuizId!,
                isCompleted: lecture.isCompleted,
              ),
            ],

            // Locked Message
            if (lecture.isLocked && lecture.requiredQuizId != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: AppColors.warning,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Complete the required quiz to unlock this lecture',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'live':
        return Icons.videocam;
      case 'reading':
        return Icons.article_outlined;
      case 'practice':
        return Icons.edit_note;
      default:
        return Icons.circle;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'video':
        return 'Video';
      case 'live':
        return 'Live Session';
      case 'reading':
        return 'Reading';
      case 'practice':
        return 'Practice';
      default:
        return type;
    }
  }
}

class _QuizPrompt extends StatelessWidget {
  const _QuizPrompt({
    required this.lectureId,
    required this.quizId,
    required this.isCompleted,
  });

  final String lectureId;
  final String quizId;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to Tests screen with this quiz
        context.push('/tests/quiz/$quizId');
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isCompleted
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isCompleted
                ? AppColors.success.withValues(alpha: 0.3)
                : AppColors.primary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isCompleted ? Icons.check_circle : Icons.quiz_outlined,
              size: 20,
              color: isCompleted ? AppColors.success : AppColors.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isCompleted ? 'Quiz Completed' : 'Quiz Required',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isCompleted
                          ? AppColors.success
                          : AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isCompleted
                        ? 'You\'ve passed the required quiz'
                        : 'Complete this quiz to unlock next lecture',
                    style: TextStyle(
                      fontSize: 11,
                      color: isCompleted
                          ? AppColors.success
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: isCompleted ? AppColors.success : AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Lessons Available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Course content will be available soon',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
