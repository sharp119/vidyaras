import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/home/3_domain/models/course.dart';
import '../../../../features/home/1_presentation/widgets/large_course_card.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../components/cards/course_card.dart';
import 'empty_courses_widget.dart';

/// All Courses tab content
/// Design System: Theme typography, proper spacing
class AllCoursesTabContent extends StatelessWidget {
  const AllCoursesTabContent({
    super.key,
    required this.recommendedCourses,
    required this.freeCourses,
    required this.otherCourses,
  });

  final List<Course> recommendedCourses;
  final List<Course> freeCourses;
  final List<Course> otherCourses;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasAnyCourses =
        recommendedCourses.isNotEmpty ||
        freeCourses.isNotEmpty ||
        otherCourses.isNotEmpty;

    if (!hasAnyCourses) {
      return const EmptyCoursesWidget(
        icon: Icons.search_off,
        title: 'No Courses Found',
        message: 'Try adjusting your filters or search query',
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      children: [
        // Recommended For You Section
        if (recommendedCourses.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.button),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: AppIconSize.small,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.mdSm),
                Text(
                  'Recommended For You',
                  style: theme.textTheme.headlineMedium, // H2: 20sp
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: recommendedCourses.map((course) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
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
                        ? '₹${(int.tryParse(course.price!.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0) ~/ 3}/mo'
                        : null,
                    hasFreeTrial: course.hasFreeTrial,
                    isLive: course.isLive,
                    isRecorded: course.isRecorded,
                    onTap: () => context.push('/course/${course.id}'),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Free Courses Section
        if (freeCourses.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppRadius.button),
                      ),
                      child: const Icon(
                        Icons.card_giftcard,
                        size: AppIconSize.small,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.mdSm),
                    Text(
                      'Free Courses',
                      style: theme.textTheme.headlineMedium, // H2: 20sp
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.mdSm,
                    vertical: AppSpacing.xs + 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'Free',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 340,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: freeCourses.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final course = freeCourses[index];
                return SizedBox(
                  width: 300,
                  child: CourseCard(
                    title: course.title,
                    instructor: course.instructor,
                    thumbnailUrl: course.thumbnailUrl,
                    rating: course.rating,
                    price: 'Free',
                    onTap: () => context.push('/course/${course.id}'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        // Other Courses Section
        if (otherCourses.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Text(
              'More Courses',
              style: theme.textTheme.headlineMedium, // H2: 20sp
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 0.75,
              ),
              itemCount: otherCourses.length,
              itemBuilder: (context, index) {
                final course = otherCourses[index];
                return CourseCard(
                  title: course.title,
                  instructor: course.instructor,
                  thumbnailUrl: course.thumbnailUrl,
                  rating: course.rating,
                  price: course.price,
                  onTap: () => context.push('/course/${course.id}'),
                );
              },
            ),
          ),
        ],

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
