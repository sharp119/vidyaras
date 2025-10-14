import 'package:flutter/material.dart';
import '../../../../shared/presentation/components/layout/feature_icon_container.dart';
import '../../../../shared/presentation/components/typography/bilingual_text.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../models/intro_content.dart';

/// Individual intro/onboarding page widget
/// Displays a single intro screen with icon, title, and description
class IntroPage extends StatelessWidget {
  const IntroPage({
    super.key,
    required this.content,
  });

  final IntroContent content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
            englishStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            hindiStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            spacing: 12,
            alignment: CrossAxisAlignment.center,
          ),

          const SizedBox(height: 24),

          // Bilingual description
          BilingualText(
            english: content.descriptionEnglish,
            hindi: content.descriptionHindi,
            englishStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            hindiStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
              height: 1.5,
            ),
            spacing: 8,
            alignment: CrossAxisAlignment.center,
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
