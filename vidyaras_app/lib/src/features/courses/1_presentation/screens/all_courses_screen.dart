import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../home/1_presentation/widgets/explore_course_card.dart';
import '../../2_application/courses_controller.dart';
import '../widgets/course_filters_bottom_sheet.dart';

class AllCoursesScreen extends ConsumerStatefulWidget {
  const AllCoursesScreen({super.key, this.initialCategory});

  final String? initialCategory;

  @override
  ConsumerState<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends ConsumerState<AllCoursesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Auto-select category if provided
    if (widget.initialCategory != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(coursesControllerProvider.notifier)
            .selectCategory(widget.initialCategory!);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(coursesControllerProvider);
    final controller = ref.read(coursesControllerProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onSurface,
                size: 20,
              ),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        title: Text(
          'Explore Courses',
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar with Filter Badge
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: controller.searchCourses,
                  decoration: InputDecoration(
                    hintText: 'Search all categories...',
                    hintStyle: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    prefixIcon: Icon(
                      LucideIcons.search,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => CourseFiltersBottomSheet(
                            selectedCategory: state.selectedCategory,
                            onApplyFilters: (category) {
                              controller.selectCategory(category);
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: Icon(
                          LucideIcons.slidersHorizontal,
                          color: colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                // Filter count badge overlay
                if (state.selectedCategory != 'All')
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Center(
                        child: Text(
                          '1',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Count and Sort Row
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${state.filteredCourses.length} Courses found',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Sort: ',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Popular',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Course List
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.failure != null
                ? Center(child: Text('Error: ${state.failure?.message}'))
                : state.filteredCourses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.searchX,
                          size: 48,
                          color: colorScheme.onSurfaceVariant.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No courses found',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredCourses.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final course = state.filteredCourses[index];
                      // Use mock/fallback values for properties not yet in Course model
                      return ExploreCourseCard(
                        title: course.title,
                        instructor: course.instructor,
                        thumbnailUrl: course.thumbnailUrl,
                        rating: course.rating,
                        price: course.price,
                        duration: course.duration ?? '12 Hours',
                        category:
                            (course.categories != null &&
                                course.categories!.isNotEmpty)
                            ? course.categories!.first.toUpperCase()
                            : 'Music', // Default to MUSIC to match design vibe if missing (title in design is "Classical Hindustani")
                        lessonCount: 24,
                        onTap: () {
                          // Navigate to course detail
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
