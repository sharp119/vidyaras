import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../buttons/primary_button.dart';

/// Referral card showing points and invite CTA
/// Design System: 20dp padding, 16dp radius, theme typography
class ReferralCard extends StatelessWidget {
  const ReferralCard({
    super.key,
    required this.points,
    required this.onInviteTap,
    this.title = 'Referral Points',
    this.description = 'Refer friends to earn points and unlock rewards',
  });

  final int points;
  final VoidCallback onInviteTap;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.referralBackground,
        borderRadius: BorderRadius.circular(AppRadius.large),
        border: Border.all(
          color: AppColors.referralAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.card_giftcard,
                    color: AppColors.referralAccent,
                    size: AppIconSize.standard,
                  ),
                  const SizedBox(width: AppSpacing.mdSm),
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall, // 18sp
                  ),
                ],
              ),
              Text(
                points.toString(),
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.referralAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.mdSm),
          Text(
            description,
            style: theme.textTheme.bodyMedium, // 14sp
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(
            onPressed: onInviteTap,
            label: 'Invite Friends',
            fullWidth: true,
            backgroundColor: AppColors.referralAccent,
          ),
        ],
      ),
    );
  }
}
