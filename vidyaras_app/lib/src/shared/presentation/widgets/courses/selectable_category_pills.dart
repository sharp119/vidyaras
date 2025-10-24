import 'package:flutter/material.dart';
import '../../../../features/home/1_presentation/widgets/category_pills.dart';
import '../../theme/app_colors.dart';

/// Horizontal scrolling category pills with selection support
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
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? color
              : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(24),
          border: isSelected
              ? Border.all(color: color, width: 2)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.textOnPrimary : color,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? AppColors.textOnPrimary : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
