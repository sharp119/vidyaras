import 'package:flutter/material.dart';

/// VidyaRas App Spacing System
/// Based on 4dp base unit for harmonious, predictable rhythm
class AppSpacing {
  AppSpacing._();

  // ═══════════════════════════════════════════
  // SPACING SCALE (4dp baseline)
  // ═══════════════════════════════════════════
  static const double xs = 4.0; // Tight inline spacing
  static const double sm = 8.0; // Horizontal card margins
  static const double mdSm = 12.0; // Vertical card margins
  static const double md = 16.0; // Button padding, content insets
  static const double mdLg = 24.0; // Section spacing
  static const double lg = 32.0; // Major block separation
  static const double xl = 48.0; // Screen padding, hero spacing
  static const double xxl = 64.0; // Large decorative spacing

  // Legacy aliases (for compatibility)
  static const double xxs = 4.0;
  static const double xxxl = 40.0;
  static const double huge = 48.0;
  static const double massive = 64.0;

  // Screen gutters
  static const double screenPadding = 16.0;
  static const double screenPaddingCompact = 12.0;

  // Section spacing
  static const double sectionGap = 24.0;
  static const double itemGap = 12.0;
  static const double itemGapTight = 8.0;

  // Card padding
  static const double cardPadding = 16.0;
  static const double cardPaddingLarge = 20.0;

  // Convenience EdgeInsets for screen padding
  static const EdgeInsets screenAll = EdgeInsets.all(screenPadding);
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(
    horizontal: screenPadding,
  );
  static const EdgeInsets screenVertical = EdgeInsets.symmetric(
    vertical: screenPadding,
  );
}

/// VidyaRas App Border Radius System
/// Based on design system specifications
class AppRadius {
  AppRadius._();

  // ═══════════════════════════════════════════
  // BORDER RADIUS SCALE (dp)
  // ═══════════════════════════════════════════
  static const double small = 8.0; // Buttons, tags, input fields
  static const double medium = 12.0; // Cards, modals
  static const double large = 16.0; // Prominent cards, hero elements
  static const double pill = 24.0; // Tab toggles, filter chips

  // Legacy aliases
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double full = 999.0;

  // Semantic aliases
  static const double card = 12.0;
  static const double button = 8.0;
  static const double input = 8.0;
  static const double chip = 24.0;
  static const double bottomSheet = 20.0;
  static const double modal = 12.0;
  static const double tabToggle = 24.0;

  // Convenience BorderRadius constructors
  static BorderRadius get cardRadius => BorderRadius.circular(card);
  static BorderRadius get buttonRadius => BorderRadius.circular(button);
  static BorderRadius get inputRadius => BorderRadius.circular(input);
  static BorderRadius get chipRadius => BorderRadius.circular(chip);
  static BorderRadius get smallRadius => BorderRadius.circular(small);
  static BorderRadius get mediumRadius => BorderRadius.circular(medium);
  static BorderRadius get largeRadius => BorderRadius.circular(large);
  static BorderRadius get pillRadius => BorderRadius.circular(pill);
}

/// VidyaRas App Elevation System
/// Based on design system card elevation specs
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double card = 1.0; // Default course cards, standard cards
  static const double cardRaised = 2.0; // Pressed/Hover state
  static const double overlay = 8.0; // Modal/Dialog overlays
  static const double modal = 12.0; // High elevation modals
  static const double fab = 6.0;
}

/// VidyaRas Icon Sizes
/// Based on design system specifications
class AppIconSize {
  AppIconSize._();

  static const double small = 20.0; // Inline icons
  static const double standard = 24.0; // Navigation, actionable icons
  static const double large = 48.0; // Illustrations, empty states

  // Circular icon container specs
  static const double containerDiameter = 48.0;
  static const double containerIconSize = 24.0;
  static const double containerBgOpacity = 0.1;
}

/// VidyaRas Button Dimensions
/// Based on design system specifications
class AppButtonSize {
  AppButtonSize._();

  static const double height =
      48.0; // Standard button height (minimum touch target)
  static const double horizontalPadding = 16.0;
  static const double tabToggleHeight = 40.0;
}
