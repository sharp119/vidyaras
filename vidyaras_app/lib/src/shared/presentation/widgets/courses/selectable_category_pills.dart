import 'package:flutter/material.dart';
import '../../../../features/home/1_presentation/widgets/category_pills.dart';
import '../../theme/app_spacing.dart';

/// Horizontal scrolling category pills with selection support
/// Design System: pill radius, theme-based styling
class SelectableCategoryPills extends StatelessWidget {
  const SelectableCategoryPills({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    this.onCategoryTap,
  });

  final List<CategoryItem> categories;
  final String selectedCategoryId;
  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppButtonSize.height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.mdSm),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedCategoryId;

          return SelectableCategoryPill(
            label: category.label,
            icon: category.icon,
            color: category.color,
            isSelected: isSelected,
            onTap: () => onCategoryTap?.call(category.id),
          );
        },
      ),
    );
  }
}

class SelectableCategoryPill extends StatelessWidget {
  const SelectableCategoryPill({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.mdSm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: isSelected ? Border.all(color: color, width: 2) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppIconSize.small,
              color: isSelected ? theme.colorScheme.onPrimary : color,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? theme.colorScheme.onPrimary : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
