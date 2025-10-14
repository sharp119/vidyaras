import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Stats card showing active courses, completed courses, and points
class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.activeCourses,
    required this.completedCourses,
    required this.points,
  });

  final int activeCourses;
  final int completedCourses;
  final int points;

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
        children: [
          _StatItem(
            icon: Icons.play_circle_outline,
            value: activeCourses,
            label: 'Active',
            iconColor: AppColors.primary,
          ),
          _StatItem(
            icon: Icons.emoji_events_outlined,
            value: completedCourses,
            label: 'Completed',
            iconColor: AppColors.success,
          ),
          _StatItem(
            icon: Icons.card_giftcard,
            value: points,
            label: 'Points',
            iconColor: AppColors.accent,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final int value;
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
