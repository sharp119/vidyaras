import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Unified header component for screens with gradient background
/// Design System: H1 (24sp) title, orange gradient
class UnifiedHeader extends StatelessWidget {
  const UnifiedHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onActionTap,
    this.actionRoute,
    this.gradient,
    this.height = 200,
  });

  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final String? actionRoute;
  final Gradient? gradient;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient:
            gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryLight],
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      subtitle!,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (actionIcon != null)
              Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    if (onActionTap != null) {
                      onActionTap!();
                    } else if (actionRoute != null) {
                      context.push(actionRoute!);
                    }
                  },
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(actionIcon!, size: 32, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
