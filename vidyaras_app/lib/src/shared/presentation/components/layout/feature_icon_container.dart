import 'package:flutter/material.dart';
import '../../theme/app_gradients.dart';

/// Large circular gradient icon container
/// Used for feature showcases in intro/onboarding screens
class FeatureIconContainer extends StatelessWidget {
  const FeatureIconContainer({
    super.key,
    required this.icon,
    this.gradient,
    this.size = 120,
    this.iconSize,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final Gradient? gradient;
  final double size;
  final double? iconSize;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: AppGradients.circularGradient(
        gradient ?? AppGradients.primary,
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize ?? size * 0.5,
          color: iconColor,
        ),
      ),
    );
  }
}

/// Square rounded gradient icon container
/// Alternative style for feature icons
class FeatureIconSquare extends StatelessWidget {
  const FeatureIconSquare({
    super.key,
    required this.icon,
    this.gradient,
    this.size = 80,
    this.iconSize,
    this.iconColor = Colors.white,
    this.borderRadius = 20,
  });

  final IconData icon;
  final Gradient? gradient;
  final double size;
  final double? iconSize;
  final Color iconColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: AppGradients.roundedGradient(
        gradient ?? AppGradients.primary,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Icon(
          icon,
          size: iconSize ?? size * 0.5,
          color: iconColor,
        ),
      ),
    );
  }
}
