import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Language toggle button for switching between Hindi and English
/// Design System: Theme-based typography, pill radius
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  final String currentLanguage; // 'en' or 'hi'
  final void Function(String) onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHindi = currentLanguage == 'hi';

    return GestureDetector(
      onTap: () => onLanguageChanged(isHindi ? 'en' : 'hi'),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.mdSm,
          vertical: AppSpacing.xs + 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isHindi ? 'हिंदी' : 'English',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(
              Icons.language,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// Simple language toggle button (text only)
class SimpleLanguageToggle extends StatelessWidget {
  const SimpleLanguageToggle({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  final String currentLanguage; // 'en' or 'hi'
  final void Function(String) onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isHindi = currentLanguage == 'hi';

    return InkWell(
      onTap: () => onLanguageChanged(isHindi ? 'en' : 'hi'),
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Text(
          isHindi ? 'हिंदी' : 'English',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
