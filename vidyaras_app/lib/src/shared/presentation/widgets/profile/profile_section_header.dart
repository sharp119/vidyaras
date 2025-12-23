import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Section header for profile screen
/// Design System: Theme typography, proper spacing
class ProfileSectionHeader extends StatelessWidget {
  const ProfileSectionHeader({super.key, required this.title, this.icon});

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.mdLg,
        AppSpacing.lg,
        AppSpacing.mdSm,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: AppIconSize.small,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
