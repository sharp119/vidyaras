import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Bilingual text component displaying English and Hindi text together
/// Used throughout the app for accessibility in both languages
class BilingualText extends StatelessWidget {
  const BilingualText({
    super.key,
    required this.english,
    required this.hindi,
    this.englishStyle,
    this.hindiStyle,
    this.spacing = 8,
    this.alignment = CrossAxisAlignment.center,
  });

  final String english;
  final String hindi;
  final TextStyle? englishStyle;
  final TextStyle? hindiStyle;
  final double spacing;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          english,
          style: englishStyle ??
              const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.left,
        ),
        SizedBox(height: spacing),
        Text(
          hindi,
          style: hindiStyle ??
              const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.left,
        ),
      ],
    );
  }
}

/// Compact bilingual text (inline, separated by a divider)
class InlineBilingualText extends StatelessWidget {
  const InlineBilingualText({
    super.key,
    required this.english,
    required this.hindi,
    this.style,
    this.divider = ' • ',
  });

  final String english;
  final String hindi;
  final TextStyle? style;
  final String divider;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$english$divider$hindi',
      style: style ??
          const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
    );
  }
}
