import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../home/1_presentation/widgets/course_list_card.dart';
import '../../../home/1_presentation/widgets/category_pills.dart';
import '../../2_application/courses_controller.dart';

class AllCoursesScreen extends ConsumerStatefulWidget {
  const AllCoursesScreen({super.key});

  @override
  ConsumerState<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends ConsumerState<AllCoursesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(coursesControllerProvider);
    final controller = ref.read(coursesControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('All Courses'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: controller.searchCourses,
              decoration: InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: const Icon(LucideIcons.search),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          // Categories using existing widget
          CategoryPills(
            categories: [
              CategoryItem(
                id: 'All',
                label: 'All',
                icon: LucideIcons.layoutGrid,
                color: AppColors.primary,
              ),
              CategoryItem(
                id: 'music',
                label: 'Music',
                icon: LucideIcons.music,
                color: Colors.purple,
              ),
              CategoryItem(
                id: 'wellness',
                label: 'Wellness',
                icon: LucideIcons.heart,
                color: Colors.green,
              ),
              CategoryItem(
                id: 'dance',
                label: 'Dance',
                icon: LucideIcons.move,
                color: Colors.orange,
              ),
              CategoryItem(
                id: 'arts',
                label: 'Arts',
                icon: LucideIcons.palette,
                color: Colors.blue,
              ),
            ],
            onCategoryTap: (id) => controller.selectCategory(id),
          ),

          const SizedBox(height: 16),

          // Course List
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.failure != null
                ? Center(child: Text('Error: ${state.failure?.message}'))
                : state.filteredCourses.isEmpty
                ? const Center(child: Text('No courses found'))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredCourses.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final course = state.filteredCourses[index];
                      return CourseListCard(
                        title: course.title,
                        instructor: course.instructor,
                        thumbnailUrl: course.thumbnailUrl,
                        rating: course.rating,
                        price: course.price,
                        onTap: () {
                          // Navigate to course detail
                          // Assuming route exists from home feature
                          context.push('/course/${course.id}');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
