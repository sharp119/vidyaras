import 'package:freezed_annotation/freezed_annotation.dart';

import 'enrolled_course.dart';

part 'course_progress_detail.freezed.dart';
part 'course_progress_detail.g.dart';

/// Aggregated data needed for the course detail / curriculum view.
@freezed
class CourseProgressDetail with _$CourseProgressDetail {
  const factory CourseProgressDetail({
    required EnrolledCourse summary,
    required List<CourseSection> sections,
    @Default([]) List<CourseMaterial> generalMaterials,
    LiveClassWindow? upcomingLiveClass,
  }) = _CourseProgressDetail;

  factory CourseProgressDetail.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressDetailFromJson(json);
}

/// Represents a logical grouping of lectures inside a course.
@freezed
class CourseSection with _$CourseSection {
  const factory CourseSection({
    required String id,
    required String title,
    @Default(0) int orderIndex,
    @Default([]) List<CourseLecture> lectures,
  }) = _CourseSection;

  factory CourseSection.fromJson(Map<String, dynamic> json) =>
      _$CourseSectionFromJson(json);
}

/// Detailed lecture information surfaced on the curriculum list.
@freezed
class CourseLecture with _$CourseLecture {
  const factory CourseLecture({
    required String id,
    required String title,
    required String sectionId,
    required String sectionTitle,
    @Default(0) int orderIndex,
    String? description,
    int? durationMinutes,
    String? videoUrl,
    @Default([]) List<CourseMaterial> materials,
    @Default(LectureAccessStatus.available)
    @JsonKey(unknownEnumValue: LectureAccessStatus.available)
    LectureAccessStatus accessStatus,
    QuizRequirement? requiredQuiz,
    bool? isCompleted,
    DateTime? completedAt,
    LiveClassWindow? liveClass,
  }) = _CourseLecture;

  factory CourseLecture.fromJson(Map<String, dynamic> json) =>
      _$CourseLectureFromJson(json);
}

/// Downloadable resources linked to a course or lecture.
@freezed
class CourseMaterial with _$CourseMaterial {
  const factory CourseMaterial({
    required String id,
    required String title,
    required String type,
    required String fileUrl,
    String? sectionId,
  }) = _CourseMaterial;

  factory CourseMaterial.fromJson(Map<String, dynamic> json) =>
      _$CourseMaterialFromJson(json);
}

/// Live class schedule information.
@freezed
class LiveClassWindow with _$LiveClassWindow {
  const factory LiveClassWindow({
    required String id,
    required DateTime scheduledAt,
    @Default(120) int durationMinutes,
    required String zoomLink,
    String? meetingId,
    String? title,
    String? description,
    String? lectureId,
  }) = _LiveClassWindow;

  factory LiveClassWindow.fromJson(Map<String, dynamic> json) =>
      _$LiveClassWindowFromJson(json);
}

/// Access state for a lecture in the curriculum.
@JsonEnum(alwaysCreate: true)
enum LectureAccessStatus {
  locked,
  available,
  inProgress,
  completed,
}
