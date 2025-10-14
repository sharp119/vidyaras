import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Horizontal divider with centered text
/// Used for "OR CONTINUE WITH" in login/signup
class DividerWithText extends StatelessWidget {
  const DividerWithText({
    super.key,
    required this.text,
    this.color,
    this.thickness = 1,
    this.spacing = 16,
  });

  final String text;
  final Color? color;
  final double thickness;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final dividerColor = color ?? AppColors.border;

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textTertiary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: dividerColor,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}
