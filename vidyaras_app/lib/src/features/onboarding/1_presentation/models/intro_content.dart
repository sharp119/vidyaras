import 'package:flutter/material.dart';

/// Presentation model representing intro/onboarding screen content
/// Contains UI-specific data for each intro page
class IntroContent {
  const IntroContent({
    required this.titleEnglish,
    required this.titleHindi,
    required this.descriptionEnglish,
    required this.descriptionHindi,
    required this.icon,
    required this.gradient,
  });

  final String titleEnglish;
  final String titleHindi;
  final String descriptionEnglish;
  final String descriptionHindi;
  final IconData icon;
  final Gradient gradient;
}
