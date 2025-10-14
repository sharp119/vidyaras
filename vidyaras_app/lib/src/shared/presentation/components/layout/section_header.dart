import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../buttons/app_text_button.dart';

/// Section header with title and optional action link
/// Used for "My Courses - View All", etc.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionTap,
    this.titleStyle,
    this.padding,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          if (actionLabel != null && onActionTap != null)
            AppTextButton(
              onPressed: onActionTap,
              label: actionLabel!,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
        ],
      ),
    );
  }
}
