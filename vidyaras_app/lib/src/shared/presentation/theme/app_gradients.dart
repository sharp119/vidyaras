import 'package:flutter/material.dart';
import 'app_colors.dart';

/// VidyaRas App Gradient Definitions
/// Used for buttons, headers, and decorative elements
class AppGradients {
  AppGradients._();

  /// Primary gradient (Orange) - Used for headers, primary CTAs
  /// Design System: #FF5722 → #FF8A65
  static const LinearGradient primary = LinearGradient(
    colors: [AppColors.primary, AppColors.primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Orange gradient (alias for primary)
  /// Used for: Headers, accent elements, Continue button
  static const LinearGradient orange = LinearGradient(
    colors: [AppColors.orangeGradientStart, AppColors.orangeGradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Category-specific gradients
  static const LinearGradient music = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient wellness = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient yoga = LinearGradient(
    colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient arts = LinearGradient(
    colors: [Color(0xFFE91E63), Color(0xFFF06292)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Legacy gradients (kept for compatibility)
  static const LinearGradient purple = LinearGradient(
    colors: [Color(0xFF9C4DFF), Color(0xFF7B68EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient orangeFeature = LinearGradient(
    colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueFeature = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Referral card gradient (Orange tints)
  static const LinearGradient referral = LinearGradient(
    colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Subtle background gradient for cards
  static const LinearGradient cardSubtle = LinearGradient(
    colors: [Color(0xFFFAFAFA), Color(0xFFFFFFFF)],
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
    double borderRadius = 12,
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
