import 'package:flutter/material.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/course_progress_detail.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

class LectureListItem extends StatelessWidget {
  const LectureListItem({
    super.key,
    required this.lecture,
    this.onOpenRecording,
    this.onOpenMaterials,
    this.onOpenTests,
  });

  final CourseLecture lecture;
  final VoidCallback? onOpenRecording;
  final VoidCallback? onOpenMaterials;
  final VoidCallback? onOpenTests;

  @override
  Widget build(BuildContext context) {
    final status = lecture.accessStatus;
    final isLocked = status == LectureAccessStatus.locked;
    final isCompleted = status == LectureAccessStatus.completed;
    final accentColor = isCompleted
        ? AppColors.success
        : isLocked
            ? AppColors.warning
            : AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLocked
            ? const Color(0xFFFFF8F0)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isLocked ? const Color(0xFFFFD8B2) : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _StatusIcon(status: status, color: accentColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecture.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isLocked ? FontWeight.w600 : FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (lecture.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        lecture.description!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    if (lecture.durationMinutes != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        '${lecture.durationMinutes} minutes',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (onOpenRecording != null &&
                            status != LectureAccessStatus.locked)
                          _ActionChip(
                            icon: Icons.play_circle_outline,
                            label: 'Recorded',
                            onTap: onOpenRecording!,
                          ),
                        if (onOpenMaterials != null)
                          _ActionChip(
                            icon: Icons.folder_open,
                            label:
                                'Materials (${lecture.materials.length})',
                            onTap: onOpenMaterials!,
                          ),
                        if (lecture.liveClass != null)
                          _ActionChip(
                            icon: Icons.wifi_tethering,
                            label: 'Live Linked',
                            onTap: () {},
                            disabled: true,
                          ),
                        if (isLocked && lecture.requiredQuiz != null)
                          _ActionChip(
                            icon: Icons.quiz_outlined,
                            label: 'Go to Quiz',
                            onTap: onOpenTests ?? () {},
                            disabled: onOpenTests == null,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isLocked && lecture.requiredQuiz != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2E0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lock_outline,
                      size: 18, color: Color(0xFFEF6C00)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Complete '${lecture.requiredQuiz!.title}' in the Tests tab to continue.",
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({
    required this.status,
    required this.color,
  });

  final LectureAccessStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (status) {
      case LectureAccessStatus.completed:
        icon = Icons.check_circle;
        break;
      case LectureAccessStatus.locked:
        icon = Icons.lock;
        break;
      case LectureAccessStatus.inProgress:
        icon = Icons.timelapse;
        break;
      case LectureAccessStatus.available:
      default:
        icon = Icons.play_circle_outline;
        break;
    }

    return CircleAvatar(
      radius: 18,
      backgroundColor: color.withOpacity(0.14),
      foregroundColor: color,
      child: Icon(icon, size: 20),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.disabled = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final background = disabled
        ? AppColors.surfaceLight
        : AppColors.primary.withOpacity(0.12);
    final foreground = disabled ? AppColors.textSecondary : AppColors.primary;
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: foreground),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
