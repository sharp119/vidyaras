import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/home/3_domain/models/course.dart';
import '../../theme/app_colors.dart';
import '../../components/cards/course_card.dart';
import 'empty_courses_widget.dart';

/// My Courses tab content
/// Shows enrolled courses grouped by progress status
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
      padding: const EdgeInsets.all(20),
      children: [
        // In Progress Section
        if (inProgressCourses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.play_circle_outline,
            title: 'Continue Learning',
            count: inProgressCourses.length,
            iconColor: AppColors.primary,
          ),
          const SizedBox(height: 16),
          ...inProgressCourses.map((course) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CourseCard(
                  title: course.title,
                  instructor: course.instructor,
                  thumbnailUrl: course.thumbnailUrl,
                  rating: course.rating,
                  price: course.price,
                  progress: course.progress,
                  onTap: () => context.push('/course/${course.id}'),
                ),
              )),
          const SizedBox(height: 16),
        ],

        // Not Started Section
        if (notStartedCourses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.fiber_new_outlined,
            title: 'Start Learning',
            count: notStartedCourses.length,
            iconColor: AppColors.accent,
          ),
          const SizedBox(height: 16),
          ...notStartedCourses.map((course) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CourseCard(
                  title: course.title,
                  instructor: course.instructor,
                  thumbnailUrl: course.thumbnailUrl,
                  rating: course.rating,
                  price: course.price,
                  progress: course.progress,
                  onTap: () => context.push('/course/${course.id}'),
                ),
              )),
          const SizedBox(height: 16),
        ],

        // Completed Section
        if (completedCourses.isNotEmpty) ...[
          _SectionHeader(
            icon: Icons.check_circle_outline,
            title: 'Completed',
            count: completedCourses.length,
            iconColor: AppColors.success,
          ),
          const SizedBox(height: 16),
          ...completedCourses.map((course) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CourseCard(
                  title: course.title,
                  instructor: course.instructor,
                  thumbnailUrl: course.thumbnailUrl,
                  rating: course.rating,
                  price: course.price,
                  progress: course.progress,
                  onTap: () => context.push('/course/${course.id}'),
                ),
              )),
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
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
