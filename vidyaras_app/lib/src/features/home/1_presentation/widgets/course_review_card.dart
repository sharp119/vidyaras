import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../3_domain/models/course_review.dart';
import '../../../../shared/presentation/theme/app_colors.dart';

/// Card widget to display a course review
class CourseReviewCard extends StatelessWidget {
  const CourseReviewCard({
    super.key,
    required this.review,
  });

  final CourseReview review;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Rating
          Row(
            children: [
              // User Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.surfaceLight,
                backgroundImage: review.userAvatar != null
                    ? CachedNetworkImageProvider(review.userAvatar!)
                    : null,
                child: review.userAvatar == null
                    ? Text(
                        review.userName[0].toUpperCase(),
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // User Name and Date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      _getTimeAgo(review.createdAt),
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Rating Stars
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < review.rating
                        ? Icons.star
                        : Icons.star_border,
                    size: 16,
                    color: const Color(0xFFFBBF24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Review Text
          Text(
            review.reviewText,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 30) {
      return DateFormat('MMM d, y').format(dateTime);
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
