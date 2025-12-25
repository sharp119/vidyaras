import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../../../shared/presentation/components/headers/universal_media_header.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/lecture.dart';
import '../../3_domain/models/lesson_content.dart';
import '../widgets/curriculum_tab_view.dart';
import '../widgets/resources_tab_view.dart';
import '../widgets/lesson_control_bar.dart';

/// Course Content Screen - Fixed Player & Navigation Layout
/// Video player remains fixed at top, curriculum scrolls independently
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

  // Lesson navigation state
  List<Lecture> _flatLessons = [];
  int _currentLessonIndex = 0;
  Lecture? _currentLecture;

  // Auto-advance state
  Timer? _autoAdvanceTimer;
  int _autoAdvanceCountdown = 0;
  bool _showAutoAdvanceOverlay = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  void _onVideoEnded() {
    // Mark current lesson as complete
    if (_currentLecture != null) {
      _markLessonComplete(_currentLecture!);
    }

    // Don't auto-advance if we're on the last lesson (or can't find next playable)
    // Check if there IS a next playable lesson
    bool hasNextPlayable = false;
    for (int i = _currentLessonIndex + 1; i < _flatLessons.length; i++) {
      final lesson = _flatLessons[i];
      final hasContent =
          lesson.contents.any((c) => c.type == 'video') ||
          (lesson.videoUrl != null && lesson.videoUrl!.isNotEmpty);
      if (hasContent) {
        hasNextPlayable = true;
        break;
      }
    }

    if (!hasNextPlayable) return;

    // Start auto-advance countdown
    setState(() {
      _showAutoAdvanceOverlay = true;
      _autoAdvanceCountdown = 5;
    });

    _autoAdvanceTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_autoAdvanceCountdown > 1) {
        setState(() {
          _autoAdvanceCountdown--;
        });
      } else {
        _cancelAutoAdvance();
        _goToNextLesson();
      }
    });
  }

  void _cancelAutoAdvance() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
    setState(() {
      _showAutoAdvanceOverlay = false;
      _autoAdvanceCountdown = 0;
    });
  }

  /// Build flat list of lessons for navigation (sorted by section then order)
  void _buildFlatLessonList(EnrolledCourse course) {
    final lecturesBySection = course.lecturesBySection;

    // Sort sections by orderIndex
    final sortedSections = List.from(course.sections)
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

    final lessons = <Lecture>[];
    for (final section in sortedSections) {
      final sectionLectures = List<Lecture>.from(
        lecturesBySection[section.id] ?? [],
      )..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
      lessons.addAll(sectionLectures);
    }

    // Fallback if no sections
    if (lessons.isEmpty && course.lectures.isNotEmpty) {
      lessons.addAll(
        List<Lecture>.from(course.lectures)
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex)),
      );
    }

    _flatLessons = lessons;

    // Find first incomplete lesson or start at beginning
    if (_currentLecture == null && lessons.isNotEmpty) {
      final nextIndex = lessons.indexWhere(
        (l) => !l.isCompleted && !l.isLocked,
      );
      _currentLessonIndex = nextIndex >= 0 ? nextIndex : 0;
      _currentLecture = lessons[_currentLessonIndex];
      _initializeVideoForLesson(_currentLecture!);
    }
  }

  void _initializeVideoForLesson(Lecture lecture) {
    // First check lesson contents for video
    final videoContent = lecture.contents.firstWhere(
      (c) => c.type == 'video' && c.url != null && c.url!.isNotEmpty,
      orElse: () => LessonContent(
        id: '',
        lessonId: lecture.id,
        title: '',
        type: '',
        orderIndex: 0,
      ),
    );

    if (videoContent.url != null && videoContent.url!.isNotEmpty) {
      setState(() {
        _currentVideoUrl = videoContent.url;
        _isPlaying = true;
      });
    } else if (lecture.videoUrl != null && lecture.videoUrl!.isNotEmpty) {
      // Fallback to legacy videoUrl
      setState(() {
        _currentVideoUrl = lecture.videoUrl;
        _isPlaying = true;
      });
    } else {
      setState(() {
        _currentVideoUrl = null;
        _isPlaying = false;
      });
    }
  }

  void _goToLesson(int index) {
    if (index < 0 || index >= _flatLessons.length) return;

    final lesson = _flatLessons[index];
    if (lesson.isLocked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This lesson is locked'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    setState(() {
      _currentLessonIndex = index;
      _currentLecture = lesson;
    });
    _initializeVideoForLesson(lesson);
  }

  void _goToPreviousLesson() {
    // Find previous non-empty lesson
    int prevIndex = _currentLessonIndex - 1;
    while (prevIndex >= 0) {
      final lesson = _flatLessons[prevIndex];
      final hasContent =
          lesson.contents.any((c) => c.type == 'video') ||
          (lesson.videoUrl != null && lesson.videoUrl!.isNotEmpty);

      if (hasContent) {
        _goToLesson(prevIndex);
        return;
      }
      prevIndex--;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No previous lessons available')),
    );
  }

  void _goToNextLesson() {
    // Find next non-empty lesson
    int nextIndex = _currentLessonIndex + 1;
    while (nextIndex < _flatLessons.length) {
      final lesson = _flatLessons[nextIndex];
      // Check if lesson has video content or legacy video url
      final hasContent =
          lesson.contents.any((c) => c.type == 'video') ||
          (lesson.videoUrl != null && lesson.videoUrl!.isNotEmpty);

      if (hasContent) {
        _goToLesson(nextIndex);
        return;
      }
      nextIndex++;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No more lessons available yet')),
    );
  }

  Future<void> _markLessonComplete(Lecture lecture) async {
    if (lecture.isCompleted) return;

    try {
      final repository = ref.read(myLearningRepositoryProvider);
      final user = await ref.read(currentUserProvider.future);

      if (user != null) {
        await repository.markLectureComplete(
          userId: user.id,
          lectureId: lecture.id,
          watchedSeconds: 0, // Or actual duration if tracked
        );

        // Refresh course details to update UI
        ref.invalidate(courseDetailsProvider(courseId: widget.courseId));

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Lesson marked as complete! 🎉'),
              duration: Duration(seconds: 1),
              backgroundColor: AppColors.success,
            ),
          );
        }
      }
    } catch (e) {
      // Handle error silently or show snackbar
      debugPrint('Error marking lesson complete: $e');
    }
  }

  void _onLessonSelected(Lecture lecture, LessonContent? content) {
    final index = _flatLessons.indexWhere((l) => l.id == lecture.id);
    if (index >= 0) {
      setState(() {
        _currentLessonIndex = index;
        _currentLecture = lecture;
      });

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
              content: Text('Opening ${content.type}: ${content.title}'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
      // Legacy fallback
      else if (lecture.videoUrl != null && lecture.videoUrl!.isNotEmpty) {
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final courseDetailsAsync = ref.watch(
      courseDetailsProvider(courseId: widget.courseId),
    );

    return courseDetailsAsync.when(
      data: (course) {
        // Build flat lesson list on first load
        if (_flatLessons.isEmpty) {
          _buildFlatLessonList(course);
        }
        return _buildScreen(context, course);
      },
      loading: () => _buildLoadingScreen(),
      error: (error, stack) => _buildErrorScreen(error),
    );
  }

  Widget _buildScreen(BuildContext context, EnrolledCourse course) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: OrientationBuilder(
        builder: (context, orientation) {
          // Landscape: Full screen video
          if (orientation == Orientation.landscape) {
            return Stack(
              fit: StackFit.expand,
              children: [
                UniversalMediaHeader(
                  thumbnailUrl: course.thumbnailUrl,
                  isLive: course.isLive,
                  nextLiveDate: course.nextLiveClass?.scheduledAt,
                  videoUrl: _currentVideoUrl,
                  isPlaying: _isPlaying,
                  onPlayPressed: () {
                    if (_currentLecture != null) {
                      _initializeVideoForLesson(_currentLecture!);
                    } else if (_flatLessons.isNotEmpty) {
                      _goToLesson(0);
                    }
                  },
                  onVideoEnded: _onVideoEnded,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: SafeArea(
                    child: _buildOverlayButton(
                      icon: Icons.arrow_back,
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
              ],
            );
          }

          // Portrait: Standard UI
          return SafeArea(
            child: Column(
              children: [
                // 1. Fixed Media Header (16:9)
                _buildMediaHeader(course),

                // ... rest of the UI
                Expanded(
                  child: Column(
                    children: [
                      // 2. Lesson Control Bar
                      if (_currentLecture != null)
                        LessonControlBar(
                          currentLecture: _currentLecture!,
                          currentIndex: _currentLessonIndex,
                          totalLessons: _flatLessons.length,
                          onPrevious: _currentLessonIndex > 0
                              ? _goToPreviousLesson
                              : null,
                          onNext: _currentLessonIndex < _flatLessons.length - 1
                              ? _goToNextLesson
                              : null,
                          onToggleComplete: () =>
                              _markLessonComplete(_currentLecture!),
                        ),

                      // 3. Course Info
                      _buildMiniCourseInfo(course),

                      // 4. Tab Bar
                      _buildTabBar(),

                      // 5. Tab Content
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            CurriculumTabView(
                              course: course,
                              activeLectureId: _currentLecture?.id,
                              onLessonTap: _onLessonSelected,
                              // ...
                              onMaterialTap: (_) {},
                            ),
                            ResourcesTabView(
                              materials: course.materials,
                              onMaterialTap: (_) {},
                              onDownloadTap: (_) {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMediaHeader(EnrolledCourse course) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: UniversalMediaHeader(
            thumbnailUrl: course.thumbnailUrl,
            isLive: course.isLive,
            nextLiveDate: course.nextLiveClass?.scheduledAt,
            videoUrl: _currentVideoUrl,
            isPlaying: _isPlaying,
            onPlayPressed: () {
              if (_currentLecture != null) {
                _initializeVideoForLesson(_currentLecture!);
              } else if (_flatLessons.isNotEmpty) {
                _goToLesson(0);
              }
            },
            onJoinPressed: () {
              final liveClass = course.nextLiveClass;
              if (liveClass != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Joining: ${liveClass.title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
            onVideoEnded: _onVideoEnded,
          ),
        ),

        // Auto-advance countdown overlay
        if (_showAutoAdvanceOverlay)
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.7),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Next lesson in $_autoAdvanceCountdown...',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (_currentLessonIndex < _flatLessons.length - 1)
                      Text(
                        _flatLessons[_currentLessonIndex + 1].title,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: _cancelAutoAdvance,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        // Back button overlay
        Positioned(
          top: 8,
          left: 8,
          child: _buildOverlayButton(
            icon: Icons.arrow_back,
            onPressed: () => context.pop(),
          ),
        ),

        // More options button overlay
        Positioned(
          top: 8,
          right: 8,
          child: _buildOverlayButton(
            icon: Icons.more_vert,
            onPressed: () {
              // Show options menu
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOverlayButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildMiniCourseInfo(EnrolledCourse course) {
    final progressPercent = (course.progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  'by ${course.instructor}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: progressPercent > 0
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.lightGray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$progressPercent%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: progressPercent > 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.surface,
      child: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        tabs: const [
          Tab(text: 'Curriculum'),
          Tab(text: 'Resources'),
        ],
      ),
    );
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
                'Failed to load course',
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
