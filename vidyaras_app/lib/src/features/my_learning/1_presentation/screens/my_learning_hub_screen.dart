import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../widgets/enrolled_course_card.dart';
import '../widgets/upcoming_live_class_banner.dart';
import '../widgets/learning_summary_card.dart';

/// My Learning Hub Screen
/// Shows all enrolled courses with progress tracking
class MyLearningHubScreen extends ConsumerWidget {
  const MyLearningHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final upcomingClassesAsync = ref.watch(upcomingLiveClassesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            const SliverAppBar(
              expandedHeight: 0,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.background,
              title: Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'My Learning',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              centerTitle: false,
            ),

            // Learning Summary Stats
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: LearningSummaryCard(),
              ),
            ),

            // Upcoming Live Classes Banner
            upcomingClassesAsync.when(
              data: (classes) {
                if (classes.isEmpty) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 24,
                    ),
                    child: UpcomingLiveClassBanner(
                      liveClasses: classes.take(3).toList(),
                    ),
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, __) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),

            // Enrolled Courses List
            enrolledCoursesAsync.when(
              data: (courses) {
                if (courses.isEmpty) {
                  return SliverFillRemaining(
                    child: _EmptyState(
                      onExploreCourses: () => context.go('/courses'),
                    ),
                  );
                }

                // Group courses by progress status
                final inProgress = courses
                    .where((c) => c.progress > 0 && c.progress < 1.0)
                    .toList();
                final notStarted = courses
                    .where((c) => c.progress == 0)
                    .toList();
                final completed = courses
                    .where((c) => c.progress >= 1.0)
                    .toList();

                return SliverList(
                  delegate: SliverChildListDelegate([
                    // In Progress Section
                    if (inProgress.isNotEmpty) ...[
                      _SectionHeader(
                        icon: Icons.play_circle_fill,
                        title: 'Continue Learning',
                        count: inProgress.length,
                        iconColor: AppColors.primary,
                        showDivider: false,
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 16),
                      ...inProgress.map(
                        (course) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: EnrolledCourseCard(
                            course: course,
                            onTap: () => context.push(
                              '/my-learning/course/${course.id}',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Not Started Section
                    if (notStarted.isNotEmpty) ...[
                      _SectionHeader(
                        icon: Icons.fiber_new_outlined,
                        title: 'Start Learning',
                        count: notStarted.length,
                        iconColor: AppColors.accent,
                      ),
                      const SizedBox(height: 16),
                      ...notStarted.map(
                        (course) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: EnrolledCourseCard(
                            course: course,
                            onTap: () => context.push(
                              '/my-learning/course/${course.id}',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Completed Section
                    if (completed.isNotEmpty) ...[
                      _SectionHeader(
                        icon: Icons.check_circle_outline,
                        title: 'Completed',
                        count: completed.length,
                        iconColor: AppColors.success,
                      ),
                      const SizedBox(height: 16),
                      ...completed.map(
                        (course) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: EnrolledCourseCard(
                            course: course,
                            onTap: () => context.push(
                              '/my-learning/course/${course.id}',
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 40),
                  ]),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(child: Text('Error: ${error.toString()}')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.count,
    required this.iconColor,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final int count;
  final Color iconColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDivider)
          Container(
            height: 1,
            color: AppColors.textSecondary.withValues(alpha: 0.1),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: iconColor),
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
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onExploreCourses});

  final VoidCallback onExploreCourses;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_outlined,
                size: 64,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Enrolled Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Start your learning journey by exploring courses',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onExploreCourses,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('Explore Courses'),
            ),
          ],
        ),
      ),
    );
  }
}
