import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/home/3_domain/models/course.dart';
import '../../../../features/home/1_presentation/widgets/large_course_card.dart';
import '../../theme/app_colors.dart';
import '../../components/cards/course_card.dart';
import 'empty_courses_widget.dart';

/// All Courses tab content
/// Shows browse/discover courses with recommended and free sections
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
    final hasAnyCourses = recommendedCourses.isNotEmpty ||
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      children: [
        // Recommended For You Section
        if (recommendedCourses.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: recommendedCourses.map((course) {
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
          const SizedBox(height: 16),
        ],

        // Free Courses Section
        if (freeCourses.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.card_giftcard,
                        size: 20,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Free Courses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
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
                    color: AppColors.success.withValues(alpha: 0.1),
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
          const SizedBox(height: 16),
          SizedBox(
            height: 340,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: freeCourses.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
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
          const SizedBox(height: 16),
        ],

        // Other Courses Section
        if (otherCourses.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'More Courses',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
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

        const SizedBox(height: 20),
      ],
    );
  }
}
