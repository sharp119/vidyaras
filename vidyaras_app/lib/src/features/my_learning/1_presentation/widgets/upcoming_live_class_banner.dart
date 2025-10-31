import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../3_domain/models/live_class.dart';

/// Banner widget showing upcoming live classes
/// Displays next 1-3 upcoming sessions with quick join action
class UpcomingLiveClassBanner extends StatelessWidget {
  const UpcomingLiveClassBanner({
    super.key,
    required this.liveClasses,
  });

  final List<LiveClass> liveClasses;

  @override
  Widget build(BuildContext context) {
    if (liveClasses.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.orange,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.live_tv,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Upcoming Live Classes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Live Class Cards
          ...liveClasses.map((liveClass) => _LiveClassItem(
                liveClass: liveClass,
              )),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _LiveClassItem extends StatelessWidget {
  const _LiveClassItem({required this.liveClass});

  final LiveClass liveClass;

  Future<void> _joinClass() async {
    final uri = Uri.parse(liveClass.zoomLink);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLive = liveClass.isLive;
    final isUpcomingSoon = liveClass.scheduledAt
            .difference(DateTime.now())
            .inMinutes <
        60;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Time Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                liveClass.formattedSchedule,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${liveClass.durationMinutes} min',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),

          const SizedBox(width: 16),

          // Class Title
          Expanded(
            child: Text(
              liveClass.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 12),

          // Join Button
          if (isLive || isUpcomingSoon)
            ElevatedButton(
              onPressed: _joinClass,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isLive)
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Text(
                    isLive ? 'JOIN' : 'READY',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
