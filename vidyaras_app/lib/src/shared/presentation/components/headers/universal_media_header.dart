import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gradients.dart';

/// A universal 16:9 media header component for course screens.
/// Supports three states:
/// 1. Recorded Course: Thumbnail + Play button overlay
/// 2. Live Course (Upcoming): Thumbnail + Countdown overlay
/// 3. Live Course (Active): "Join Now" button state
/// 4. YouTube Playback: Automatically plays YouTube videos inline
class UniversalMediaHeader extends StatefulWidget {
  const UniversalMediaHeader({
    super.key,
    this.thumbnailUrl,
    this.videoUrl,
    this.isLive = false,
    this.nextLiveDate,
    this.onPlayPressed,
    this.onJoinPressed,
    this.onVideoEnded,
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

  /// Callback when video playback ends (for auto-advance)
  final VoidCallback? onVideoEnded;

  /// Whether video is currently playing (for future video player integration)
  final bool isPlaying;

  @override
  State<UniversalMediaHeader> createState() => _UniversalMediaHeaderState();
}

class _UniversalMediaHeaderState extends State<UniversalMediaHeader> {
  YoutubePlayerController? _youtubeController;
  bool _isYouTubeVideo = false;

  @override
  void initState() {
    super.initState();
    _checkVideoSource();
  }

  @override
  void didUpdateWidget(UniversalMediaHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoUrl != oldWidget.videoUrl) {
      _disposeController();
      _checkVideoSource();
    }
  }

  void _checkVideoSource() {
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      // Simple heuristic for YouTube links using the helper from the package or regex
      final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl!);

      if (videoId != null) {
        setState(() {
          _isYouTubeVideo = true;
          _youtubeController = YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
              hideControls: false,
              disableDragSeek: false,
              loop: false,
              isLive: false,
              forceHD: false,
              enableCaption: false,
            ),
          );
          // Add listener for video end detection
          _youtubeController!.addListener(_onPlayerStateChange);
        });
      } else {
        setState(() {
          _isYouTubeVideo = false;
        });
      }
    }
  }

  void _onPlayerStateChange() {
    if (_youtubeController != null &&
        _youtubeController!.value.playerState == PlayerState.ended) {
      widget.onVideoEnded?.call();
    }
  }

  void _disposeController() {
    _youtubeController?.removeListener(_onPlayerStateChange);
    _youtubeController?.dispose();
    _youtubeController = null;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background: YouTube Player, Thumbnail, or Gradient
          _buildBackground(),

          // Overlays ONLY if not playing YouTube video
          if (!(_isYouTubeVideo && widget.isPlaying)) ...[
            // Gradient overlay for better text visibility
            _buildGradientOverlay(),

            // Content overlay based on state
            _buildContentOverlay(),
          ],
        ],
      ),
    );
  }

  Widget _buildBackground() {
    // If it's a YouTube video and we are in "playing" mode (handled by parent or local toggle if we wanted)
    // Note: The parent passes `isPlaying`. If true, we show the player.
    if (_isYouTubeVideo && widget.isPlaying && _youtubeController != null) {
      return YoutubePlayer(
        controller: _youtubeController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColors.primary,
        progressColors: const ProgressBarColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.primary,
        ),
        onReady: () {
          // You can add logic here to start playing immediately if needed
          _youtubeController!.play();
        },
      );
    }

    if (widget.thumbnailUrl != null && widget.thumbnailUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: widget.thumbnailUrl!,
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
        gradient: widget.isLive ? AppGradients.purple : AppGradients.primary,
      ),
      child: Center(
        child: widget.isLive
            ? Icon(
                Icons.live_tv_rounded,
                size: 64,
                color: Colors.white.withValues(alpha: 0.8),
              )
            : (widget.videoUrl != null && widget.videoUrl!.isNotEmpty)
            ? Icon(
                Icons.play_circle_outline_rounded,
                size: 64,
                color: Colors.white.withValues(alpha: 0.8),
              )
            : const SizedBox.shrink(),
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
    // If external video (not YouTube) is playing, we might hide overlay too,
    // but typically non-youtube implementation would be customized here.
    // For now, only YouTube playback effectively "removes" the overlay via the parent `isPlaying` flag.

    if (widget.isLive) {
      return _buildLiveOverlay();
    }

    return _buildRecordedOverlay();
  }

  Widget _buildRecordedOverlay() {
    if (widget.videoUrl == null || widget.videoUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Center(
      child: GestureDetector(
        onTap: widget.onPlayPressed,
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
              onTap: widget.onJoinPressed,
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
          else if (widget.nextLiveDate != null)
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
    if (widget.nextLiveDate == null) return false;
    final now = DateTime.now();
    final diff = widget.nextLiveDate!.difference(now);
    // Consider "live now" if within 15 minutes of start time
    return diff.inMinutes <= 15 && diff.inMinutes >= -60;
  }

  String _formatCountdown() {
    if (widget.nextLiveDate == null) return '';
    final now = DateTime.now();
    final diff = widget.nextLiveDate!.difference(now);

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
