import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../3_domain/models/batch_info.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Card widget to display live batch information
class BatchInfoCard extends StatelessWidget {
  const BatchInfoCard({
    super.key,
    required this.batchInfo,
  });

  final BatchInfo batchInfo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final enrollmentPercentage = (batchInfo.enrolled / batchInfo.capacity * 100).round();
    final isAlmostFull = enrollmentPercentage >= 80;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.05),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.live_tv, size: 20, color: Color(0xFF3B82F6)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Join Live Batch',
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (isAlmostFull) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '🔥 Almost Full',
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),

                // Batch Name and Schedule
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        batchInfo.name,
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${batchInfo.schedule} • ${batchInfo.time}',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Start Date and Enrollment
                Row(
                  children: [
                    Text(
                      'Starts: ',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(batchInfo.startDate),
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${batchInfo.enrolled}/${batchInfo.capacity} enrolled',
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
