import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Search bar for courses screen
/// Design System: 8dp radius, theme-based styling
class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search courses...',
    this.onFilterTap,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.input),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: AppIconSize.small,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppSpacing.mdSm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: theme.textTheme.titleLarge, // 16sp
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                ),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.clear,
                size: AppIconSize.small,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              onPressed: () {
                controller.clear();
                onChanged('');
              },
            ),
          if (onFilterTap != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(height: 32, width: 1, color: AppColors.border),
            IconButton(
              icon: Icon(
                Icons.tune,
                size: AppIconSize.small,
                color: theme.colorScheme.primary,
              ),
              onPressed: onFilterTap,
            ),
          ],
        ],
      ),
    );
  }
}
