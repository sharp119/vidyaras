import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';

/// Flexible header widget with optional title, subtitle, search, and actions
///
/// Accepts Text widgets for title and subtitle so you can control styling.
/// Use title for the main heading (like "VidyaRas" or "Practice and track your progress")
/// Use subtitle for secondary text (like "Welcome back,")
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

  /// Title widget (e.g., Text with custom styling)
  /// Displayed at the top of the header
  final Widget? title;

  /// Subtitle widget (e.g., Text with custom styling)
  /// Displayed below the title
  final Widget? subtitle;

  /// Whether to show notification icon
  final bool showNotification;

  /// Callback for notification tap
  final VoidCallback? onNotificationTap;

  /// Optional action widgets (like menu icon)
  final List<Widget>? actions;

  /// Optional gradient background
  final Gradient? gradient;

  /// Optional solid background color (used if gradient is null)
  final Color? backgroundColor;

  /// Whether to show search bar
  final bool showSearch;

  /// Callback for search tap
  final VoidCallback? onSearchTap;

  /// Search bar placeholder text
  final String? searchPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient ?? AppGradients.primary,
        color: backgroundColor,
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 52),
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
              if (subtitle != null) ...[const SizedBox(height: 32), subtitle!],

              // Search bar
              if (showSearch) ...[
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: onSearchTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          searchPlaceholder ?? 'Search...',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
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
