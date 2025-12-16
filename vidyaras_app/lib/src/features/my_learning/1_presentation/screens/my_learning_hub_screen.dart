import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/components/cards/stats_card.dart';
import '../../../../shared/presentation/components/navigation/unified_header.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../widgets/enrolled_course_card.dart';
import '../widgets/upcoming_live_class_banner.dart';

/// My Learning Hub Screen
/// Shows all enrolled courses with progress tracking
class MyLearningHubScreen extends ConsumerWidget {
  const MyLearningHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final upcomingClassesAsync = ref.watch(upcomingLiveClassesProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: enrolledCoursesAsync.when(
        data: (courses) {
          // Calculate stats from enrolled courses
          final completedCount = courses.where((c) => c.progress >= 1.0).length;
          final totalHours = courses.fold<int>(
            0,
            (sum, course) => sum + (course.totalDurationMinutes ~/ 60),
          );
          // Day streak: For now, use active courses as a proxy
          // In the future, this should come from a dedicated streak tracking system
          final activeCount = courses
              .where((c) => c.progress > 0 && c.progress < 1.0)
              .length;
          final dayStreak = activeCount > 0 ? activeCount : 0;

          final screenHeight = MediaQuery.of(context).size.height;
          final offset = screenHeight * 0.13;

          return CustomScrollView(
            slivers: [
              // Colored Header with Stats Card overlay
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Unified Header with orange gradient
                    UnifiedHeader(
                      title: 'Track your progress and achievements',
                      gradient: AppGradients.orange,
                    ),
                    // Stats Card positioned to overlap header bottom
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: -25 - offset,
                      child: StatsCard(
                        stats: [
                          StatCardItem(
                            icon: Icons.local_fire_department,
                            value: dayStreak,
                            label: 'Day Streak',
                            iconColor: AppColors.accent,
                          ),
                          StatCardItem(
                            icon: Icons.timer_outlined,
                            value: '${totalHours}h',
                            label: 'Hours Spent',
                            iconColor: AppColors.primary,
                          ),
                          StatCardItem(
                            icon: Icons.check_circle_outline,
                            value: completedCount,
                            label: 'Completed',
                            iconColor: AppColors.success,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Spacing to account for the overlapping stats card
              SliverToBoxAdapter(child: SizedBox(height: 50 + offset)),

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
                loading: () =>
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
                error: (_, __) =>
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
              ),

              // Enrolled Courses List
              if (courses.isEmpty)
                SliverFillRemaining(
                  child: _EmptyState(
                    onExploreCourses: () => context.go('/courses'),
                  ),
                )
              else
                _buildCoursesList(context, courses),
            ],
          );
        },
        loading: () => Scaffold(
          backgroundColor: colorScheme.surface,
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (_, __) => Scaffold(
          backgroundColor: colorScheme.surface,
          body: const Center(child: Text('Error loading courses')),
        ),
      ),
    );
  }

  Widget _buildCoursesList(BuildContext context, List<dynamic> courses) {
    // Group courses by progress status
    final inProgress = courses
        .where((c) => c.progress > 0 && c.progress < 1.0)
        .toList();
    final notStarted = courses.where((c) => c.progress == 0).toList();
    final completed = courses.where((c) => c.progress >= 1.0).toList();

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: EnrolledCourseCard(
                course: course,
                onTap: () => context.push('/my-learning/course/${course.id}'),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: EnrolledCourseCard(
                course: course,
                onTap: () => context.push('/my-learning/course/${course.id}'),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: EnrolledCourseCard(
                course: course,
                onTap: () => context.push('/my-learning/course/${course.id}'),
              ),
            ),
          ),
        ],

        const SizedBox(height: 40),
      ]),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        if (showDivider)
          Container(
            height: 1,
            color: colorScheme.outlineVariant.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const SizedBox(width: 12),
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count.toString(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppGradients.orangeFeature,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.school, size: 64, color: colorScheme.onPrimary),
            ),
            const SizedBox(height: 24),
            Text('No Enrolled Courses', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(
              'Start your learning journey by exploring courses',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
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
