import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/section_info.dart';
import '../../3_domain/models/lecture.dart';
import '../../3_domain/models/course_material.dart';

/// Tab view widget displaying the course curriculum (modules and lessons).
/// Used within the CourseContentScreen's TabBarView.
class CurriculumTabView extends StatelessWidget {
  const CurriculumTabView({
    super.key,
    required this.course,
    this.onLessonTap,
    this.onMaterialTap,
  });

  /// The enrolled course containing sections and lectures
  final EnrolledCourse course;

  /// Callback when a lesson is tapped
  final void Function(Lecture)? onLessonTap;

  /// Callback when a material is tapped
  final void Function(CourseMaterial)? onMaterialTap;

  @override
  Widget build(BuildContext context) {
    if (course.sections.isEmpty && course.lectures.isEmpty) {
      return _buildEmptyState();
    }

    final lecturesByModule = course.lecturesBySection;

    // Sort sections by orderIndex (ascending)
    final sortedSections = List<SectionInfo>.from(course.sections)
      ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

    // Group materials by sectionId for "Lesson as Container" approach
    final materialsBySection = <String, List<CourseMaterial>>{};
    for (final material in course.materials) {
      final sectionId = material.sectionId ?? '';
      materialsBySection.putIfAbsent(sectionId, () => []);
      materialsBySection[sectionId]!.add(material);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: sortedSections.isNotEmpty ? sortedSections.length : 1,
      itemBuilder: (context, index) {
        if (sortedSections.isNotEmpty) {
          final section = sortedSections[index];
          // Sort lectures by orderIndex within section
          final sectionLectures = List<Lecture>.from(
            lecturesByModule[section.id] ?? [],
          )..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
          final sectionMaterials = materialsBySection[section.id] ?? [];

          return _buildModuleCard(
            context,
            section: section,
            lectures: sectionLectures,
            materials: sectionMaterials,
            moduleIndex: section.orderIndex,
          );
        } else {
          // Fallback: show all lectures in a single module
          final sortedLectures = List<Lecture>.from(course.lectures)
            ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
          return _buildModuleCard(
            context,
            section: null,
            lectures: sortedLectures,
            materials: [],
            moduleIndex: 0,
          );
        }
      },
    );
  }

