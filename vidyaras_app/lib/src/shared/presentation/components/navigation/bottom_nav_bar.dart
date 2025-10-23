import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Bottom navigation bar with icons and labels
/// Used for main app navigation (Home, Courses, Community, Tests, Profile)
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final void Function(int) onTap;
  final List<BottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              items.length,
              (index) => Expanded(
                child: _BottomNavItemWidget(
                  item: items[index],
                  isSelected: currentIndex == index,
                  onTap: () => onTap(index),
                  isSmallScreen: isSmallScreen,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}

class _BottomNavItemWidget extends StatelessWidget {
  const _BottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isSmallScreen,
  });

  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSmallScreen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 4 : 8,
          vertical: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: isSmallScreen ? 22 : 24,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
