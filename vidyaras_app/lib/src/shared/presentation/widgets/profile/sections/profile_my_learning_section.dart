import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../profile_list_tile.dart';
import '../profile_section_header.dart';

/// My Learning section for profile screen
/// Shows enrolled courses and certificates
class ProfileMyLearningSection extends StatelessWidget {
  const ProfileMyLearningSection({
    super.key,
    required this.enrolledCount,
    required this.certificatesCount,
    this.onContinueLearningTap,
    this.onCertificatesTap,
  });

  final int enrolledCount;
  final int certificatesCount;
  final VoidCallback? onContinueLearningTap;
  final VoidCallback? onCertificatesTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProfileSectionHeader(
          title: 'My Learning',
          icon: Icons.school_outlined,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              ProfileListTile(
                icon: Icons.play_circle_outline,
                title: 'Continue Learning',
                subtitle: '$enrolledCount course${enrolledCount != 1 ? 's' : ''} in progress',
                iconColor: AppColors.primary,
                onTap: onContinueLearningTap ?? () {
                  // Navigate to Main Shell with Courses tab (index 1)
                  context.go('/main', extra: 1);
                },
              ),
              ProfileListTile(
                icon: Icons.emoji_events_outlined,
                title: 'Certificates',
                subtitle: '$certificatesCount earned certificate${certificatesCount != 1 ? 's' : ''}',
                iconColor: AppColors.accent,
                showDivider: false,
                onTap: onCertificatesTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
