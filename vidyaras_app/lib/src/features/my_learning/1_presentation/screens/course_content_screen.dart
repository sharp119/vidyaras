import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/course_material.dart';
import '../widgets/curriculum_module_widget.dart';
import '../widgets/course_progress_card.dart';

/// Course Content Screen - Redesigned for Enrolled Users
/// Matches the specific mockup with Orange Header and Overlapping Progress Card
class CourseContentScreen extends ConsumerStatefulWidget {
  const CourseContentScreen({super.key, required this.courseId});

  final String courseId;

  @override
  ConsumerState<CourseContentScreen> createState() =>
      _CourseContentScreenState();
}

class _CourseContentScreenState extends ConsumerState<CourseContentScreen> {
  int _selectedTabIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
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
      backgroundColor: AppColors.lightGray,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 1. Variable Height Header (Includes Progress Card)
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeaderBackground(context, course),
                // 2. Tab Toggle (Overlapping)
                Positioned(
                  bottom: -28, // Half of height (56/2)
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  child: _buildTabToggle(),
                ),
              ],
            ),

            const SizedBox(
              height: 40,
            ), // Space for the overlapping toggle + extra padding
            // 3. Content List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Column(
                children: [
                  if (_selectedTabIndex == 0)
                    _buildCurriculumList(course)
                  else
                    _buildMaterialsList(course),
                  const SizedBox(height: 100), // Bottom padding
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBackground(BuildContext context, EnrolledCourse course) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFE9741D), // Mockup specific Orange
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            48,
          ), // Bottom padding for overlap space
          child: Column(
            mainAxisSize: MainAxisSize.min, // Variable height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // App Bar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => context.pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Course Content',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'पाठ्यक्रम सामग्री',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  course.isLive ? 'LIVE • लाइव' : 'COURSE • कोर्स',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title and Instructor/Image
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          course.duration ?? 'Level 1 Fundamentals',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (course.thumbnailUrl != null)
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: course.thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) =>
                              const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 24),
              // EMBEDDED PROGRESS CARD
              CourseProgressCard(
                progress: course.progress,
                completedLessons: course.completedLectures,
                totalLessons: course.totalLectures,
                remainingTime: _formatRemainingTime(course),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabToggle() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabItem(
              label: 'Curriculum',
              icon: Icons.list_alt,
              isActive: _selectedTabIndex == 0,
              onTap: () => setState(() => _selectedTabIndex = 0),
            ),
          ),
          Expanded(
            child: _buildTabItem(
              label: 'Materials',
              icon: Icons.folder_open,
              isActive: _selectedTabIndex == 1,
              onTap: () => setState(() => _selectedTabIndex = 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String label,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    // Orange active color for tabs
    final activeColor = const Color(0xFFFD7E14);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurriculumList(EnrolledCourse course) {
    if (course.sections.isEmpty && course.lectures.isEmpty) {
      return _buildEmptyState(
        icon: Icons.menu_book_outlined,
        title: 'No Content Available',
        subtitle: 'Course content will be available soon',
      );
    }

    final lecturesByModule = course.lecturesBySection;

    return Column(
      children: List.generate(
        course.sections.isNotEmpty ? course.sections.length : 1,
        (index) {
          if (course.sections.isNotEmpty) {
            final section = course.sections[index];
            final sectionLectures = lecturesByModule[section.id] ?? [];
            return Padding(
              padding: const EdgeInsets.only(bottom: 0),
              // We use CurriculumModuleWidget but need to ensure it doesn't have extra padding
              // since we are inside a padded column already.
              // Note: CurriculumModuleWidget has its own internal margin.
              child: CurriculumModuleWidget.fromSection(
                section: section,
                lectures: sectionLectures,
                moduleIndex: index,
                initiallyExpanded: index == 0, // Auto expand first module
                onLessonTap: (lecture) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Playing: ${lecture.title}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            );
          } else {
            return CurriculumModuleWidget(
              title: 'Course Content',
              lessonCount: course.lectures.length,
              totalDuration: _formatDuration(course.totalDurationMinutes),
              lessons: course.lectures,
              completedCount: course.completedLectures,
              onLessonTap: (lecture) {},
            );
          }
        },
      ),
    );
  }

  Widget _buildMaterialsList(EnrolledCourse course) {
    if (course.materials.isEmpty) {
      return _buildEmptyState(
        icon: Icons.folder_outlined,
        title: 'No Materials Available',
        subtitle: 'Course materials will be added by the instructor',
      );
    }

    // Material Title Header
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Course Materials',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFD7E14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...course.materials.map(
          (material) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildMaterialItem(material),
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialItem(CourseMaterial material) {
    final isPdf = material.type == 'pdf' || material.fileUrl.endsWith('.pdf');
    final typeColor = isPdf ? Colors.red : Colors.blue;
    final icon = isPdf ? Icons.picture_as_pdf : Icons.music_note;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: typeColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  material.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  material.formattedSize,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.helperText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.download_rounded,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Icon(icon, size: 64, color: AppColors.helperText),
            const SizedBox(height: AppSpacing.md),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  Widget _buildErrorScreen(Object error) {
    return Scaffold(body: Center(child: Text('Error: $error')));
  }

  String _formatRemainingTime(EnrolledCourse course) {
    final remainingHours = course.estimatedRemainingHours;
    if (remainingHours >= 1) {
      return '${remainingHours}h ${(remainingHours % 1 * 60).round()}m';
    } else {
      return '${(remainingHours * 60).round()}m';
    }
  }

  String _formatDuration(int totalMinutes) {
    if (totalMinutes >= 60) {
      final hours = totalMinutes ~/ 60;
      final mins = totalMinutes % 60;
      return mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
    } else {
      return '$totalMinutes mins';
    }
  }
}
