import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Badge label component for status, membership, tags
/// Design System compliant with predefined badge types
class BadgeLabel extends StatelessWidget {
  const BadgeLabel({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 12,
    this.padding,
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.mdSm,
            vertical: AppSpacing.xs,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: textColor ?? AppColors.primary,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// New badge - red background, white text
class NewBadge extends StatelessWidget {
  const NewBadge({super.key, this.label = 'New'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.badgeNew,
      textColor: AppColors.white,
    );
  }
}

/// Free badge - green background, white text
class FreeBadge extends StatelessWidget {
  const FreeBadge({super.key, this.label = 'Free'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.badgeFree,
      textColor: AppColors.white,
    );
  }
}

/// Live badge - red background, white text
class LiveBadge extends StatelessWidget {
  const LiveBadge({super.key, this.label = '🔴 Live'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.badgeLive,
      textColor: AppColors.white,
    );
  }
}

/// Workshop badge - orange background, white text
class WorkshopBadge extends StatelessWidget {
  const WorkshopBadge({super.key, this.label = 'Workshop'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.badgeWorkshop,
      textColor: AppColors.white,
    );
  }
}

/// Free Trial badge - primary orange, white text
class FreeTrialBadge extends StatelessWidget {
  const FreeTrialBadge({super.key, this.label = 'Free Trial'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.badgeFreeTrial,
      textColor: AppColors.white,
    );
  }
}

/// Premium Member badge
class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key, this.label = 'Premium Member'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.premiumBadge.withOpacity(0.1),
      textColor: AppColors.premiumBadge,
    );
  }
}

/// Success badge - green tint
class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.success.withOpacity(0.1),
      textColor: AppColors.success,
    );
  }
}

/// Error badge - red tint
class ErrorBadge extends StatelessWidget {
  const ErrorBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: AppColors.error.withOpacity(0.1),
      textColor: AppColors.error,
    );
  }
}

/// Score badge with color based on score level
enum ScoreLevel { excellent, good, needsWork }

class ScoreBadge extends StatelessWidget {
  const ScoreBadge({super.key, required this.label, required this.level});

  final String label;
  final ScoreLevel level;

  Color get _backgroundColor {
    switch (level) {
      case ScoreLevel.excellent:
        return AppColors.scoreExcellent;
      case ScoreLevel.good:
        return AppColors.scoreGood;
      case ScoreLevel.needsWork:
        return AppColors.scoreNeedsWork;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BadgeLabel(
      label: label,
      backgroundColor: _backgroundColor,
      textColor: AppColors.white,
    );
  }
}
