import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

class LearningSummaryCard extends StatelessWidget {
  const LearningSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryItem(
            icon: Icons.local_fire_department,
            value: '3',
            label: 'Day Streak',
            iconColor: const Color(0xFFFFCC80),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          _SummaryItem(
            icon: Icons.timer_outlined,
            value: '12h',
            label: 'Hours Spent',
            iconColor: const Color(0xFF80DEEA),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),
          _SummaryItem(
            icon: Icons.check_circle_outline,
            value: '2',
            label: 'Completed',
            iconColor: const Color(0xFFA5D6A7),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.iconColor,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
