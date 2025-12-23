import 'package:flutter/material.dart';

/// VidyaRas App Color Palette
/// Based on VidyaRas Design System for a warm, culturally authentic learning experience
class AppColors {
  AppColors._();

  // ═══════════════════════════════════════════
  // PRIMARY ACCENT
  // ═══════════════════════════════════════════
  /// Primary Orange - Used for CTAs, active navigation, progress indicators, key highlights
  static const Color primary = Color(0xFFFF5722);
  static const Color primaryLight = Color(0xFFFF8A65);
  static const Color primaryDark = Color(0xFFE64A19);

  // ═══════════════════════════════════════════
  // SECONDARY ACCENTS
  // ═══════════════════════════════════════════
  /// Teal - Subtle secondary accents, attribute tags
  static const Color secondary = Color(0xFF00BCD4);

  /// Green - Completed states, success indicators
  static const Color accent = Color(0xFF4CAF50);

  // ═══════════════════════════════════════════
  // GRADIENTS
  // ═══════════════════════════════════════════
  static const Color gradientStart = Color(0xFFFF5722);
  static const Color gradientEnd = Color(0xFFFF8A65);

  // Legacy gradient colors (kept for compatibility)
  static const Color orangeGradientStart = Color(0xFFFF5722);
  static const Color orangeGradientEnd = Color(0xFFFF8A65);

  // ═══════════════════════════════════════════
  // NEUTRALS
  // ═══════════════════════════════════════════
  /// Primary background, content areas
  static const Color white = Color(0xFFFFFFFF);

  /// Subtle backgrounds, inactive states
  static const Color lightGray = Color(0xFFF5F5F5);

  /// Dividers, borders
  static const Color mediumGray = Color(0xFFE0E0E0);

  /// Secondary text, icons
  static const Color darkGray = Color(0xFF424242);

  /// Primary text, strong headings
  static const Color black = Color(0xFF212121);

  /// Helper text color
  static const Color helperText = Color(0xFF757575);

  // Semantic aliases
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color border = Color(0xFFE0E0E0);

  // ═══════════════════════════════════════════
  // SEMANTIC / STATUS COLORS
  // ═══════════════════════════════════════════
  /// Completed actions, success states
  static const Color success = Color(0xFF4CAF50);

  /// Moderate alerts, "Good" score
  static const Color warning = Color(0xFFFF9800);

  /// Errors, important warnings
  static const Color error = Color(0xFFF44336);

  /// Live badge, "New" badge
  static const Color liveNew = Color(0xFFE53935);

  /// Info states
  static const Color info = Color(0xFF2196F3);

  // ═══════════════════════════════════════════
  // CATEGORY ICON COLORS
  // ═══════════════════════════════════════════
  static const Color music = Color(0xFF2196F3);
  static const Color wellness = Color(0xFF4CAF50);
  static const Color yoga = Color(0xFFFF5722);
  static const Color arts = Color(0xFFE91E63);

  // Category backgrounds (10% opacity)
  static Color get musicBg => music.withOpacity(0.1);
  static Color get wellnessBg => wellness.withOpacity(0.1);
  static Color get yogaBg => yoga.withOpacity(0.1);
  static Color get artsBg => arts.withOpacity(0.1);

  // ═══════════════════════════════════════════
  // SCORE BADGE COLORS
  // ═══════════════════════════════════════════
  static const Color scoreExcellent = Color(0xFF4CAF50);
  static const Color scoreGood = Color(0xFFFF9800);
  static const Color scoreNeedsWork = Color(0xFFF44336);

  // ═══════════════════════════════════════════
  // BADGE COLORS
  // ═══════════════════════════════════════════
  static const Color badgeNew = Color(0xFFE53935);
  static const Color badgeFree = Color(0xFF4CAF50);
  static const Color badgeFreeTrial = Color(0xFFFF5722);
  static const Color badgeWorkshop = Color(0xFFFF9800);
  static const Color badgeLive = Color(0xFFE53935);

  // ═══════════════════════════════════════════
  // ATTRIBUTE TAG COLORS
  // ═══════════════════════════════════════════
  static const Color tagLanguage = Color(0xFF00BCD4);
  static const Color tagCertificate = Color(0xFF4CAF50);
  static const Color tagDuration = Color(0xFF757575);

  // ═══════════════════════════════════════════
  // DARK MODE COLORS
  // ═══════════════════════════════════════════
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimaryText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFFB0B0B0);
  static const Color darkDisabledText = Color(0xFF616161);
  static const Color darkAccentOrange = Color(0xFFFF8A65);
  static const Color darkDivider = Color(0xFF363636);
  static const Color darkIconInactive = Color(0xFFB0B0B0);
  static const Color darkIconActive = Color(0xFFFF8A65);

  // ═══════════════════════════════════════════
  // UI SPECIFIC
  // ═══════════════════════════════════════════
  static const Color premiumBadge = Color(0xFFFF5722);
  static const Color referralCardBg = Color(0xFFFFF3E0);
  static const Color referralBackground = Color(0xFFFFF3E0);
  static const Color referralAccent = Color(0xFFFF5722);
  static const Color progressBackground = Color(0xFFE0E0E0);
  static const Color progressFill = Color(0xFFFF5722);

  // ═══════════════════════════════════════════
  // LEGACY ALIASES (for compatibility)
  // ═══════════════════════════════════════════
  static const Color secondaryDark = Color(0xFF00838F);
  static const Color secondaryLight = Color(0xFF4DD0E1);
  static const Color accentDark = Color(0xFF388E3C);
  static const Color accentLight = Color(0xFF81C784);

  // Legacy dance/lifeSkills (kept for existing features)
  static const Color dance = Color(0xFFE91E63);
  static const Color lifeSkills = Color(0xFF8B5CF6);

  // Deprecated text colors - use theme colors instead
  @Deprecated('Use Theme.of(context).colorScheme.onSurface')
  static const Color textPrimary = Color(0xFF212121);
  @Deprecated('Use Theme.of(context).colorScheme.onSurfaceVariant')
  static const Color textSecondary = Color(0xFF424242);
  @Deprecated('Use Theme.of(context).colorScheme.onSurfaceVariant with opacity')
  static const Color textTertiary = Color(0xFF757575);
  @Deprecated('Use Theme.of(context).colorScheme.onPrimary')
  static const Color textOnPrimary = Color(0xFFFFFFFF);
}
