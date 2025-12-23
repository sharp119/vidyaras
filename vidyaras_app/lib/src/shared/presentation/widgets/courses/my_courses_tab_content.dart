import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/home/3_domain/models/course.dart';
import '../../../../features/home/1_presentation/widgets/course_list_card.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'empty_courses_widget.dart';

/// My Courses tab content
/// Design System: Theme typography, proper spacing
class MyCoursesTabContent extends StatelessWidget {
  const MyCoursesTabContent({
    super.key,
    required this.courses,
    required this.onSwitchToAllCourses,
  });

  final List<Course> courses;
  final VoidCallback onSwitchToAllCourses;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return EmptyCoursesWidget(
        icon: Icons.school_outlined,
        title: 'No Enrolled Courses',
        message: 'Start your learning journey by exploring courses below',
        actionText: 'Explore Courses',
        onActionPressed: onSwitchToAllCourses,
      );
    }

    // Group courses by progress status
    final inProgressCourses = courses
        .where((c) => (c.progress ?? 0) > 0 && (c.progress ?? 0) < 1.0)
        .toList();
    final notStartedCourses = courses
        .where((c) => (c.progress ?? 0) == 0)
        .toList();
    final completedCourses = courses
        .where((c) => (c.progress ?? 0) >= 1.0)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // In Progress Section
        if (inProgressCourses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.play_circle_outline,
            title: 'Continue Learning',
            count: inProgressCourses.length,
            iconColor: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.md),
          ...inProgressCourses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: CourseListCard(
                title: course.title,
                instructor: course.instructor,
                thumbnailUrl: course.thumbnailUrl,
                rating: course.rating,
                price: course.price,
                onTap: () => context.push('/course/${course.id}'),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Not Started Section
        if (notStartedCourses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.fiber_new_outlined,
            title: 'Start Learning',
            count: notStartedCourses.length,
            iconColor: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          ...notStartedCourses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: CourseListCard(
                title: course.title,
                instructor: course.instructor,
                thumbnailUrl: course.thumbnailUrl,
                rating: course.rating,
                price: course.price,
                onTap: () => context.push('/course/${course.id}'),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Completed Section
        if (completedCourses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.check_circle_outline,
            title: 'Completed',
            count: completedCourses.length,
            iconColor: AppColors.success,
          ),
          const SizedBox(height: AppSpacing.md),
          ...completedCourses.map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: CourseListCard(
                title: course.title,
                instructor: course.instructor,
                thumbnailUrl: course.thumbnailUrl,
                rating: course.rating,
                price: course.price,
                onTap: () => context.push('/course/${course.id}'),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.count,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final int count;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          child: Icon(icon, size: AppIconSize.small, color: iconColor),
        ),
        const SizedBox(width: AppSpacing.mdSm),
        Text(
          title,
          style: theme.textTheme.headlineSmall, // 18sp
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Text(
            count.toString(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
