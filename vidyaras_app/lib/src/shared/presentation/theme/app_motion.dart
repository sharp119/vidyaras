import 'package:flutter/material.dart';

/// VidyaRas App Motion & Animation System
/// Based on design system specifications for smooth, consistent animations
class AppMotion {
  AppMotion._();

  // ═══════════════════════════════════════════
  // TRANSITION DURATIONS
  // ═══════════════════════════════════════════
  /// Fast - Micro-interactions, highlights
  static const Duration fast = Duration(milliseconds: 150);

  /// Standard - Screen transitions, component changes
  static const Duration standard = Duration(milliseconds: 300);

  /// Slow - Complex transitions, intros
  static const Duration slow = Duration(milliseconds: 500);

  // ═══════════════════════════════════════════
  // EASING CURVES
  // ═══════════════════════════════════════════
  /// Default curve - Smooth start and end
  static const Curve defaultCurve = Curves.easeInOut;

  /// Feedback curve - Quick start, gentle end (for alerts, feedback)
  static const Curve feedbackCurve = Curves.easeOut;

  /// Entrance curve - For elements entering the screen
  static const Curve entranceCurve = Curves.easeOut;

  /// Exit curve - For elements leaving the screen
  static const Curve exitCurve = Curves.easeIn;

  /// Spring/Bounce - Playful elements (physics-based bounce)
  static const Curve springCurve = Curves.elasticOut;

  // ═══════════════════════════════════════════
  // LOADING STATE COLORS
  // ═══════════════════════════════════════════
  /// Skeleton shimmer base color
  static const Color skeletonBase = Color(0xFFE0E0E0);

  /// Skeleton shimmer highlight color
  static const Color skeletonHighlight = Color(0xFFF5F5F5);

  /// Spinner color (primary orange)
  static const Color spinnerColor = Color(0xFFFF5722);

  // ═══════════════════════════════════════════
  // HELPER METHODS
  // ═══════════════════════════════════════════

  /// Create a standard animated container duration
  static Duration get animatedContainerDuration => standard;

  /// Create animation controller with standard duration
  static AnimationController createStandardController(TickerProvider vsync) {
    return AnimationController(duration: standard, vsync: vsync);
  }

  /// Create animation controller with fast duration
  static AnimationController createFastController(TickerProvider vsync) {
    return AnimationController(duration: fast, vsync: vsync);
  }
}
