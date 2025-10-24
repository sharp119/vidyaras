import 'package:flutter/material.dart';
import '../../3_domain/models/section_info.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Widget to display a curriculum section with its lessons
class CurriculumSectionCard extends StatelessWidget {
  const CurriculumSectionCard({
    super.key,
    required this.section,
    this.sectionNumber,
  });

  final SectionInfo section;
  final int? sectionNumber;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            section.title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        // Lessons List
        ...section.lessons.asMap().entries.map((entry) {
          final index = entry.key;
          final lesson = entry.value;
          final lessonNumber = index + 1 + ((sectionNumber ?? 0) * 10);
          final isLast = index == section.lessons.length - 1;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // Lesson Number or Lock Icon
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: lesson.isLocked
                            ? AppColors.textSecondary.withOpacity(0.1)
                            : AppColors.textPrimary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: lesson.isLocked
                            ? Icon(
                                Icons.lock_outline,
                                size: 12,
                                color: AppColors.textSecondary,
                              )
                            : lesson.isCompleted
                                ? Icon(
                                    Icons.check,
                                    size: 12,
                                    color: AppColors.success,
                                  )
                                : Text(
                                    '$lessonNumber',
                                    style: textTheme.labelSmall?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontSize: 10,
                                    ),
                                  ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Lesson Title and Duration
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson.title,
                            style: textTheme.bodyMedium?.copyWith(
                              color: lesson.isLocked
                                  ? AppColors.textSecondary
                                  : AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (lesson.description != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              lesson.description!,
                              style: textTheme.labelSmall?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Duration
                    Text(
                      '${lesson.durationMinutes} min',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast) const SizedBox(height: 12),
            ],
          );
        }),
      ],
    );
  }
}
