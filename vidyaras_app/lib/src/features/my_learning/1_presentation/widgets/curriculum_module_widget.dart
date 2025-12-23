import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../3_domain/models/section_info.dart';
import '../../3_domain/models/lecture.dart';
import 'curriculum_lesson_card.dart';

/// A widget displaying a module section in the curriculum
/// Shows module header with progress and expandable lesson list
/// wrapped in a white card for visual separation
class CurriculumModuleWidget extends StatefulWidget {
  const CurriculumModuleWidget({
    super.key,
    required this.title,
    required this.lessonCount,
    required this.totalDuration,
    required this.lessons,
    this.subtitle,
    this.completedCount = 0,
    this.isCompleted = false,
    this.hasResume = false,
    this.initiallyExpanded = true,
    this.onLessonTap,
  });

  final String title;
  final String? subtitle;
  final int lessonCount;
  final String totalDuration;
  final List<Lecture> lessons;
  final int completedCount;
  final bool isCompleted;
  final bool hasResume;
  final bool initiallyExpanded;
  final void Function(Lecture)? onLessonTap;

  /// Factory constructor from SectionInfo model
  factory CurriculumModuleWidget.fromSection({
    required SectionInfo section,
    required List<Lecture> lectures,
    required int moduleIndex,
    bool initiallyExpanded = true,
    void Function(Lecture)? onLessonTap,
  }) {
    final completedCount = lectures.where((l) => l.isCompleted).length;
    final totalMinutes = lectures.fold<int>(
      0,
      (sum, l) => sum + (l.durationMinutes ?? 0),
    );

    String duration;
    if (totalMinutes >= 60) {
      final hours = totalMinutes ~/ 60;
      final mins = totalMinutes % 60;
      duration = mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
    } else {
      duration = '$totalMinutes mins';
    }

    // Check if any lesson is in progress
    final hasResume = lectures.any(
      (l) =>
          !l.isCompleted &&
          !l.isLocked &&
          lectures.indexOf(l) > 0 &&
          lectures.take(lectures.indexOf(l)).any((prev) => prev.isCompleted),
    );

    // Smart Title Formatting
    // If section title already contains "Module X", don't prepend it
    String formattedTitle;
    // Regex matches "Module 1", "Module 01", "Module 1:", etc.
    final moduleRegex = RegExp(r'^\s*Module\s*\d+', caseSensitive: false);
    if (moduleRegex.hasMatch(section.title)) {
      formattedTitle = section.title;
    } else {
      formattedTitle = 'Module ${moduleIndex + 1}: ${section.title}';
    }

    return CurriculumModuleWidget(
      title: formattedTitle,
      subtitle: section.hindiTitle,
      lessonCount: lectures.length,
      totalDuration: duration,
      lessons: lectures,
      completedCount: completedCount,
      isCompleted: completedCount == lectures.length && lectures.isNotEmpty,
      hasResume: hasResume,
      initiallyExpanded: initiallyExpanded,
      onLessonTap: onLessonTap,
    );
  }

  @override
  State<CurriculumModuleWidget> createState() => _CurriculumModuleWidgetState();
}

class _CurriculumModuleWidgetState extends State<CurriculumModuleWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Module Header
          _buildHeader(),

          // Lessons List (when expanded)
          if (_isExpanded)
            ...widget.lessons.asMap().entries.map((entry) {
              final index = entry.key;
              final lecture = entry.value;

              return Column(
                children: [
                  if (index > 0)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      child: Divider(height: 1, color: AppColors.lightGray),
                    ),
                  CurriculumLessonCard.fromLecture(
                    lecture: lecture,
                    onTap: widget.onLessonTap != null
                        ? () => widget.onLessonTap!(lecture)
                        : null,
                  ),
                ],
              );
            }),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppRadius.medium),
        bottom: Radius.circular(AppRadius.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Subtitle and metadata
                  Row(
                    children: [
                      if (widget.subtitle != null) ...[
                        Text(
                          widget.subtitle!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.helperText,
                          ),
                        ),
                        const Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.helperText,
                          ),
                        ),
                      ],
                      Text(
                        '${widget.lessonCount} Lessons',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.helperText,
                        ),
                      ),
                      const Text(
                        ' • ',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.helperText,
                        ),
                      ),
                      Text(
                        widget.totalDuration,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.helperText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: AppSpacing.sm),

            // Right Content - Status or Resume
            if (widget.hasResume)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              )
            else if (widget.isCompleted)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              )
            else
              Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: AppColors.helperText,
              ),
          ],
        ),
      ),
    );
  }
}
