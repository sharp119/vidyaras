import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_colors.dart';

/// Avatar with badge overlay
/// Used for profile pictures with edit icon or status indicators
class AvatarWithBadge extends StatelessWidget {
  const AvatarWithBadge({
    super.key,
    this.imageUrl,
    this.radius = 40,
    this.badgeIcon,
    this.badgeColor,
    this.onBadgeTap,
    this.borderColor,
    this.borderWidth = 0,
  });

  final String? imageUrl;
  final double radius;
  final IconData? badgeIcon;
  final Color? badgeColor;
  final VoidCallback? onBadgeTap;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: borderWidth > 0
                ? Border.all(
                    color: borderColor ?? AppColors.border,
                    width: borderWidth,
                  )
                : null,
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.surfaceLight,
            backgroundImage: imageUrl != null
                ? CachedNetworkImageProvider(imageUrl!)
                : null,
            child: imageUrl == null
                ? Icon(
                    Icons.person,
                    size: radius,
                    color: AppColors.textTertiary,
                  )
                : null,
          ),
        ),
        if (badgeIcon != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: onBadgeTap,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: badgeColor ?? AppColors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.surface,
                    width: 2,
                  ),
                ),
                child: Icon(
                  badgeIcon,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Simple circular avatar without badge
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.radius = 24,
    this.placeholderIcon = Icons.person,
  });

  final String? imageUrl;
  final double radius;
  final IconData placeholderIcon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.surfaceLight,
      backgroundImage: imageUrl != null
          ? CachedNetworkImageProvider(imageUrl!)
          : null,
      child: imageUrl == null
          ? Icon(
              placeholderIcon,
              size: radius,
              color: AppColors.textTertiary,
            )
          : null,
    );
  }
}
