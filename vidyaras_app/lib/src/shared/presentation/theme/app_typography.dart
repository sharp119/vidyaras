import 'package:flutter/material.dart';

/// VidyaRas App Typography System
/// Based on design system specifications for clear, consistent text styles
class AppTypography {
  AppTypography._();

  // ═══════════════════════════════════════════
  // FONT SIZES (sp)
  // ═══════════════════════════════════════════
  static const double h1 = 24.0; // Screen titles ("My Learning")
  static const double h2 =
      20.0; // Major section titles ("Continue Learning", "My Courses")
  static const double h3 = 16.0; // Card titles, sub-section headers
  static const double body = 14.0; // Descriptions, chat messages
  static const double helper =
      12.0; // Metadata, timestamps, instructor names, review counts
  static const double button =
      14.0; // Button text (can be 14-16sp depending on prominence)
  static const double buttonLarge = 16.0;

  // ═══════════════════════════════════════════
  // FONT WEIGHTS
  // ═══════════════════════════════════════════
  static const FontWeight headingWeight = FontWeight.w700; // Bold for headings
  static const FontWeight semiWeight = FontWeight.w600; // Semi-bold
  static const FontWeight bodyWeight = FontWeight.w400; // Regular for body
  static const FontWeight ctaWeight = FontWeight.w700; // Bold for CTAs

  // ═══════════════════════════════════════════
  // TEXT COLORS (use these with Theme colors)
  // ═══════════════════════════════════════════
  // Primary text: #212121 (use colorScheme.onSurface)
  // Secondary text: #424242 (use colorScheme.onSurfaceVariant)
  // Helper text: #757575
  // CTA text: #FF5722 or white on orange

  // ═══════════════════════════════════════════
  // PREDEFINED TEXT STYLES
  // ═══════════════════════════════════════════

  /// Screen title style (H1)
  static TextStyle screenTitle(BuildContext context) {
    return TextStyle(
      fontSize: h1,
      fontWeight: headingWeight,
      color: Theme.of(context).colorScheme.onSurface,
      letterSpacing: -0.25,
    );
  }

  /// Section header style (H2)
  static TextStyle sectionHeader(BuildContext context) {
    return TextStyle(
      fontSize: h2,
      fontWeight: semiWeight,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  /// Card title style (H3)
  static TextStyle cardTitle(BuildContext context) {
    return TextStyle(
      fontSize: h3,
      fontWeight: semiWeight,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  /// Body text style
  static TextStyle bodyText(BuildContext context) {
    return TextStyle(
      fontSize: body,
      fontWeight: bodyWeight,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      height: 1.5,
    );
  }

  /// Helper/metadata text style
  static TextStyle helperText(BuildContext context) {
    return TextStyle(
      fontSize: helper,
      fontWeight: bodyWeight,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }

  /// Button text style
  static TextStyle buttonText(BuildContext context, {bool isLarge = false}) {
    return TextStyle(
      fontSize: isLarge ? buttonLarge : button,
      fontWeight: ctaWeight,
      letterSpacing: 0.1,
    );
  }

  /// CTA link text style (orange)
  static TextStyle ctaText(BuildContext context) {
    return TextStyle(
      fontSize: body,
      fontWeight: ctaWeight,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
