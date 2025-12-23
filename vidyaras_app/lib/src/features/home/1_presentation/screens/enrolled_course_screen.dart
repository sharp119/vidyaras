import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../3_domain/models/course_detail.dart';
import '../../3_domain/models/section_info.dart';
import '../../3_domain/models/lesson_item.dart';

class EnrolledCourseScreen extends ConsumerStatefulWidget {
  const EnrolledCourseScreen({super.key, required this.courseDetail});

  final CourseDetail courseDetail;

  @override
  ConsumerState<EnrolledCourseScreen> createState() =>
      _EnrolledCourseScreenState();
}

class _EnrolledCourseScreenState extends ConsumerState<EnrolledCourseScreen> {
  bool _showCurriculum = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Screen structure:
    // Stack
    //  - Background/Header (Orange part)
    //  - Foreground Content (Scrollable)
    //    - Invisible Header Spacer
    //    - Progress Card (overlaps header)
    //    - Tabs
    //    - List content

    final headerHeight = 280.0;
    final cardOverlap = 40.0;

    return Scaffold(
      backgroundColor:
          AppColors.background, // Ensure this maps to a light gray/white
      body: Stack(
        children: [
          // 1. Orange Header Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(
                  0xFFE9741D,
                ), // Match the specific orange from mockup
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // App Bar Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
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
                                'पाठ्यक्रम सामग्री', // Static Hindi text for now, or translate
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Tags
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'DANCE • नृत्य',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      // Check for instructor image if needed, for now just text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.courseDetail.basicInfo.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Level 1 Fundamentals • स्तर १ आधारभूत',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Optional Instructor/Course Image circle
                          if (widget.courseDetail.basicInfo.thumbnailUrl !=
                              null)
                            Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: ClipOval(
                                child: Image.network(
                                  widget.courseDetail.basicInfo.thumbnailUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(top: headerHeight - 60), // Start overlap
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Progress Card
                    _buildProgressCard(),
                    const SizedBox(height: 24),

                    // Toggle Switch
                    _buildContentToggle(),
                    const SizedBox(height: 24),

                    // Content List
                    if (_showCurriculum)
                      _buildCurriculumList()
                    else
                      _buildMaterialsList(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(
          0xFFC26920,
        ).withOpacity(0.9), // Darker orange/brown overly
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.black.withOpacity(0.05),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      // Using a simpler solid color approach based on image matching which looks like glassmorphism over orange
      // Actually the mockup has a solid card that looks like a slightly darker shade or overlay.
      // Let's stick closer to the mockup colors.
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Course Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '35%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.35,
              backgroundColor: Colors.black.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '12/${widget.courseDetail.curriculum.expand((s) => s.lessons).length} Lessons',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Text(
                '2h 15m remaining',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentToggle() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showCurriculum = true),
              child: Container(
                decoration: BoxDecoration(
                  color: _showCurriculum
                      ? const Color(0xFFFD7E14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: _showCurriculum
                          ? Colors.white
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Curriculum',
                      style: TextStyle(
                        color: _showCurriculum
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showCurriculum = false),
              child: Container(
                decoration: BoxDecoration(
                  color: !_showCurriculum
                      ? const Color(0xFFFD7E14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(28),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      color: !_showCurriculum
                          ? Colors.white
                          : AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Materials',
                      style: TextStyle(
                        color: !_showCurriculum
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculumList() {
    return Column(
      children: widget.courseDetail.curriculum.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;
        // Fix Module Title duplication (e.g., "Module 1: Module 1 Introduction")
        // Just assuming logic to clean string or use index
        final title = section.title.startsWith("Module")
            ? section.title
            : "Module ${index + 1}: ${section.title}";

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // Placeholder Hindi/Subtitle
                          '${section.lessons.length} Lessons • ${section.totalDurationMinutes ?? 45} mins',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Optional Check circle if module complete (mockup has it)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF00C853),
                    size: 24,
                  ),
                ],
              ),
            ),

            ...section.lessons
                .map((lesson) => _buildLessonItem(lesson))
                .toList(),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildLessonItem(LessonItem lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Box
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: lesson.isCompleted
                  ? const Color(0xFFE8F5E9) // Green tint
                  : const Color(0xFFE3F2FD), // Blue tint
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.play_arrow_rounded, // or description for reading
                  color: lesson.isCompleted
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFF1565C0),
                  size: 28,
                ),
                if (lesson.isCompleted)
                  const Positioned(
                    bottom: -2,
                    right: -2,
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFF00C853),
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Video • ${lesson.durationMinutes} mins • ${lesson.isCompleted ? "Completed" : "Pending"}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Locked or Duration
          if (lesson.isLocked)
            const Icon(
              Icons.lock_outline,
              color: AppColors.textSecondary,
              size: 20,
            )
          else
            Text(
              '${lesson.durationMinutes}m',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMaterialsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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

        // Mock Materials
        _buildMaterialItem(
          'Mudras Handbook.pdf',
          '2.4 MB • हस्त मुद्राएँ',
          Icons.picture_as_pdf,
          Colors.red,
        ),
        _buildMaterialItem(
          'Riyaaz Track - Lehra.mp3',
          '14.2 MB • रियाज़ ट्रैक',
          Icons.music_note,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildMaterialItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.download_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
