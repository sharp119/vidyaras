import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../../../shared/presentation/components/cards/stats_card.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../2_application/notifiers/home_notifier.dart';
import '../../../../shared/presentation/widgets/adaptive_header.dart';
import '../widgets/category_pills.dart';
import '../widgets/course_list_card.dart';
import '../widgets/large_course_card.dart';
import '../widgets/refer_earn_card.dart';

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
                // Header with Stats Card overlay
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
                      // Stats Card positioned to overlap header bottom
                      Positioned(
                        left: 20,
                        right: 20,
                        bottom: -25 - offset,
                        child: StatsCard(
                          stats: [
                            StatCardItem(
                              icon: Icons.play_circle_outline,
                              value: data.userProfile.enrolledCount,
                              label: 'Active',
                              iconColor: AppColors.primary,
                            ),
                            StatCardItem(
                              icon: Icons.emoji_events_outlined,
                              value: data.userProfile.completedCount,
                              label: 'Completed',
                              iconColor: AppColors.success,
                            ),
                            StatCardItem(
                              icon: Icons.card_giftcard,
                              value: data.userProfile.referralPoints,
                              label: 'Points',
                              iconColor: AppColors.accent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacing to account for the overlapping stats card
                SliverToBoxAdapter(child: SizedBox(height: 50 + offset)),

                // Category Pills
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    child: CategoryPills(
                      categories: const [
                        CategoryItem(
                          id: 'music',
                          label: 'Music',
                          icon: Icons.music_note,
                          color: Color(0xFFA855F7),
                        ),
                        CategoryItem(
                          id: 'wellness',
                          label: 'Wellness',
                          icon: Icons.spa,
                          color: Color(0xFF10B981),
                        ),
                        CategoryItem(
                          id: 'yoga',
                          label: 'Yoga',
                          icon: Icons.self_improvement,
                          color: Color(0xFF8B5CF6),
                        ),
                        CategoryItem(
                          id: 'arts',
                          label: 'Arts',
                          icon: Icons.palette,
                          color: Color(0xFFEC4899),
                        ),
                      ],
                      onCategoryTap: (categoryId) {
                        // Navigate to all courses
                        // In a real app we would pass the categoryId to pre-filter
                        context.push('/courses');
                      },
                    ),
                  ),
                ),

                // Continue Learning Section
                if (data.myCourses.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Continue Learning',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push('/my-learning');
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final course = data.myCourses[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CourseListCard(
                            title: course.title,
                            instructor: course.instructor,
                            thumbnailUrl: course.thumbnailUrl,
                            rating: course.rating,
                            price: course.price,
                            onTap: () {
                              // TODO: Navigate to course details
                            },
                          ),
                        );
                      }, childCount: data.myCourses.length),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],

                // Recommended For You Section
                if (data.recommendedCourses.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              size: 20,
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Recommended For You',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => context.push('/courses'),
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 8,
                        bottom: 16,
                      ),
                      child: Text(
                        'Based on your interests in ${data.userProfile.interests?.join(', ') ?? 'music, wellness'}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  // Vertical list of recommended courses (show first 3-4)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final course = data.recommendedCourses[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: LargeCourseCard(
                              title: course.title,
                              instructor: course.instructor,
                              thumbnailUrl: course.thumbnailUrl,
                              rating: course.rating,
                              reviewCount: course.reviewCount,
                              studentCount: course.enrolledCount,
                              duration: course.duration,
                              price: course.price,
                              emiPrice: course.price != null
                                  ? '₹1666/mo'
                                  : null,
                              hasFreeTrial: course.hasFreeTrial,
                              isLive: course.isLive,
                              isRecorded: course.isRecorded,
                              onTap: () => context.push('/course/${course.id}'),
                            ),
                          );
                        },
                        childCount: data.recommendedCourses.length > 4
                            ? 4
                            : data.recommendedCourses.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],

                // Free Courses Section
                if (data.freeCourses.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Free Courses',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Start learning today',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Free',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 380,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: data.freeCourses.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final course = data.freeCourses[index];
                          return SizedBox(
                            width: 320,
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
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          );
        },
      ),
    );
  }
}
