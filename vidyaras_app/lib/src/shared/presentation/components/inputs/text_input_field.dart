import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Text input field with leading icon and label
/// Design System: Border #E0E0E0, focus 2dp orange, 8dp radius
class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.leadingIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData? leadingIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          enabled: enabled,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            prefixIcon: leadingIcon != null
                ? Icon(
                    leadingIcon,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: AppIconSize.small,
                  )
                : null,
            // Border and other properties are handled by inputDecorationTheme in AppTheme
          ),
        ),
      ],
    );
  }
}
