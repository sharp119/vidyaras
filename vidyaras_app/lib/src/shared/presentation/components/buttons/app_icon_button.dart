import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Icon-only button
/// Used for settings, close, menu icons, etc.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 24,
    this.color,
    this.backgroundColor,
    this.padding = 8,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            icon,
            size: size,
            color: color ??
                (onPressed == null
                    ? AppColors.textTertiary
                    : AppColors.textPrimary),
          ),
        ),
      ),
    );
  }
}
