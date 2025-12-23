import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Icon-only button
/// Design System: Theme-based styling
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = AppIconSize.standard,
    this.color,
    this.backgroundColor,
    this.padding = AppSpacing.sm,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.button),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Icon(
            icon,
            size: size,
            color:
                color ??
                (onPressed == null
                    ? theme.colorScheme.onSurfaceVariant.withOpacity(0.5)
                    : theme.colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}
