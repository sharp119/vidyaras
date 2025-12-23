import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../../3_domain/models/lecture.dart';

/// Lesson types for different visual states
enum LessonType { video, reading, liveSession, practice, audio }

/// Lesson status for different visual states
enum LessonStatus { completed, inProgress, upcoming, locked }

/// A card widget representing a single lesson in the curriculum
/// Follows VidyaRas Design System specifications
class CurriculumLessonCard extends StatelessWidget {
  const CurriculumLessonCard({
    super.key,
    required this.title,
    required this.type,
    required this.status,
    this.subtitle,
    this.duration,
    this.scheduledTime,
    this.onTap,
  });

  final String title;
  final LessonType type;
  final LessonStatus status;
  final String? subtitle;
  final String? duration;
  final String? scheduledTime;
  final VoidCallback? onTap;

  /// Factory constructor to create from Lecture model
  factory CurriculumLessonCard.fromLecture({
    required Lecture lecture,
    VoidCallback? onTap,
  }) {
    LessonType type;
    switch (lecture.type) {
      case 'video':
        type = LessonType.video;
        break;
      case 'reading':
        type = LessonType.reading;
        break;
      case 'live':
        type = LessonType.liveSession;
        break;
      case 'practice':
        type = LessonType.practice;
        break;
      case 'audio':
        type = LessonType.audio;
        break;
      default:
        type = LessonType.video;
    }

    LessonStatus status;
    if (lecture.isCompleted) {
      status = LessonStatus.completed;
    } else if (lecture.isLocked) {
      status = LessonStatus.locked;
    } else {
      status = LessonStatus.upcoming;
    }

    return CurriculumLessonCard(
      title: lecture.title,
      type: type,
      status: status,
      subtitle: _buildSubtitle(lecture, type),
      duration: lecture.durationMinutes != null
          ? '${lecture.durationMinutes}m'
          : null,
      onTap: onTap,
    );
  }

  static String _buildSubtitle(Lecture lecture, LessonType type) {
    final parts = <String>[];

    switch (type) {
      case LessonType.video:
        parts.add('Video');
        break;
      case LessonType.reading:
        parts.add('Reading');
        break;
      case LessonType.liveSession:
        parts.add('Live Session');
        break;
      case LessonType.practice:
        parts.add('Practice');
        break;
      case LessonType.audio:
        parts.add('Audio Practice');
        break;
    }

    if (lecture.durationMinutes != null) {
      parts.add('${lecture.durationMinutes} min');
    }

    if (lecture.isCompleted) {
      parts.add('Completed');
    }

    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    final isLocked = status == LessonStatus.locked;

    return InkWell(
      onTap: isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Opacity(
        opacity: isLocked ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(AppRadius.medium),
          ),
          child: Row(
            children: [
              // Icon Container
              _buildIconContainer(),
              const SizedBox(width: AppSpacing.mdSm),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _getTitleColor(),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 12,
                          color: _getSubtitleColor(),
                        ),
                      ),
                    ],
                    if (scheduledTime != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 12,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            scheduledTime!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.sm),

              // Duration or status indicator
              _buildTrailing(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getIconBackgroundColor(),
        shape: BoxShape.circle,
      ),
      child: Center(child: Icon(_getIcon(), size: 20, color: _getIconColor())),
    );
  }

  Color _getBackgroundColor() {
    switch (status) {
      case LessonStatus.inProgress:
        return AppColors.primary.withValues(alpha: 0.08);
      default:
        return Colors.transparent;
    }
  }

  Color _getIconBackgroundColor() {
    if (status == LessonStatus.locked) {
      return AppColors.lightGray;
    }

    switch (status) {
      case LessonStatus.completed:
        return AppColors.success.withValues(alpha: 0.1);
      case LessonStatus.inProgress:
        return AppColors.primary.withValues(alpha: 0.15);
      default:
        return AppColors.primary.withValues(alpha: 0.1);
    }
  }

  Color _getIconColor() {
    if (status == LessonStatus.locked) {
      return AppColors.helperText;
    }

    switch (status) {
      case LessonStatus.completed:
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  IconData _getIcon() {
    if (status == LessonStatus.locked) {
      return Icons.lock_outline;
    }

    if (status == LessonStatus.completed) {
      return Icons.check_circle;
    }

    switch (type) {
      case LessonType.video:
        return Icons.play_circle_outline;
      case LessonType.reading:
        return Icons.auto_stories_outlined;
      case LessonType.liveSession:
        return Icons.videocam_outlined;
      case LessonType.practice:
        return Icons.music_note_outlined;
      case LessonType.audio:
        return Icons.headphones_outlined;
    }
  }

  Color _getTitleColor() {
    if (status == LessonStatus.inProgress) {
      return AppColors.primary;
    }
    return AppColors.black;
  }

  Color _getSubtitleColor() {
    if (status == LessonStatus.inProgress) {
      return AppColors.primary.withValues(alpha: 0.8);
    }
    return AppColors.helperText;
  }

  Widget _buildTrailing() {
    if (status == LessonStatus.locked) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.lock, size: 16, color: AppColors.helperText),
      );
    }

    if (duration != null) {
      return Text(
        duration!,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: status == LessonStatus.inProgress
              ? AppColors.primary
              : AppColors.helperText,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
