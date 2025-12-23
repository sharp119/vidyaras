import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Stats card with icon, value, and label
/// Design System: 24dp padding, 12dp card radius, theme typography
class StatsCard extends StatelessWidget {
  const StatsCard({super.key, required this.stats});

  final List<StatCardItem> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.mdLg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.large),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats
            .map(
              (stat) => _StatCardItemWidget(
                icon: stat.icon,
                value: stat.value,
                label: stat.label,
                iconColor: stat.iconColor,
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Data model for a stat card item
class StatCardItem {
  const StatCardItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final dynamic value; // Can be int, String, or double (e.g., "89%" or 5)
  final String label;
  final Color iconColor;
}

class _StatCardItemWidget extends StatelessWidget {
  const _StatCardItemWidget({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final dynamic value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.mdSm),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 28, color: iconColor),
        ),
        const SizedBox(height: AppSpacing.mdSm),
        Text(
          value.toString(),
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
            height: 1,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
