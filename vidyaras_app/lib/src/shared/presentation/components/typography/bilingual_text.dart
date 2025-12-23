import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Bilingual text component displaying English and Hindi text together
/// Design System: Theme-based typography
class BilingualText extends StatelessWidget {
  const BilingualText({
    super.key,
    required this.english,
    required this.hindi,
    this.englishStyle,
    this.hindiStyle,
    this.spacing = AppSpacing.sm,
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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          english,
          style: englishStyle ?? theme.textTheme.headlineLarge, // H1: 24sp
          textAlign: alignment == CrossAxisAlignment.center
              ? TextAlign.center
              : TextAlign.left,
        ),
        SizedBox(height: spacing),
        Text(
          hindi,
          style:
              hindiStyle ??
              theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ), // 18sp
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
    final theme = Theme.of(context);

    return Text(
      '$english$divider$hindi',
      style:
          style ??
          theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: theme.colorScheme.onSurfaceVariant,
          ),
    );
  }
}
