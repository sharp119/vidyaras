import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import 'course_badge.dart';

/// Large course card for Recommended and Free Courses sections
class LargeCourseCard extends StatelessWidget {
  const LargeCourseCard({
    super.key,
    required this.title,
    required this.instructor,
    this.thumbnailUrl,
    this.rating,
    this.reviewCount,
    this.studentCount,
    this.duration,
    this.price,
    this.emiPrice,
    this.isFree = false,
    this.isLive = false,
    this.hasFreeTrial = false,
    this.isRecorded = false,
    this.onTap,
  });

  final String title;
  final String instructor;
  final String? thumbnailUrl;
  final double? rating;
  final int? reviewCount;
  final int? studentCount;
  final String? duration;
  final String? price;
  final String? emiPrice;
  final bool isFree;
  final bool isLive;
  final bool hasFreeTrial;
  final bool isRecorded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child: thumbnailUrl != null
                        ? CachedNetworkImage(
                            imageUrl: thumbnailUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.surfaceLight,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.surfaceLight,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          )
                        : Container(
                            color: AppColors.surfaceLight,
                            child: const Icon(
                              Icons.play_circle_outline,
                              size: 48,
                              color: AppColors.textTertiary,
                            ),
                          ),
                  ),
                ),
                // Badges
                Positioned(
                  top: 12,
                  right: 12,
                  child: Row(
                    children: [
                      if (isFree)
                        const CourseBadge(
                          label: 'Free',
                          color: AppColors.success,
                        ),
                      if (hasFreeTrial) ...[
                        if (isFree) const SizedBox(width: 8),
                        const CourseBadge(
                          label: 'Free Trial',
                          color: AppColors.primary,
                        ),
                      ],
                      if (isLive) ...[
                        if (isFree || hasFreeTrial) const SizedBox(width: 8),
                        const CourseBadge(
                          label: 'Live',
                          color: Color(0xFFEF4444),
                        ),
                      ],
                      if (isRecorded) ...[
                        if (isFree || hasFreeTrial || isLive)
                          const SizedBox(width: 8),
                        const CourseBadge(
                          label: 'Recorded',
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Instructor
                  Text(
                    instructor,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rating, students, duration
                  Row(
                    children: [
                      if (rating != null) ...[
                        const Icon(
                          Icons.star,
                          size: 18,
                          color: Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating!.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (reviewCount != null) ...[
                          const SizedBox(width: 2),
                          Text(
                            '($reviewCount)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        const SizedBox(width: 16),
                      ],
                      if (studentCount != null) ...[
                        const Icon(
                          Icons.people_outline,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          studentCount.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (duration != null) ...[
                        const Icon(
                          Icons.schedule,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          duration!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),

                  // Price
                  if (price != null && !isFree) ...[
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            height: 1,
                          ),
                        ),
                        if (emiPrice != null) ...[
                          const SizedBox(width: 12),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              'or $emiPrice',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                  if (isFree) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Free',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                        height: 1,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
