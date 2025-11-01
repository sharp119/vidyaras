import 'package:flutter/material.dart';
import 'package:vidyaras_app/src/features/my_courses/1_presentation/widgets/course_progress_card.dart';
import 'package:vidyaras_app/src/features/my_courses/2_application/providers/my_courses_providers.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

import 'my_courses_empty_state.dart';

class MyCoursesListView extends StatelessWidget {
  const MyCoursesListView({
    super.key,
    required this.courses,
    required this.currentFilter,
    required this.onFilterChanged,
    required this.onSwitchToExplore,
    required this.onOpenCourse,
    required this.onContinueCourse,
    required this.onGoToTests,
  });

  final List<EnrolledCourse> courses;
  final MyCoursesFilter currentFilter;
  final ValueChanged<MyCoursesFilter> onFilterChanged;
  final VoidCallback onSwitchToExplore;
  final void Function(EnrolledCourse course) onOpenCourse;
  final void Function(EnrolledCourse course) onContinueCourse;
  final void Function(EnrolledCourse course) onGoToTests;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return MyCoursesEmptyState(onExploreTap: onSwitchToExplore);
    }

    final filteredCourses = _applyFilter(courses, currentFilter);
    final stats = _buildStats(courses);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keep Learning, ${stats.total} courses',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _StatPill(
                      label: 'In Progress',
                      value: stats.inProgress,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    _StatPill(
                      label: 'Not Started',
                      value: stats.notStarted,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 8),
                    _StatPill(
                      label: 'Completed',
                      value: stats.completed,
                      color: AppColors.success,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _FilterBar(
                  currentFilter: currentFilter,
                  onFilterChanged: onFilterChanged,
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemCount: filteredCourses.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final course = filteredCourses[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                index == 0 ? 4 : 0,
                20,
                index == filteredCourses.length - 1 ? 32 : 0,
              ),
              child: CourseProgressCard(
                course: course,
                onOpenCourse: () => onOpenCourse(course),
                onContinue: () => onContinueCourse(course),
                onGoToTests: () => onGoToTests(course),
              ),
            );
          },
        ),
      ],
    );
  }

  List<EnrolledCourse> _applyFilter(
    List<EnrolledCourse> courses,
    MyCoursesFilter filter,
  ) {
    switch (filter) {
      case MyCoursesFilter.all:
        return courses;
      case MyCoursesFilter.inProgress:
        return courses
            .where((course) =>
                !course.isCompleted && course.completedLectures > 0)
            .toList();
      case MyCoursesFilter.completed:
        return courses.where((course) => course.isCompleted).toList();
    }
  }

  _CourseStats _buildStats(List<EnrolledCourse> courses) {
    var inProgress = 0;
    var notStarted = 0;
    var completed = 0;

    for (final course in courses) {
      if (course.isCompleted) {
        completed += 1;
      } else if (course.completedLectures == 0) {
        notStarted += 1;
      } else {
        inProgress += 1;
      }
    }

    return _CourseStats(
      total: courses.length,
      inProgress: inProgress,
      notStarted: notStarted,
      completed: completed,
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final MyCoursesFilter currentFilter;
  final ValueChanged<MyCoursesFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterChip(
          label: 'All',
          selected: currentFilter == MyCoursesFilter.all,
          onSelected: () => onFilterChanged(MyCoursesFilter.all),
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'In Progress',
          selected: currentFilter == MyCoursesFilter.inProgress,
          onSelected: () => onFilterChanged(MyCoursesFilter.inProgress),
        ),
        const SizedBox(width: 8),
        _FilterChip(
          label: 'Completed',
          selected: currentFilter == MyCoursesFilter.completed,
          onSelected: () => onFilterChanged(MyCoursesFilter.completed),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.textSecondary,
        ),
      ),
      selected: selected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
        ),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: color,
            child: Text(
              value.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseStats {
  const _CourseStats({
    required this.total,
    required this.inProgress,
    required this.notStarted,
    required this.completed,
  });

  final int total;
  final int inProgress;
  final int notStarted;
  final int completed;
}
