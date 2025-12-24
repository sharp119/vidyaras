import 'package:flutter/material.dart';

import '../theme/app_gradients.dart';
import '../theme/app_spacing.dart';

/// Flexible header widget with optional title, subtitle, search, and actions
/// Design System: Theme-based styling, proper spacing
class AdaptiveHeader extends StatelessWidget {
  const AdaptiveHeader({
    super.key,
    this.title,
    this.subtitle,
    this.showNotification = false,
    this.onNotificationTap,
    this.actions,
    this.gradient,
    this.backgroundColor,
    this.showSearch = false,
    this.onSearchTap,
    this.searchPlaceholder,
  });

  final Widget? title;
  final Widget? subtitle;
  final bool showNotification;
  final VoidCallback? onNotificationTap;
  final List<Widget>? actions;
  final Gradient? gradient;
  final Color? backgroundColor;
  final bool showSearch;
  final VoidCallback? onSearchTap;
  final String? searchPlaceholder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppGradients.primary,
        color: backgroundColor,
      ),
      child: SafeArea(
        top: false, // Allow content to flow behind status bar
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            MediaQuery.of(context).padding.top +
                AppSpacing.sm, // Add status bar height manually
            AppSpacing.lg,
            52,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row with title and actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title (flexible widget)
                  if (title != null) Expanded(child: title!),

                  // Actions (notification icon or custom actions)
                  Row(
                    children: [
                      if (showNotification)
                        IconButton(
                          onPressed: onNotificationTap,
                          icon: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      if (actions != null) ...actions!,
                    ],
                  ),
                ],
              ),

              // Subtitle (if provided)
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.lg + AppSpacing.mdSm),
                subtitle!,
              ],

              // Search bar
              if (showSearch) ...[
                const SizedBox(height: AppSpacing.mdLg),
                GestureDetector(
                  onTap: onSearchTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md - 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(AppRadius.card),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: theme.colorScheme.onSurfaceVariant,
                          size: AppIconSize.standard,
                        ),
                        const SizedBox(width: AppSpacing.mdSm),
                        Text(
                          searchPlaceholder ?? 'Search...',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
