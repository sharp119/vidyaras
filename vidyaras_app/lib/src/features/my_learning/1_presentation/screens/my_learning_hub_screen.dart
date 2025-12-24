import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/widgets/adaptive_header.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../widgets/enrolled_course_card.dart';
import '../../../home/2_application/notifiers/home_notifier.dart';
import '../../../home/1_presentation/widgets/large_course_card.dart';
import '../../../home/1_presentation/widgets/section_header.dart';

/// My Learning Hub Screen
/// Implements "Recommendation 3": Clean Inspiration Header
class MyLearningHubScreen extends ConsumerWidget {
  const MyLearningHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledCoursesAsync = ref.watch(enrolledCoursesProvider);
    final homeState = ref.watch(homeNotifierProvider);

    // Get user name for personalized greeting
    final userName = homeState.maybeWhen(
      loaded: (data) {
        final name = data.userProfile.name;
        if (name.isEmpty) return 'Learner';
        return name.split(' ').first;
      },
      orElse: () => 'Learner',
    );

    final isLoading = enrolledCoursesAsync.isLoading;
    final hasCourses = enrolledCoursesAsync.valueOrNull?.isNotEmpty ?? false;
    final isNewUser = !isLoading && !hasCourses;

    // Dynamic Copy
    final titleText = isNewUser ? 'Start Learning, $userName' : 'My Learning';
    final subtitleText = isNewUser
        ? 'The expert in anything was once a beginner.'
        : 'Continue your journey';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Background Gradient with Bubbles
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: AppGradients.primary,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -60,
                          right: -40,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          left: 20,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Adaptive Header (Clean - No Search)
                AdaptiveHeader(
                  title: Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  subtitle: Text(
                    subtitleText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  showNotification: true,
                  onNotificationTap: () {},
                  gradient: const LinearGradient(
                    colors: [Colors.transparent, Colors.transparent],
                  ),
                  backgroundColor: Colors.transparent,
                  // Search removed as per Recommendation 3
                ),
              ],
            ),
          ),

          // Filters (Only functional when user has courses)
          if (hasCourses)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(label: 'All', isSelected: true),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'In Progress'),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'Completed'),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'Downloaded'),
                      const SizedBox(width: 8),
                      _FilterChip(label: 'Certificates'),
                    ],
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // Content
          enrolledCoursesAsync.when(
            data: (courses) {
              if (courses.isEmpty) {
                // Reuse extraction logic
                final recommendedCourses = homeState.maybeWhen(
                  loaded: (data) => data.recommendedCourses,
                  orElse: () => [],
                );

                return SliverList(
                  delegate: SliverChildListDelegate([
                    // Hero Empty State Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.rocket_launch_rounded,
                              size: 48,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Start Your Adventure',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'You haven\'t enrolled in any courses yet. Explore our catalog to find your next skill and unlock your potential.',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textSecondary,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => context.push('/courses'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                                shadowColor: AppColors.primary.withOpacity(0.4),
                              ),
                              child: const Text(
                                'Browse All Courses',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Recommended Courses
                    if (recommendedCourses.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SectionHeader(
                          title: 'Recommended for You',
                          subtitle: 'Popular courses to get you started',
                          showViewAll: true,
                          onViewAllTap: () => context.push('/courses'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 310,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: recommendedCourses.length > 5
                              ? 5
                              : recommendedCourses.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final course = recommendedCourses[index];
                            return SizedBox(
                              width: 240,
                              child: LargeCourseCard(
                                title: course.title,
                                instructor: course.instructor,
                                thumbnailUrl: course.thumbnailUrl,
                                rating: course.rating,
                                reviewCount: course.reviewCount,
                                studentCount: course.enrolledCount,
                                duration: course.duration,
                                price: course.price,
                                hasFreeTrial: course.hasFreeTrial,
                                isLive: course.isLive,
                                isRecorded: course.isRecorded,
                                onTap: () =>
                                    context.push('/course/${course.id}'),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ]),
                );
              }

              // List of Enrolled Courses
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == 0) {
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
                            // Improved Browse Button
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
            // Improved Loading/Error States logic
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
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading courses',
                      style: TextStyle(color: AppColors.textSecondary),
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _FilterChip({required this.label, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.mediumGray,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
