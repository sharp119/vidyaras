import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../progress/progress_bar.dart';

/// Course card showing thumbnail, title, instructor, rating, price, and progress
/// Design System: 12dp card radius, 16dp padding, theme typography
class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.title,
    required this.instructor,
    this.thumbnailUrl,
    this.rating,
    this.price,
    this.progress,
    this.onTap,
  });

  final String title;
  final String instructor;
  final String? thumbnailUrl;
  final double? rating;
  final String? price;
  final double? progress; // 0.0 to 1.0
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            AspectRatio(
              aspectRatio: 16 / 9,
              child: thumbnailUrl != null
                  ? CachedNetworkImage(
                      imageUrl: thumbnailUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.image_not_supported,
                          size: AppIconSize.large,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    )
                  : Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.play_circle_outline,
                        size: AppIconSize.large,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge, // H3: 16sp
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    instructor,
                    style: theme.textTheme.bodyMedium, // Body: 14sp
                  ),
                  const SizedBox(height: AppSpacing.mdSm),
                  Row(
                    children: [
                      if (rating != null) ...[
                        const Icon(
                          Icons.star,
                          size: AppIconSize.small,
                          color: Color(0xFFFBBF24), // Gold for stars
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          rating!.toStringAsFixed(1),
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(width: AppSpacing.md),
                      ],
                      if (price != null)
                        Text(
                          price == '₹0' || price == '₹0.0' || price == '₹0.00'
                              ? 'Free'
                              : price!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                price == '₹0' ||
                                    price == '₹0.0' ||
                                    price == '₹0.00'
                                ? AppColors.success
                                : null,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            if (progress != null) ...[
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: theme.textTheme.labelSmall, // Helper: 12sp
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ProgressBar(progress: progress!, showPercentage: true),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
