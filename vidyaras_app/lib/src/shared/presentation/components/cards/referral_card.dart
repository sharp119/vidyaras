import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../buttons/primary_button.dart';

/// Referral card showing points and invite CTA
/// Used on home/profile screen
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.referralBackground,
        borderRadius: BorderRadius.circular(16),
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
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                points.toString(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.referralAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            onPressed: onInviteTap,
            label: 'Invite Friends',
            fullWidth: true,
            gradient: LinearGradient(
              colors: [
                AppColors.referralAccent,
                AppColors.referralAccent.withOpacity(0.8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
