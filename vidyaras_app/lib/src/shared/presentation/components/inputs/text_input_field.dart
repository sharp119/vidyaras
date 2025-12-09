import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Text input field with leading icon and label
/// Used for email, name, phone, etc.
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          enabled: enabled,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            prefixIcon: leadingIcon != null
                ? Icon(
                    leadingIcon,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  )
                : null,
            // Border and other properties are now handled by inputDecorationTheme in AppTheme
          ),
        ),
      ],
    );
  }
}
