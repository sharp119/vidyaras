import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Language toggle button for switching between Hindi and English
/// Used in onboarding and settings
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
    final isHindi = currentLanguage == 'hi';

    return GestureDetector(
      onTap: () => onLanguageChanged(isHindi ? 'en' : 'hi'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.border,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isHindi ? 'हिंदी' : 'English',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.language,
              size: 16,
              color: AppColors.textSecondary,
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
    final isHindi = currentLanguage == 'hi';

    return InkWell(
      onTap: () => onLanguageChanged(isHindi ? 'en' : 'hi'),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          isHindi ? 'हिंदी' : 'English',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
