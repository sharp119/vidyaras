import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Text button with no background or border
/// Used for "Skip", "Forgot Password", "View All", etc.
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.color,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    // Determine color priority:
    // 1. Explicit color passed to widget
    // 2. Disabled state -> disabled color from theme
    // 3. Default -> primary color from theme (or secondary text if implied by legacy)
    
    // Legacy mapping: previously defaulted to textSecondary/Tertiary. 
    // Standard TextButton defaults to Primary. 
    // If we want to maintain the "grey link" look, we might need to be specific.
    // However, usually "AppTextButton" implies an action, so primary is often correct.
    // If the usage was for "Back", "Cancel" (often grey), we can rely on the color arg or theme overrides.
    // Let's defer to Theme defaults but allow color override.

    final effectiveColor = color ?? Theme.of(context).colorScheme.primary;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: effectiveColor,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: 0.1,
          fontFamily: 'Inter',
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize + 2),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
    );
  }
}
