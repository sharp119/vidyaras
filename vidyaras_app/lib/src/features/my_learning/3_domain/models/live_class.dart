import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_class.freezed.dart';
part 'live_class.g.dart';

/// Represents a scheduled live class session
@freezed
class LiveClass with _$LiveClass {
  const factory LiveClass({
    required String id,
    required String courseId,
    String? lectureId,
    required String title,
    String? description,
    required DateTime scheduledAt,
    @Default(120) int durationMinutes,
    required String zoomLink,
    String? meetingId,
    String? passcode,
    String? recordingUrl,
    @Default('upcoming') String status, // completed, upcoming, live
    DateTime? createdAt,
  }) = _LiveClass;

  factory LiveClass.fromJson(Map<String, dynamic> json) =>
      _$LiveClassFromJson(json);
}

extension LiveClassX on LiveClass {
  /// Check if this is a past session with recording available
  bool get hasRecording => recordingUrl != null && recordingUrl!.isNotEmpty;

  /// Check if this is an upcoming or live session
  bool get isUpcoming => status == 'upcoming' || status == 'live';

  /// Check if session is currently live
  bool get isLive => status == 'live';

  /// Check if session is completed
  bool get isCompleted => status == 'completed';

  /// Format scheduled time for display
  String get formattedSchedule {
    final now = DateTime.now();
    final diff = scheduledAt.difference(now);

    if (diff.inDays > 7) {
      return '${scheduledAt.day}/${scheduledAt.month}/${scheduledAt.year}';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} days away';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours away';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes away';
    } else if (diff.inMinutes > -durationMinutes) {
      return 'Live Now';
    } else {
      return 'Completed';
    }
  }
}
