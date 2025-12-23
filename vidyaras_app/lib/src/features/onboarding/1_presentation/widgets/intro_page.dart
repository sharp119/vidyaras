import 'package:flutter/material.dart';
import '../../../../shared/presentation/components/layout/feature_icon_container.dart';
import '../../../../shared/presentation/components/typography/bilingual_text.dart';
import '../../../../shared/presentation/theme/app_spacing.dart';
import '../models/intro_content.dart';

/// Individual intro/onboarding page widget
/// Design System: Theme-based typography, proper spacing
class IntroPage extends StatelessWidget {
  const IntroPage({super.key, required this.content});

  final IntroContent content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.mdLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Feature icon with gradient
          FeatureIconContainer(
            icon: content.icon,
            gradient: content.gradient,
            size: 140,
            iconSize: 70,
          ),

          const SizedBox(height: 48),

          // Bilingual title
          BilingualText(
            english: content.titleEnglish,
            hindi: content.titleHindi,
            englishStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            hindiStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            spacing: AppSpacing.mdSm,
            alignment: CrossAxisAlignment.center,
          ),

          const SizedBox(height: AppSpacing.mdLg),

          // Bilingual description
          BilingualText(
            english: content.descriptionEnglish,
            hindi: content.descriptionHindi,
            englishStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            hindiStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
              height: 1.5,
            ),
            spacing: AppSpacing.sm,
            alignment: CrossAxisAlignment.center,
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
