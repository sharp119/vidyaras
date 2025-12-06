import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/my_learning_providers.dart';
import '../../3_domain/models/live_class.dart';

/// Tab content showing live classes for a course
/// Displays upcoming sessions and past recordings
class LiveClassesTabContent extends ConsumerWidget {
  const LiveClassesTabContent({
    super.key,
    required this.courseId,
  });

  final String courseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveClassesAsync = ref.watch(
      courseLiveClassesProvider(courseId: courseId),
    );

    return liveClassesAsync.when(
      data: (liveClasses) {
        if (liveClasses.isEmpty) {
          return _EmptyState();
        }

        // Separate upcoming and past classes
        final upcoming = liveClasses
            .where((lc) => lc.isUpcoming || lc.isLive)
            .toList()
          ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

        final past = liveClasses
            .where((lc) => lc.isCompleted)
            .toList()
          ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Upcoming Sessions
            if (upcoming.isNotEmpty) ...[
              const _SectionTitle(
                icon: Icons.upcoming,
                title: 'Upcoming Sessions',
                count: null,
              ),
              const SizedBox(height: 16),
              ...upcoming.map((liveClass) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _LiveClassCard(
                      liveClass: liveClass,
                      isUpcoming: true,
                    ),
                  )),
              const SizedBox(height: 24),
            ],

            // Past Recordings
            if (past.isNotEmpty) ...[
              _SectionTitle(
                icon: Icons.history,
                title: 'Past Recordings',
                count: past.length,
              ),
              const SizedBox(height: 16),
              ...past.map((liveClass) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _LiveClassCard(
                      liveClass: liveClass,
                      isUpcoming: false,
                    ),
                  )),
            ],

            const SizedBox(height: 40),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.title,
    this.count,
  });

  final IconData icon;
  final String title;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (count != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _LiveClassCard extends StatelessWidget {
  const _LiveClassCard({
    required this.liveClass,
    required this.isUpcoming,
  });

  final LiveClass liveClass;
  final bool isUpcoming;

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: liveClass.isLive
            ? Border.all(color: AppColors.error, width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Badge
                if (liveClass.isLive)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Text(
                          'LIVE NOW',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Title
                Text(
                  liveClass.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (liveClass.description != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    liveClass.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 12),

                // Schedule & Duration
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      liveClass.formattedSchedule,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${liveClass.durationMinutes} min',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                // Meeting Details (if available)
                if (liveClass.meetingId != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.videocam_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Meeting ID: ${liveClass.meetingId}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (liveClass.passcode != null) ...[
                        const SizedBox(width: 12),
                        Text(
                          'Passcode: ${liveClass.passcode}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                if (isUpcoming) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _openLink(liveClass.zoomLink),
                      icon: const Icon(Icons.video_call, size: 20),
                      label: Text(
                        liveClass.isLive ? 'Join Now' : 'Join Class',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: liveClass.isLive
                            ? AppColors.error
                            : AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ] else ...[
                  if (liveClass.hasRecording)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _openLink(liveClass.recordingUrl!),
                        icon: const Icon(Icons.play_arrow, size: 20),
                        label: const Text('Watch Recording'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: const Text(
                          'Recording not available',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            const Text(
              'No Live Classes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Live classes will appear here when scheduled',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