  Widget _buildModuleCard(
    BuildContext context, {
    SectionInfo? section,
    required List<Lecture> lectures,
    required List<CourseMaterial> materials,
    required int moduleIndex,
  }) {
    final completedCount = lectures.where((l) => l.isCompleted).length;
    final totalMinutes = lectures.fold<int>(
      0,
      (sum, l) => sum + (l.durationMinutes ?? 0),
    );
    final isModuleCompleted =
        completedCount == lectures.length && lectures.isNotEmpty;

    // Smart title formatting - avoid "Module 1: Module 1 - Title"
    String formattedTitle;
    if (section != null) {
      final title = section.title;
      // Check if title already starts with "Module X" pattern
      final moduleRegex = RegExp(
        r'^\s*Module\s*\d+\s*[-:]?\s*',
        caseSensitive: false,
      );
      if (moduleRegex.hasMatch(title)) {
        // Title already has module prefix, use as-is but clean it up
        formattedTitle = title.replaceFirst(
          moduleRegex,
          'Module ${moduleIndex + 1}: ',
        );
      } else {
        formattedTitle = 'Module ${moduleIndex + 1}: $title';
      }
    } else {
      formattedTitle = 'Course Content';
    }

    String durationText;
    if (totalMinutes >= 60) {
      final hours = totalMinutes ~/ 60;
      final mins = totalMinutes % 60;
      durationText = mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
    } else {
      durationText = '$totalMinutes mins';
    }

    return _ModuleAccordion(
      title: formattedTitle,
      subtitle: '${lectures.length} Lessons • $durationText',
      isCompleted: isModuleCompleted,
      initiallyExpanded: moduleIndex == 0,
      children: [
        // First show materials for this section (if any) - grouped at top
        if (materials.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              0,
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: materials.map((material) {
                return _MaterialChip(
                  material: material,
                  onTap: () => onMaterialTap?.call(material),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        // Then show lessons
        ...lectures.map((lecture) {
          return _LessonContainer(
            lecture: lecture,
            onTap: () => onLessonTap?.call(lecture),
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 64,
              color: AppColors.helperText,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'No Content Available',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Course content will be available soon',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Material chip for displaying lesson-attached resources
class _MaterialChip extends StatelessWidget {
  const _MaterialChip({required this.material, this.onTap});

  final CourseMaterial material;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isPdf = material.type == 'pdf';
    final color = isPdf ? Colors.red : Colors.blue;
    final icon = isPdf
        ? Icons.picture_as_pdf_rounded
        : Icons.insert_drive_file_rounded;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              material.title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Lesson container widget - expandable to show lesson details/resources
class _LessonContainer extends StatefulWidget {
  const _LessonContainer({required this.lecture, this.onTap});

  final Lecture lecture;
  final VoidCallback? onTap;

  @override
  State<_LessonContainer> createState() => _LessonContainerState();
}

class _LessonContainerState extends State<_LessonContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final lecture = widget.lecture;
    final isLocked = lecture.isLocked;
    final isCompleted = lecture.isCompleted;

    return Column(
      children: [
        InkWell(
          onTap: isLocked
              ? null
              : () {
                  setState(() => _isExpanded = !_isExpanded);
                },
          child: Opacity(
            opacity: isLocked ? 0.5 : 1.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getIconBackgroundColor(isCompleted, isLocked),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIcon(lecture.type, isCompleted, isLocked),
                      size: 20,
                      color: _getIconColor(isCompleted, isLocked),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lecture.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isLocked
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _buildSubtitle(lecture),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Duration & Expand
                  if (lecture.durationMinutes != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '${lecture.durationMinutes}m',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  if (!isLocked)
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        ),

        // Expanded content - Play button and resources
        if (_isExpanded && !isLocked)
          Container(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                const SizedBox(width: 48), // Align with content
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onTap,
                    icon: Icon(
                      lecture.type == 'live'
                          ? Icons.videocam_rounded
                          : Icons.play_arrow_rounded,
                      size: 18,
                    ),
                    label: Text(
                      lecture.type == 'live' ? 'Join Session' : 'Play Video',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Divider
        const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: AppColors.border,
        ),
      ],
    );
  }

  String _buildSubtitle(Lecture lecture) {
    final parts = <String>[];
    switch (lecture.type) {
      case 'video':
        parts.add('Video');
        break;
      case 'live':
        parts.add('Live Session');
        break;
      case 'reading':
        parts.add('Reading');
        break;
      case 'practice':
        parts.add('Practice');
        break;
      default:
        parts.add('Content');
    }
    if (lecture.isCompleted) {
      parts.add('Completed');
    }
    return parts.join(' • ');
  }

  Color _getIconBackgroundColor(bool isCompleted, bool isLocked) {
    if (isLocked) return AppColors.lightGray;
    if (isCompleted) return AppColors.success.withValues(alpha: 0.1);
    return AppColors.primary.withValues(alpha: 0.1);
  }

  Color _getIconColor(bool isCompleted, bool isLocked) {
    if (isLocked) return AppColors.helperText;
    if (isCompleted) return AppColors.success;
    return AppColors.primary;
  }

  IconData _getIcon(String type, bool isCompleted, bool isLocked) {
    if (isLocked) return Icons.lock_outline;
    if (isCompleted) return Icons.check_circle;
    switch (type) {
      case 'video':
        return Icons.play_circle_outline;
      case 'live':
        return Icons.videocam_outlined;
      case 'reading':
        return Icons.auto_stories_outlined;
      case 'practice':
        return Icons.music_note_outlined;
      default:
        return Icons.play_circle_outline;
    }
  }
}

/// Internal accordion widget for modules
class _ModuleAccordion extends StatefulWidget {
  const _ModuleAccordion({
    required this.title,
    required this.subtitle,
    required this.children,
    this.isCompleted = false,
    this.initiallyExpanded = false,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;
  final bool isCompleted;
  final bool initiallyExpanded;

  @override
  State<_ModuleAccordion> createState() => _ModuleAccordionState();
}

class _ModuleAccordionState extends State<_ModuleAccordion>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.medium),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              InkWell(
                onTap: _handleTap,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.subtitle,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.isCompleted)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        )
                      else
                        RotationTransition(
                          turns: _iconTurns,
                          child: const Icon(
                            Icons.expand_more_rounded,
                            color: AppColors.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Children
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactor.value,
                  child: Column(
                    children: [
                      if (widget.children.isNotEmpty)
                        const Divider(height: 1, color: AppColors.border),
                      ...widget.children,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
