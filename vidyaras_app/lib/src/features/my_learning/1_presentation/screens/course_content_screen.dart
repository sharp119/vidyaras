import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../../../shared/presentation/components/headers/universal_media_header.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../widgets/curriculum_tab_view.dart';
import '../widgets/resources_tab_view.dart';

/// Course Content Screen - Video-First Architecture
/// Uses NestedScrollView for sticky tabs with scrollable content
class CourseContentScreen extends ConsumerStatefulWidget {
  const CourseContentScreen({super.key, required this.courseId});

  final String courseId;

  @override
  ConsumerState<CourseContentScreen> createState() =>
      _CourseContentScreenState();
}

class _CourseContentScreenState extends ConsumerState<CourseContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // State to track currently playing video
  String? _currentVideoUrl;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailsAsync = ref.watch(
      courseDetailsProvider(courseId: widget.courseId),
    );

    return courseDetailsAsync.when(
      data: (course) => _buildScreen(context, course),
      loading: () => _buildLoadingScreen(),
      error: (error, stack) => _buildErrorScreen(error),
    );
  }

  Widget _buildScreen(BuildContext context, EnrolledCourse course) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // 1. Collapsible Media Header
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              backgroundColor: AppColors.primary,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                onPressed: () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: UniversalMediaHeader(
                  thumbnailUrl: course.thumbnailUrl,
                  isLive: course.isLive,
                  nextLiveDate: course.nextLiveClass?.scheduledAt,
                  // Pass the current video URL to the header
                  videoUrl: _currentVideoUrl,
                  isPlaying: _isPlaying,
                  onPlayPressed: () {
                    // Start playing the first available lecture if none is selected
                    _onPlayPressed(course);
                  },
                  onJoinPressed: () {
                    // Join live class
                    _onJoinPressed(course);
                  },
                ),
              ),
              title: AnimatedOpacity(
                opacity: innerBoxIsScrolled ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  course.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // 2. Course Info Section
            SliverToBoxAdapter(child: _buildCourseInfoSection(course)),

            // 3. Sticky Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabBarDelegate(
                tabBar: TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  tabs: const [
                    Tab(text: 'Curriculum'),
                    Tab(text: 'Resources'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Curriculum
            CurriculumTabView(
              course: course,
              onLessonTap: (lecture, content) {
                // Handle specific content tap
                if (content != null) {
                  if (content.type == 'video' &&
                      content.url != null &&
                      content.url!.isNotEmpty) {
                    setState(() {
                      _currentVideoUrl = content.url;
                      _isPlaying = true;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Opening ${content.type}: ${content.title}',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                }
                // Legacy fallback
                else if (lecture.videoUrl != null &&
                    lecture.videoUrl!.isNotEmpty) {
                  setState(() {
                    _currentVideoUrl = lecture.videoUrl;
                    _isPlaying = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No video available for this lesson'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              onMaterialTap: (material) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening: ${material.title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),

            // Tab 2: Resources
            ResourcesTabView(
              materials: course.materials,
              onMaterialTap: (material) {
                // Open material
              },
              onDownloadTap: (material) {
                // Download material
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInfoSection(EnrolledCourse course) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Title
          Text(
            course.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Instructor & Live Badge
          Row(
            children: [
              Text(
                'by ${course.instructor}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              if (course.isLive) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Progress Bar
          _buildProgressBar(course),
        ],
      ),
    );
  }

  Widget _buildProgressBar(EnrolledCourse course) {
    final progressPercent = (course.progress * 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$progressPercent% Complete',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: progressPercent > 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
            Text(
              '${course.completedLectures}/${course.totalLectures} lessons',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: course.progress,
            backgroundColor: AppColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 6,
          ),
        ),
        const SizedBox(height: 12),

        // Resume Button (if progress > 0)
        if (course.progress > 0 && course.nextLecture != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _onPlayPressed(course),
              icon: const Icon(Icons.play_arrow_rounded, size: 20),
              label: const Text('Continue Learning'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _onPlayPressed(EnrolledCourse course) {
    // If we're already playing, do nothing or toggle pause (opt.)
    if (_isPlaying) return;

    final nextLecture = course.nextLecture;
    if (nextLecture != null && nextLecture.videoUrl != null) {
      setState(() {
        _currentVideoUrl = nextLecture.videoUrl;
        _isPlaying = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Resuming: ${nextLecture.title}'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      // Fallback for demo if no next lecture found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No next lecture available'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _onJoinPressed(EnrolledCourse course) {
    final liveClass = course.nextLiveClass;
    if (liveClass != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Joining: ${liveClass.title}'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorScreen(Object error) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: AppColors.error,
              ),
              const SizedBox(height: 16),
              const Text(
                'Failed toload course',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: const TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Delegate for sticky tab bar in NestedScrollView
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  _StickyTabBarDelegate({required this.tabBar});

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: AppColors.surface, child: tabBar);
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
