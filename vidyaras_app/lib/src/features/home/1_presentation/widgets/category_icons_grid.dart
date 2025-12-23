import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Grid of circular category icons matching the mockup design
class CategoryIconsGrid extends StatelessWidget {
  const CategoryIconsGrid({
    super.key,
    required this.categories,
    this.onCategoryTap,
  });

  final List<CategoryIconItem> categories;
  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categories.map((category) {
          return CircularCategoryIcon(
            label: category.label,
            icon: category.icon,
            color: category.color,
            onTap: () => onCategoryTap?.call(category.id),
          );
        }).toList(),
      ),
    );
  }
}

class CategoryIconItem {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const CategoryIconItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}

/// Individual circular category icon with label below
class CircularCategoryIcon extends StatelessWidget {
  const CircularCategoryIcon({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular icon container
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 8),
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.darkGray,
            ),
          ),
        ],
      ),
    );
  }
}
