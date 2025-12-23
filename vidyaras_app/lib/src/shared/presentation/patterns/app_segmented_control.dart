import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// App Segmented Control - Consistent tab/segment control across screens
/// Design System: Theme-based styling, proper spacing
class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    this.backgroundColor,
    this.selectedColor,
  });

  final List<SegmentItem> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? backgroundColor;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        children: List.generate(segments.length, (index) {
          final segment = segments[index];
          final isSelected = index == selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected
                      ? (selectedColor ?? AppColors.surface)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.button),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (segment.icon != null) ...[
                        Icon(
                          segment.icon,
                          size: 18,
                          color: isSelected
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Text(
                        segment.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Segment item data
class SegmentItem {
  const SegmentItem({required this.label, this.icon});

  final String label;
  final IconData? icon;
}

/// Sliver-compatible segmented control for use in CustomScrollView
class SliverAppSegmentedControl extends StatelessWidget {
  const SliverAppSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    this.backgroundColor,
    this.selectedColor,
  });

  final List<SegmentItem> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? backgroundColor;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SegmentedControlDelegate(
        segments: segments,
        selectedIndex: selectedIndex,
        onChanged: onChanged,
        backgroundColor: backgroundColor,
        selectedColor: selectedColor,
      ),
    );
  }
}

class _SegmentedControlDelegate extends SliverPersistentHeaderDelegate {
  _SegmentedControlDelegate({
    required this.segments,
    required this.selectedIndex,
    required this.onChanged,
    this.backgroundColor,
    this.selectedColor,
  });

  final List<SegmentItem> segments;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final Color? backgroundColor;
  final Color? selectedColor;

  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AppSegmentedControl(
        segments: segments,
        selectedIndex: selectedIndex,
        onChanged: onChanged,
        backgroundColor: backgroundColor,
        selectedColor: selectedColor,
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SegmentedControlDelegate oldDelegate) {
    return selectedIndex != oldDelegate.selectedIndex ||
        segments != oldDelegate.segments;
  }
}
