import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/features/my_courses/1_presentation/widgets/lecture_list_item.dart';
import 'package:vidyaras_app/src/features/my_courses/2_application/providers/my_courses_providers.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/course_progress_detail.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

class CourseProgressDetailScreen extends ConsumerStatefulWidget {
  const CourseProgressDetailScreen({
    super.key,
    required this.courseId,
    this.focusLectureId,
  });

  final String courseId;
  final String? focusLectureId;

  @override
  ConsumerState<CourseProgressDetailScreen> createState() =>
      _CourseProgressDetailScreenState();
}

class _CourseProgressDetailScreenState
    extends ConsumerState<CourseProgressDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _lectureKeys = {};
  bool _didAutoScroll = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync =
        ref.watch(courseProgressDetailProvider(widget.courseId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _ErrorView(
            message: error.toString(),
            onRetry: () =>
                ref.invalidate(courseProgressDetailProvider(widget.courseId)),
          ),
          data: (detail) => _buildContent(detail),
        ),
      ),
    );
  }

  Widget _buildContent(CourseProgressDetail detail) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_didAutoScroll || widget.focusLectureId == null) return;
      final targetKey = _lectureKeys[widget.focusLectureId];
      if (targetKey?.currentContext != null) {
        Scrollable.ensureVisible(
          targetKey!.currentContext!,
          duration: const Duration(milliseconds: 400),
          alignment: 0.2,
        );
        _didAutoScroll = true;
      }
    });

    final summary = detail.summary;
    final liveClass = detail.upcomingLiveClass;
    final showJoinButton = liveClass != null && _isJoinWindowOpen(liveClass);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 260,
          flexibleSpace: FlexibleSpaceBar(
            background: _HeroHeader(summary: summary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Instructor: ${summary.instructor}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                _ProgressSummary(summary: summary),
                if (showJoinButton) ...[
                  const SizedBox(height: 20),
                  _JoinLiveClassButton(
                    liveClass: liveClass!,
                    onJoin: () => _launchUrl(liveClass.zoomLink),
                  ),
                ],
                const SizedBox(height: 24),
                const Text(
                  'Curriculum',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        ...detail.sections.map(
          (section) => SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionHeader(title: section.title),
                  ...section.lectures.map((lecture) {
                    final key =
                        _lectureKeys.putIfAbsent(lecture.id, () => GlobalKey());
                    return Padding(
                      key: key,
                      padding: const EdgeInsets.only(bottom: 12),
                      child: LectureListItem(
                        lecture: lecture,
                        onOpenRecording: lecture.videoUrl == null
                            ? null
                            : () => _launchUrl(lecture.videoUrl!),
                        onOpenMaterials: lecture.materials.isEmpty
                            ? null
                            : () => _showMaterialsSheet(lecture),
                        onOpenTests: lecture.requiredQuiz == null
                            ? null
                            : () => context.goNamed('main', extra: 2),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
        if (detail.generalMaterials.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Course Materials',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...detail.generalMaterials.map(
                    (material) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: _MaterialIcon(type: material.type),
                      title: Text(
                        material.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        material.type.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      trailing: const Icon(Icons.open_in_new),
                      onTap: () => _launchUrl(material.fileUrl),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  bool _isJoinWindowOpen(LiveClassWindow liveClass) {
    final now = DateTime.now();
    final start = liveClass.scheduledAt.subtract(const Duration(minutes: 15));
    final end = liveClass.scheduledAt
        .add(Duration(minutes: liveClass.durationMinutes + 10));
    return now.isAfter(start) && now.isBefore(end);
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrlString(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to open link')),
        );
      }
    }
  }

  void _showMaterialsSheet(CourseLecture lecture) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Materials · ${lecture.title}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            ...lecture.materials.map(
              (material) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: _MaterialIcon(type: material.type),
                title: Text(material.title),
                subtitle: Text(material.type.toUpperCase()),
                trailing: const Icon(Icons.open_in_new),
                onTap: () {
                  Navigator.of(context).pop();
                  _launchUrl(material.fileUrl);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.summary});

  final EnrolledCourse summary;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            image: summary.thumbnailUrl == null
                ? null
                : DecorationImage(
                    image: NetworkImage(summary.thumbnailUrl!),
                    fit: BoxFit.cover,
                  ),
            color: AppColors.primary.withOpacity(0.8),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: summary.progressPercent.clamp(0, 1),
                minHeight: 8,
                backgroundColor: Colors.white24,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
              ),
              const SizedBox(height: 10),
              Text(
                '${(summary.progressPercent * 100).round()}% complete',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressSummary extends StatelessWidget {
  const _ProgressSummary({required this.summary});

  final EnrolledCourse summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ProgressTile(
            label: 'Lectures',
            value: '${summary.completedLectures}/${summary.totalLectures}',
            icon: Icons.menu_book_outlined,
          ),
          _ProgressTile(
            label: 'Last Accessed',
            value: summary.lastAccessedAt == null
                ? '—'
                : DateFormat.MMMd().format(summary.lastAccessedAt!),
            icon: Icons.schedule_outlined,
          ),
          _ProgressTile(
            label: 'Status',
            value: summary.isCompleted ? 'Completed' : 'In Progress',
            icon: summary.isCompleted
                ? Icons.verified_outlined
                : Icons.flash_on_outlined,
          ),
        ],
      ),
    );
  }
}

class _ProgressTile extends StatelessWidget {
  const _ProgressTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _JoinLiveClassButton extends StatelessWidget {
  const _JoinLiveClassButton({
    required this.liveClass,
    required this.onJoin,
  });

  final LiveClassWindow liveClass;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d · h:mm a');
    final scheduleLabel = formatter.format(liveClass.scheduledAt);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Live class starting soon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            scheduleLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onJoin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            icon: const Icon(Icons.video_call_outlined),
            label: const Text(
              'Join Live Class',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaterialIcon extends StatelessWidget {
  const _MaterialIcon({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (type.toLowerCase()) {
      case 'pdf':
        icon = Icons.picture_as_pdf_outlined;
        break;
      case 'doc':
        icon = Icons.description_outlined;
        break;
      case 'video':
        icon = Icons.video_file_outlined;
        break;
      case 'image':
        icon = Icons.image_outlined;
        break;
      default:
        icon = Icons.insert_drive_file_outlined;
    }
    return CircleAvatar(
      backgroundColor: AppColors.primary.withOpacity(0.12),
      foregroundColor: AppColors.primary,
      child: Icon(icon),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
