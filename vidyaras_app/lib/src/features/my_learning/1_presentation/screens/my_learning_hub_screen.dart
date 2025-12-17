import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/widgets/adaptive_header.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../widgets/enrolled_course_card.dart';

/// My Learning Hub Screen - Shows all enrolled courses
/// Accessible via Learning tab in bottom navigation
class MyLearningHubScreen extends ConsumerWidget {
  const MyLearningHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: AdaptiveHeader(
              title: const Text(
                'My Learning',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              subtitle: const Text(
                'Continue your journey',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              showNotification: true,
              onNotificationTap: () {
                // TODO: Open notifications
              },
              gradient: AppGradients.purple,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Enrolled Courses
          enrolledCoursesAsync.when(
            data: (courses) {
              if (courses.isEmpty) {
                return SliverFillRemaining(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        size: 80,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'No Courses Enrolled',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Start learning by exploring our courses',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () => context.push('/courses'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.explore),
                        label: const Text(
                          'Browse Courses',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == 0) {
                      // Header row
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${courses.length} ${courses.length == 1 ? 'Course' : 'Courses'}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => context.push('/courses'),
                              icon: const Icon(Icons.add, size: 20),
                              label: const Text('Browse More'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final course = courses[index - 1];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: EnrolledCourseCard(
                        course: course,
                        onTap: () {
                          context.push('/my-learning/course/${course.id}');
                        },
                      ),
                    );
                  }, childCount: courses.length + 1),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stackTrace) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: $error',
                      style: const TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(enrolledCoursesProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}
