import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Search bar for courses screen
/// Allows users to search courses by title or instructor
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 20,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textTertiary,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.clear,
                size: 20,
                color: AppColors.textSecondary,
              ),
              onPressed: () {
                controller.clear();
                onChanged('');
              },
            ),
          if (onFilterTap != null) ...[
            const SizedBox(width: 8),
            Container(
              height: 32,
              width: 1,
              color: AppColors.border,
            ),
            IconButton(
              icon: const Icon(
                Icons.tune,
                size: 20,
                color: AppColors.primary,
              ),
              onPressed: onFilterTap,
            ),
          ],
        ],
      ),
    );
  }
}
