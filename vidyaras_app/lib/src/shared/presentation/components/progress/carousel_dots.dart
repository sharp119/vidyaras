import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Carousel page indicator dots
/// Used for intro/onboarding screens
class CarouselDots extends StatelessWidget {
  const CarouselDots({
    super.key,
    required this.totalDots,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8,
    this.spacing = 8,
  });

  final int totalDots;
  final int currentIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalDots,
        (index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: _Dot(
            isActive: index == currentIndex,
            size: dotSize,
            activeColor: activeColor ?? AppColors.progressFill,
            inactiveColor: inactiveColor ?? AppColors.progressBackground,
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.isActive,
    required this.size,
    required this.activeColor,
    required this.inactiveColor,
  });

  final bool isActive;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActive ? size * 2 : size,
      height: size,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
    );
  }
}
