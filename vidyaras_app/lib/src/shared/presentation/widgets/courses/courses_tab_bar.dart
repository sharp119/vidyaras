import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';

/// Tab bar for courses screen
/// Switches between My Courses and All Courses tabs
class CoursesTabBar extends StatelessWidget {
  const CoursesTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              text: 'My Courses',
              isSelected: selectedIndex == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _TabButton(
              text: 'All Courses',
              isSelected: selectedIndex == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.primary : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
