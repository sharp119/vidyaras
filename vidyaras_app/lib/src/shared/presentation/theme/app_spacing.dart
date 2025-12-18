import 'package:flutter/material.dart';

/// VidyaRas App Spacing System
/// Provides consistent spacing values based on 4dp baseline
class AppSpacing {
  AppSpacing._();

  // Base spacing scale (4dp baseline)
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
  static const double huge = 48.0;
  static const double massive = 64.0;

  // Screen gutters
  static const double screenPadding = 20.0;
  static const double screenPaddingCompact = 16.0;

  // Section spacing
  static const double sectionGap = 24.0;
  static const double itemGap = 12.0;
  static const double itemGapTight = 8.0;

  // Card padding
  static const double cardPadding = 16.0;
  static const double cardPaddingLarge = 20.0;

  // Convenience EdgeInsets for screen padding
  static const EdgeInsets screenAll = EdgeInsets.all(screenPadding);
  static const EdgeInsets screenHorizontal = EdgeInsets.symmetric(horizontal: screenPadding);
  static const EdgeInsets screenVertical = EdgeInsets.symmetric(vertical: screenPadding);
}

/// VidyaRas App Border Radius System
/// Provides consistent border radius values
class AppRadius {
  AppRadius._();

  // Base radius scale
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double full = 999.0;

  // Semantic aliases
  static const double card = 16.0;
  static const double button = 12.0;
  static const double input = 12.0;
  static const double chip = 8.0;
  static const double bottomSheet = 20.0;

  // Convenience BorderRadius constructors
  static BorderRadius get cardRadius => BorderRadius.circular(card);
  static BorderRadius get buttonRadius => BorderRadius.circular(button);
  static BorderRadius get inputRadius => BorderRadius.circular(input);
  static BorderRadius get chipRadius => BorderRadius.circular(chip);
}

/// VidyaRas App Elevation System
/// Provides consistent elevation/shadow values
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double card = 2.0;
  static const double cardRaised = 4.0;
  static const double overlay = 8.0;
  static const double fab = 12.0;
}


