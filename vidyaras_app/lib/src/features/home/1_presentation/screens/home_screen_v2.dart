import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/components/cards/stats_card.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../2_application/notifiers/home_notifier.dart';
import '../../../../shared/presentation/widgets/adaptive_header.dart';
import '../widgets/category_icons_grid.dart';

import '../widgets/large_course_card.dart';
import '../widgets/refer_earn_card.dart';
import '../widgets/compact_course_resume_card.dart';
import '../widgets/welcome_hero.dart';
import '../widgets/section_header.dart';
import '../../../my_learning/2_application/providers/my_learning_providers.dart';

/// Home screen V2 - Exact UI match with screenshots
class HomeScreenV2 extends ConsumerWidget {
  const HomeScreenV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeNotifierProvider);
    final currentUserAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: homeState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(homeNotifierProvider.notifier).loadHomeData(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        loaded: (data) {
          final screenHeight = MediaQuery.of(context).size.height;
          final offset = screenHeight * 0.13;

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(homeNotifierProvider.notifier).refreshHomeData(),
            child: CustomScrollView(
              slivers: [
                // Header with Stats Card or Welcome Hero overlay
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Orange Header
                      AdaptiveHeader(
                        title: const Text(
                          'VidyaRas',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome back,',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              currentUserAsync.when(
                                data: (user) => user?.name ?? 'Guest',
                                loading: () => 'Loading...',
                                error: (_, __) => 'Guest',
                              ),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                        showNotification: true,
                        onNotificationTap: () {
                          // TODO: Open notifications
                        },
                        gradient: AppGradients.orange,
                        showSearch: true,
                        onSearchTap: () {
                          // TODO: Navigate to search
                        },
                        searchPlaceholder: 'Search courses, teachers...',
                      ),

                      // Overlay Content (Stats or Welcome)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: -25 - offset, // Keep the same overlap
                        child: Builder(
                          builder: (context) {
                            // LOGIC: Show Welcome Hero if user has 0 enrolled courses
                            // This treats them as a "New User"
                            final isNewUser =
                                data.userProfile.enrolledCount == 0;

                            if (isNewUser) {
                              return WelcomeHero(
                                userName:
                                    currentUserAsync.value?.name
                                        ?.split(' ')
                                        .first ??
                                    'Friend',
                                onExploreTap: () => context.push('/courses'),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: StatsCard(
                                stats: [
                                  StatCardItem(
                                    icon: Icons.school_outlined,
                                    value: data.userProfile.enrolledCount,
                                    label: 'Enrolled',
                                    iconColor: AppColors.primary,
                                  ),
                                  StatCardItem(
                                    icon: Icons
                                        .local_fire_department_outlined, // Changed to Streak/Progress
                                    value: 0, // TODO: Add streak to backend
                                    label: 'Day Streak',
                                    iconColor: AppColors.error,
                                  ),
                                  StatCardItem(
                                    icon: Icons.workspace_premium_outlined,
                                    value: data.userProfile.certificatesCount,
                                    label: 'Certificates',
                                    iconColor: AppColors.warning,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacing to account for the overlapping card (Higher for welcome card)
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (context) {
                      final isNewUser = data.userProfile.enrolledCount == 0;
                      // Welcome card is taller than stats card
                      return SizedBox(height: (isNewUser ? 70 : 50) + offset);
                    },
                  ),
                ),

                // Category Icons Grid (Moved UP for new users to encourage discovery)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: CategoryIconsGrid(
                      categories: const [
                        CategoryIconItem(
                          id: 'music',
                          label: 'Music',
                          icon: Icons.music_note,
                          color: AppColors.music,
                        ),
                        CategoryIconItem(
                          id: 'dance',
                          label: 'Dance',
                          icon: Icons.sports_gymnastics,
                          color: AppColors.arts,
                        ),
                        CategoryIconItem(
                          id: 'wellness',
                          label: 'Wellness',
                          icon: Icons.spa,
                          color: AppColors.wellness,
                        ),
                        CategoryIconItem(
                          id: 'yoga',
                          label: 'Yoga',
                          icon: Icons.self_improvement,
                          color: AppColors.yoga,
                        ),
                      ],
                      onCategoryTap: (categoryId) {
                        context.push('/courses?category=$categoryId');
                      },
                    ),
                  ),
                ),

                // Continue Learning Section (Only if they have courses)
                SliverToBoxAdapter(
                  child: Consumer(
                    builder: (context, ref, _) {
                      final enrolledCoursesAsync = ref.watch(
                        enrolledCoursesProvider,
                      );

                      return enrolledCoursesAsync.when(
                        data: (courses) {
                          if (courses.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          // Find most recently accessed course
                          final sortedCourses = [...courses]
                            ..sort((a, b) {
                              final aTime =
                                  a.lastAccessedAt ??
                                  a.enrolledAt ??
                                  DateTime(2000);
                              final bTime =
                                  b.lastAccessedAt ??
                                  b.enrolledAt ??
                                  DateTime(2000);
                              return bTime.compareTo(aTime);
                            });
                          final mostRecentCourse = sortedCourses.first;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: SectionHeader(
                                  title: 'Continue Learning',
                                  showViewAll: true,
                                  onViewAllTap: () =>
                                      context.push('/my-learning'),
                                ),
                              ),
                              const SizedBox(height: 16),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: CompactCourseResumeCard(
                                  course: mostRecentCourse,
                                  onResume: () {
                                    context.push(
                                      '/my-learning/course/${mostRecentCourse.id}',
                                    );
                                  },
                                  onViewAll: () {
                                    context.push('/my-learning');
                                  },
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      );
                    },
                  ),
                ),

                // Featured / Recommended Section
                if (data.recommendedCourses.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SectionHeader(
                        title: 'Featured Courses',
                        subtitle: 'Handpicked for your interests',
                        showViewAll: true,
                        onViewAllTap: () => context.push('/courses'),
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 16)),

                  // Featured Courses - Horizontal Carousel
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 310, // Increased from 260 to prevent overflow
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: data.recommendedCourses.length > 6
                            ? 6
                            : data.recommendedCourses.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final course = data.recommendedCourses[index];
                          // Use a smaller width for better density
                          return SizedBox(
                            width:
                                220, // Slightly wider to help horizontal text
                            child: LargeCourseCard(
                              title: course.title,
                              instructor: course.instructor,
                              thumbnailUrl: course.thumbnailUrl,
                              rating: course.rating,
                              reviewCount: course.reviewCount,
                              studentCount: course.enrolledCount,
                              duration: course.duration,
                              price: course.price,
                              // Hide EMI on small cards to reduce clutter
                              hasFreeTrial: course.hasFreeTrial,
                              isLive: course.isLive,
                              isRecorded: course.isRecorded,
                              onTap: () => context.push('/course/${course.id}'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],

                // Free Courses Section
                if (data.freeCourses.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SectionHeader(
                        title: 'Free Courses',
                        subtitle: 'Start learning without any cost',
                        showViewAll: true,
                        onViewAllTap: () => context.push('/courses?price=free'),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 310, // Increased from 260
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: data.freeCourses.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final course = data.freeCourses[index];
                          return SizedBox(
                            width: 220, // Slightly wider
                            child: LargeCourseCard(
                              title: course.title,
                              instructor: course.instructor,
                              thumbnailUrl: course.thumbnailUrl,
                              rating: course.rating,
                              reviewCount: course.reviewCount,
                              studentCount: course.enrolledCount,
                              duration: course.duration,
                              isFree: true,
                              isRecorded: course.isRecorded,
                              onTap: () => context.push('/course/${course.id}'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],

                // Refer & Earn Card
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ReferEarnCard(),
                  ),
                ),

                // Bottom spacing for nav bar
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        },
      ),
    );
  }
}
