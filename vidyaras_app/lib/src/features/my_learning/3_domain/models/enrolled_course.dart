import 'package:freezed_annotation/freezed_annotation.dart';
import 'lecture.dart';
import 'live_class.dart';
import 'course_material.dart';
import 'section_info.dart';

part 'enrolled_course.freezed.dart';
part 'enrolled_course.g.dart';

/// Represents a course that a user is enrolled in
/// Includes enrollment metadata and course content
@freezed
class EnrolledCourse with _$EnrolledCourse {
  const factory EnrolledCourse({
    // Course basic info
    required String id,
    required String title,
    required String instructor,
    String? thumbnailUrl,
    String? description,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int enrolledCount,
    String? price,
    String? duration,
    @Default(false) bool isLive,
    @Default(false) bool isRecorded,

    // Enrollment info
    String? enrollmentId,
    DateTime? enrolledAt,
    @Default('active') String enrollmentStatus, // active, completed, expired
    DateTime? lastAccessedAt,

    // Progress tracking
    @Default(0.0) double progress, // 0.0 to 1.0
    @Default(0) int totalLectures,
    @Default(0) int completedLectures,
    @Default(0) int totalDurationMinutes,

    // Course content (loaded separately for performance)
    @Default([]) List<SectionInfo> sections,
    @Default([]) List<Lecture> lectures,
    @Default([]) List<LiveClass> liveClasses,
    @Default([]) List<CourseMaterial> materials,

    // Metadata
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EnrolledCourse;

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) =>
      _$EnrolledCourseFromJson(json);
}

extension EnrolledCourseX on EnrolledCourse {
  /// Get next upcoming live class
  LiveClass? get nextLiveClass {
    final upcoming = liveClasses.where((lc) => lc.isUpcoming).toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));
    return upcoming.isEmpty ? null : upcoming.first;
  }

  /// Get all past live classes with recordings
  List<LiveClass> get pastClasses {
    return liveClasses.where((lc) => lc.isCompleted && lc.hasRecording).toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
  }

  /// Get lectures organized by section/module
  Map<String, List<Lecture>> get lecturesBySection {
    final Map<String, List<Lecture>> result = {};
    for (final lecture in lectures) {
      if (!result.containsKey(lecture.moduleId)) {
        result[lecture.moduleId] = [];
      }
      result[lecture.moduleId]!.add(lecture);
    }
    // Sort lectures within each section by order
    for (final key in result.keys) {
      result[key]!.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    }
    return result;
  }

  /// Get next incomplete lecture
  Lecture? get nextLecture {
    final incomplete =
        lectures.where((l) => !l.isCompleted && !l.isLocked).toList()
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return incomplete.isEmpty ? null : incomplete.first;
  }

  /// Check if course is completed
  bool get isCompleted =>
      totalLectures > 0 && completedLectures == totalLectures;

  /// Format progress percentage
  String get progressPercentage => '${(progress * 100).toInt()}%';

  /// Get estimated remaining time in hours
  int get estimatedRemainingHours {
    if (totalLectures == 0) return 0;
    final remainingLectures = totalLectures - completedLectures;
    final avgDuration = totalDurationMinutes / totalLectures;
    return ((remainingLectures * avgDuration) / 60).ceil();
  }
}
