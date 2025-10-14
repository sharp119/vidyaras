import 'package:flutter/material.dart';
import 'app_colors.dart';

/// VidyaRas App Gradient Definitions
/// Used for buttons, headers, and decorative elements
class AppGradients {
  AppGradients._();

  /// Primary gradient (Blue to Purple)
  /// Used for: Primary buttons, CTAs, interactive elements
  static const LinearGradient primary = LinearGradient(
    colors: [
      AppColors.gradientStart,
      AppColors.gradientMiddle,
      AppColors.gradientEnd,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Orange gradient
  /// Used for: Headers, accent elements, Continue button
  static const LinearGradient orange = LinearGradient(
    colors: [
      AppColors.orangeGradientStart,
      AppColors.orangeGradientEnd,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Purple gradient for feature icons
  static const LinearGradient purple = LinearGradient(
    colors: [
      Color(0xFF9C4DFF),
      Color(0xFF7B68EE),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Orange feature icon gradient
  static const LinearGradient orangeFeature = LinearGradient(
    colors: [
      Color(0xFFF97316),
      Color(0xFFFB923C),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Blue feature icon gradient
  static const LinearGradient blueFeature = LinearGradient(
    colors: [
      Color(0xFF4F87FF),
      Color(0xFF6366F1),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Referral card gradient (Purple to Pink)
  static const LinearGradient referral = LinearGradient(
    colors: [
      Color(0xFF9333EA),
      Color(0xFFC084FC),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Subtle background gradient for cards
  static const LinearGradient cardSubtle = LinearGradient(
    colors: [
      Color(0xFFFAFAFA),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Helper method to create a circular gradient container
  static BoxDecoration circularGradient(Gradient gradient) {
    return BoxDecoration(
      gradient: gradient,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  /// Helper method to create a rounded rectangle gradient container
  static BoxDecoration roundedGradient(
    Gradient gradient, {
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
