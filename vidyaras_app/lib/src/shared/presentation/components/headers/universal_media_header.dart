import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';

/// A universal 16:9 media header component for course screens.
/// Supports three states:
/// 1. Recorded Course: Thumbnail + Play button overlay
/// 2. Live Course (Upcoming): Thumbnail + Countdown overlay
/// 3. Live Course (Active): "Join Now" button state
class UniversalMediaHeader extends StatelessWidget {
  const UniversalMediaHeader({
    super.key,
    this.thumbnailUrl,
    this.videoUrl,
    this.isLive = false,
    this.nextLiveDate,
    this.onPlayPressed,
    this.onJoinPressed,
    this.isPlaying = false,
  });

  /// URL for the course thumbnail image
  final String? thumbnailUrl;

  /// URL for the video (if available for playback)
  final String? videoUrl;

  /// Whether this is a live course
  final bool isLive;

  /// Next scheduled live session (for countdown display)
  final DateTime? nextLiveDate;

  /// Callback when play button is pressed (for recorded content)
  final VoidCallback? onPlayPressed;

  /// Callback when join button is pressed (for live content)
  final VoidCallback? onJoinPressed;

  /// Whether video is currently playing (for future video player integration)
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background: Thumbnail or Gradient
          _buildBackground(),

          // Gradient overlay for better text visibility
          _buildGradientOverlay(),

          // Content overlay based on state
          _buildContentOverlay(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: thumbnailUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: AppColors.primary.withValues(alpha: 0.1),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => _buildPlaceholderBackground(),
      );
    }
    return _buildPlaceholderBackground();
  }

  Widget _buildPlaceholderBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: isLive ? AppGradients.purple : AppGradients.primary,
      ),
      child: Center(
        child: Icon(
          isLive ? Icons.live_tv_rounded : Icons.play_circle_outline_rounded,
          size: 64,
          color: Colors.white.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.1),
            Colors.black.withValues(alpha: 0.0),
            Colors.black.withValues(alpha: 0.4),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildContentOverlay() {
    if (isPlaying) {
      // Video player would go here in future
      return const SizedBox.shrink();
    }

    if (isLive) {
      return _buildLiveOverlay();
    }

    return _buildRecordedOverlay();
  }

  Widget _buildRecordedOverlay() {
    return Center(
      child: GestureDetector(
        onTap: onPlayPressed,
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.play_arrow_rounded,
            size: 40,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildLiveOverlay() {
    final bool isLiveNow = _isLiveNow();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Live badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isLiveNow ? Colors.red : AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLiveNow) ...[
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  isLiveNow ? 'LIVE NOW' : 'UPCOMING',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Countdown or Join button
          if (isLiveNow)
            GestureDetector(
              onTap: onJoinPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  'Join Class',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          else if (nextLiveDate != null)
            Text(
              _formatCountdown(),
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  bool _isLiveNow() {
    if (nextLiveDate == null) return false;
    final now = DateTime.now();
    final diff = nextLiveDate!.difference(now);
    // Consider "live now" if within 15 minutes of start time
    return diff.inMinutes <= 15 && diff.inMinutes >= -60;
  }

  String _formatCountdown() {
    if (nextLiveDate == null) return '';
    final now = DateTime.now();
    final diff = nextLiveDate!.difference(now);

    if (diff.isNegative) return 'Starting soon...';

    if (diff.inDays > 0) {
      return 'Starts in ${diff.inDays}d ${diff.inHours % 24}h';
    } else if (diff.inHours > 0) {
      return 'Starts in ${diff.inHours}h ${diff.inMinutes % 60}m';
    } else {
      return 'Starts in ${diff.inMinutes}m';
    }
  }
}
