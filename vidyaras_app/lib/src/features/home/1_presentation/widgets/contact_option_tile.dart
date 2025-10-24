import 'package:flutter/material.dart';
import '../../3_domain/models/contact_method.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Single contact option tile for bottom sheet
class ContactOptionTile extends StatelessWidget {
  const ContactOptionTile({
    super.key,
    required this.method,
    required this.onTap,
  });

  final ContactMethod method;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: _getMethodColor(method).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          method.icon,
          color: _getMethodColor(method),
          size: 20,
        ),
      ),
      title: Text(
        method.label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Color _getMethodColor(ContactMethod method) {
    switch (method) {
      case ContactMethod.share:
        return AppColors.primary; // Primary blue
      case ContactMethod.phone:
        return const Color(0xFF10B981); // Green
    }
  }
}
