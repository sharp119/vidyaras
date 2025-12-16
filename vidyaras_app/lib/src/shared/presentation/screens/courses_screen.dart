import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/home/2_application/notifiers/home_notifier.dart';
import '../../../features/home/3_domain/models/course.dart';
import '../../../features/home/1_presentation/widgets/category_pills.dart';
import '../widgets/courses/courses_tab_bar.dart';
import '../widgets/courses/course_search_bar.dart';
import '../widgets/courses/course_filters_bottom_sheet.dart';
import '../widgets/courses/my_courses_tab_content.dart';
import '../widgets/courses/all_courses_tab_content.dart';
import '../widgets/courses/selectable_category_pills.dart';

/// Courses screen - Main screen for browsing and managing courses
/// Displays My Courses and All Courses in separate tabs with search and filter
class CoursesScreen extends ConsumerStatefulWidget {
  const CoursesScreen({super.key});

  @override
  ConsumerState<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  // Local state
  int _selectedTab = 0; // 0 = My Courses, 1 = All Courses
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'all';
  CourseFilters _filters = const CourseFilters();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
      // Clear search when switching tabs
      _searchController.clear();
      _searchQuery = '';
    });
  }

  void _onCategoryChanged(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });
  }

  void _onFiltersApplied(CourseFilters newFilters) {
    setState(() {
      _filters = newFilters;
    });
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CourseFiltersBottomSheet(
        initialFilters: _filters,
        onApply: _onFiltersApplied,
      ),
    );
  }

  /// Extract numeric price from price string
  int _extractPrice(String? price) {
    if (price == null) return 999999; // Put paid courses without price at end
    final match = RegExp(r'\d+').firstMatch(price);
    return match != null ? int.parse(match.group(0)!) : 999999;
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeNotifierProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Courses', style: theme.textTheme.headlineMedium),
        centerTitle: false,
      ),
      body: homeState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: colorScheme.error),
              const SizedBox(height: 16),
              Text(
                message,
                style: theme.textTheme.bodyMedium,
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
        loaded: (homeData) {
          // Get all courses
          final allCourses = [
            ...homeData.myCourses,
            ...homeData.recommendedCourses,
            ...homeData.freeCourses,
          ];

          // Filter courses based on search, category, and filters
          List<Course> filteredCourses = allCourses;

          // Apply search query
          if (_searchQuery.isNotEmpty) {
            filteredCourses = filteredCourses.where((course) {
              final query = _searchQuery.toLowerCase();
              return course.title.toLowerCase().contains(query) ||
                  course.instructor.toLowerCase().contains(query);
            }).toList();
          }

          // Apply category filter
          if (_selectedCategory != 'all') {
            filteredCourses = filteredCourses.where((course) {
              return course.categories?.contains(_selectedCategory) ?? false;
            }).toList();
          }

          // Apply filters from bottom sheet
          if (_filters.showFreeOnly == true) {
            filteredCourses = filteredCourses.where((c) => c.isFree).toList();
          }
          if (_filters.showLiveOnly == true) {
            filteredCourses = filteredCourses.where((c) => c.isLive).toList();
          }
          if (_filters.showRecordedOnly == true) {
            filteredCourses = filteredCourses
                .where((c) => c.isRecorded)
                .toList();
          }
          if (_filters.minRating != null) {
            filteredCourses = filteredCourses
                .where((c) => c.rating >= _filters.minRating!)
                .toList();
          }

          // Apply sorting
          if (_filters.sortBy != null) {
            switch (_filters.sortBy) {
              case 'popular':
                filteredCourses.sort(
                  (a, b) => b.enrolledCount.compareTo(a.enrolledCount),
                );
                break;
              case 'rating':
                filteredCourses.sort((a, b) => b.rating.compareTo(a.rating));
                break;
              case 'price_low':
                filteredCourses.sort((a, b) {
                  final priceA = _extractPrice(a.price);
                  final priceB = _extractPrice(b.price);
                  return priceA.compareTo(priceB);
                });
                break;
            }
          }

          // Separate courses for different tabs
          final myCourses = _selectedTab == 0
              ? (_searchQuery.isEmpty &&
                        _selectedCategory == 'all' &&
                        !_filters.hasActiveFilters
                    ? homeData.myCourses
                    : filteredCourses
                          .where((c) => homeData.myCourses.contains(c))
                          .toList())
              : <Course>[];

          final recommendedCourses = _selectedTab == 1
              ? (_searchQuery.isEmpty &&
                        _selectedCategory == 'all' &&
                        !_filters.hasActiveFilters
                    ? homeData.recommendedCourses
                    : filteredCourses
                          .where((c) => homeData.recommendedCourses.contains(c))
                          .toList())
              : <Course>[];

          final freeCourses = _selectedTab == 1
              ? (_searchQuery.isEmpty &&
                        _selectedCategory == 'all' &&
                        !_filters.hasActiveFilters
                    ? homeData.freeCourses
                    : filteredCourses
                          .where((c) => homeData.freeCourses.contains(c))
                          .toList())
              : <Course>[];

          // Other courses (not in recommended or free)
          final otherCourses = _selectedTab == 1
              ? filteredCourses
                    .where(
                      (c) =>
                          !homeData.recommendedCourses.contains(c) &&
                          !homeData.freeCourses.contains(c) &&
                          !homeData.myCourses.contains(c),
                    )
                    .toList()
              : <Course>[];

          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: CourseSearchBar(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  hintText: 'Search courses or instructors...',
                  onFilterTap: _showFilters,
                ),
              ),

              // Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CoursesTabBar(
                  selectedIndex: _selectedTab,
                  onTabChanged: _onTabChanged,
                ),
              ),

              const SizedBox(height: 20),

              // Category Pills
              SelectableCategoryPills(
                categories: [
                  CategoryItem(
                    id: 'all',
                    label: 'All',
                    icon: Icons.grid_view,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const CategoryItem(
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
                  CategoryItem(
                    id: 'dance',
                    label: 'Dance',
                    icon: Icons.directions_run,
                    color: Color(0xFFEF4444),
                  ),
                ],
                selectedCategoryId: _selectedCategory,
                onCategoryTap: _onCategoryChanged,
              ),

              const SizedBox(height: 8),

              // Tab Content
              Expanded(
                child: _selectedTab == 0
                    ? MyCoursesTabContent(
                        courses: myCourses,
                        onSwitchToAllCourses: () => _onTabChanged(1),
                      )
                    : AllCoursesTabContent(
                        recommendedCourses: recommendedCourses,
                        freeCourses: freeCourses,
                        otherCourses: otherCourses,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
