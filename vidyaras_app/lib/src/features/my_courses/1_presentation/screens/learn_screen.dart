import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidyaras_app/src/features/home/2_application/notifiers/home_notifier.dart';
import 'package:vidyaras_app/src/features/home/2_application/state/home_state.dart';
import 'package:vidyaras_app/src/features/my_courses/1_presentation/widgets/my_courses_list_view.dart';
import 'package:vidyaras_app/src/features/my_courses/2_application/providers/my_courses_providers.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';
import 'package:vidyaras_app/src/shared/presentation/widgets/courses/all_courses_tab_content.dart';

class LearnScreen extends ConsumerStatefulWidget {
  const LearnScreen({super.key});

  @override
  ConsumerState<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends ConsumerState<LearnScreen> {
  int _tabIndex = 0;

  void _switchTab(int index) {
    if (_tabIndex == index) return;
    setState(() => _tabIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(myCoursesFilterControllerProvider);
    final coursesAsync = ref.watch(myEnrolledCoursesProvider);
    final homeState = ref.watch(homeNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text(
          'Learn',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_edu_outlined),
            tooltip: 'Tests',
            onPressed: () => context.goNamed('main', extra: 2),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SegmentedTabs(
              selectedIndex: _tabIndex,
              onChanged: _switchTab,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _tabIndex == 0
                  ? _buildMyCoursesTab(
                      coursesAsync: coursesAsync,
                      filter: filter,
                      onFilterChanged: (value) => ref
                          .read(myCoursesFilterControllerProvider.notifier)
                          .update(value),
                    )
                  : _buildExploreTab(homeState),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyCoursesTab({
    required AsyncValue<List<EnrolledCourse>> coursesAsync,
    required MyCoursesFilter filter,
    required ValueChanged<MyCoursesFilter> onFilterChanged,
  }) {
    return coursesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _ErrorState(
        message: error is Exception ? error.toString() : 'Unable to load courses',
        onRetry: () => ref.invalidate(myEnrolledCoursesProvider),
      ),
      data: (courses) => MyCoursesListView(
        courses: courses,
        currentFilter: filter,
        onFilterChanged: onFilterChanged,
        onSwitchToExplore: () => _switchTab(1),
        onOpenCourse: (course) => _openCourseDetail(course),
        onContinueCourse: (course) => _continueCourse(course),
        onGoToTests: (_) => context.goNamed('main', extra: 2),
      ),
    );
  }

  Widget _buildExploreTab(HomeState homeState) {
    return homeState.when(
      initial: () {
        ref.read(homeNotifierProvider.notifier).loadHomeData();
        return const Center(child: CircularProgressIndicator());
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (message) => _ErrorState(
        message: message,
        onRetry: () => ref.read(homeNotifierProvider.notifier).loadHomeData(),
      ),
      loaded: (data) {
        final otherCourses = data.recommendedCourses
            .where((course) => !data.myCourses.contains(course))
            .toList();
        return AllCoursesTabContent(
          recommendedCourses: data.recommendedCourses,
          freeCourses: data.freeCourses,
          otherCourses: otherCourses,
        );
      },
    );
  }

  void _openCourseDetail(EnrolledCourse course) {
    context.push('/learn/course/${course.courseId}');
  }

  void _continueCourse(EnrolledCourse course) {
    final lectureId = course.nextLecture?.lectureId;
    context.push(
      '/learn/course/${course.courseId}',
      extra: lectureId == null ? null : {'focusLectureId': lectureId},
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final labels = ['My Courses', 'Explore'];
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final selected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
