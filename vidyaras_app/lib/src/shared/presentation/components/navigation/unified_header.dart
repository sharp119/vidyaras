import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/app_colors.dart';

/// Unified header component for screens with gradient background
/// Matches the style of the Test Series screen for consistency
/// Supports title, subtitle, optional action button, and custom gradients
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

  /// Main title text
  final String title;

  /// Optional subtitle text
  final String? subtitle;

  /// Optional action icon (e.g., Icons.assessment_outlined)
  final IconData? actionIcon;

  /// Optional callback when action icon is tapped
  final VoidCallback? onActionTap;

  /// Optional route to navigate to when action icon is tapped
  /// If both onActionTap and actionRoute are provided, onActionTap takes precedence
  final String? actionRoute;

  /// Optional gradient. Defaults to orange gradient
  final Gradient? gradient;

  /// Header height. Defaults to 200
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 16,
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
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      actionIcon!,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

