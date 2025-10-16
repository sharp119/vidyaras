import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Stats card with icon, value, and label
/// Displays multiple stat items in a horizontal row with a card container
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.stats,
  });

  final List<StatCardItem> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
            .map((stat) => _StatCardItemWidget(
                  icon: stat.icon,
                  value: stat.value,
                  label: stat.label,
                  iconColor: stat.iconColor,
                ))
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 28,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
