import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';
import '../../theme/app_spacing.dart';
import '../buttons/app_icon_button.dart';

/// Orange Gradient Header (Primary)
/// Design System: Gradient #FF5722 → #FF8A65, White text
class GradientHeader extends StatelessWidget {
  const GradientHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onActionTap,
    this.gradient,
  });

  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(gradient: gradient ?? AppGradients.primary),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24, // H1 from design system
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (actionIcon != null)
              AppIconButton(
                icon: actionIcon!,
                onPressed: onActionTap,
                size: AppIconSize.standard,
                color: AppColors.white,
              ),
          ],
        ),
      ),
    );
  }
}
