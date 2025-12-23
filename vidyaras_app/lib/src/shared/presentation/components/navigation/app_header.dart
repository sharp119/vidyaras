import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../buttons/app_icon_button.dart';

/// Simple app header with title and optional action button
/// Design System: H1 (24sp) title, theme styling
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onActionTap,
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      color: backgroundColor ?? AppColors.surface,
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
                    style: theme.textTheme.headlineLarge, // H1: 24sp
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium, // Body: 14sp
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
              ),
          ],
        ),
      ),
    );
  }
}
