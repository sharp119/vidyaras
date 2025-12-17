import 'package:flutter/material.dart';

/// VidyaRas App Color Palette
/// Based on mockup designs for VidyaRas learning platform
class AppColors {
  AppColors._();

  // Primary Brand Color (Seed)
  static const Color primary = Color(0xFF6366F1); // Indigo/Blue

  // Secondary / Accent Colors
  static const Color secondary = Color(0xFFA855F7); // Purple
  static const Color accent = Color(0xFFF97316); // Orange

  // Extended Palette for Specific Uses (not covered by ColorScheme)
  // Gradients
  static const Color gradientStart = Color(0xFF4F87FF);
  static const Color gradientMiddle = Color(0xFF7B68EE);
  static const Color gradientEnd = Color(0xFF9C4DFF);

  static const Color orangeGradientStart = Color(0xFFEF6C00);
  static const Color orangeGradientEnd = Color(0xFFF57C00);

  // Backgrounds & Neutrals (explicit overrides if needed, otherwise use ColorScheme)
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);

  // Semantic Text Colors (Use sparingly, prefer ColorScheme.onSurface variants)
  @Deprecated('Use Theme.of(context).colorScheme.onSurface or similar')
  static const Color textPrimary = Color(0xFF1F2937); // Gray 900
  @Deprecated('Use Theme.of(context).colorScheme.onSurfaceVariant or similar')
  static const Color textSecondary = Color(0xFF4B5563); // Gray 700
  @Deprecated(
    'Use Theme.of(context).colorScheme.onSurfaceVariant (with opacity) or similar',
  )
  static const Color textTertiary = Color(0xFF9CA3AF); // Gray 400
  @Deprecated('Use Theme.of(context).colorScheme.onPrimary or similar')
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  static const Color border = Color(0xFFE5E7EB);

  // Feature Colors
  static const Color wellness = Color(0xFF10B981); // Emerald
  static const Color music = Color(0xFF6366F1); // Indigo
  static const Color dance = Color(0xFFF43F5E); // Rose
  static const Color arts = Color(0xFFF59E0B); // Amber
  static const Color lifeSkills = Color(0xFF8B5CF6); // Violet

  // UI Specific
  static const Color referralCardBg = Color(0xFFF3F0FF);
  static const Color premiumBadge = Color(0xFFF97316);

  // Legacy/Restored Colors (To maintain compatibility)
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color secondaryDark = Color(0xFF9333EA);
  static const Color secondaryLight = Color(0xFFC084FC);
  static const Color accentDark = Color(0xFFEA580C);
  static const Color accentLight = Color(0xFFFB923C);

  static const Color surfaceLight = Color(0xFFF5F5F5);

  static const Color referralBackground = Color(0xFFF5E6FF);
  static const Color referralAccent = Color(0xFF9333EA);

  static const Color progressBackground = Color(0xFFE5E7EB);
  static const Color progressFill = Color(0xFF1F2937);
}
