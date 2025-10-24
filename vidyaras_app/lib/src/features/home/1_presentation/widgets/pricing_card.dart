import 'package:flutter/material.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Card widget for displaying pricing options (Full payment or EMI)
class PricingCard extends StatelessWidget {
  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    this.subtitle,
    required this.isSelected,
    this.onTap,
  });

  final String title;
  final int price;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 76,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.textPrimary.withOpacity(0.05)
              : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.textPrimary : AppColors.border,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(Icons.currency_rupee,
                    size: 16, color: AppColors.textPrimary),
                Text(
                  price.toString(),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
