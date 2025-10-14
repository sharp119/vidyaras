import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../layout/avatar_with_badge.dart';
import '../typography/badge_label.dart';

/// Profile card showing user information and stats
/// Used on home/profile screen
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.imageUrl,
    this.isPremium = false,
    this.enrolledCount = 0,
    this.completedCount = 0,
    this.certificatesCount = 0,
    this.onEditTap,
  });

  final String name;
  final String email;
  final String? imageUrl;
  final bool isPremium;
  final int enrolledCount;
  final int completedCount;
  final int certificatesCount;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AvatarWithBadge(
                imageUrl: imageUrl,
                radius: 40,
                badgeIcon: Icons.edit,
                badgeColor: AppColors.accent,
                onBadgeTap: onEditTap,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (isPremium) ...[
                      const SizedBox(height: 8),
                      const PremiumBadge(),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.border),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                value: enrolledCount,
                label: 'Enrolled',
                color: AppColors.textPrimary,
              ),
              _StatItem(
                value: completedCount,
                label: 'Completed',
                color: AppColors.success,
              ),
              _StatItem(
                value: certificatesCount,
                label: 'Certificates',
                color: AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
