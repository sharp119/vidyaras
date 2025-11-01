import 'package:freezed_annotation/freezed_annotation.dart';

part 'enrolled_course.freezed.dart';
part 'enrolled_course.g.dart';

/// Summary information for a course the learner is enrolled in.
@freezed
class EnrolledCourse with _$EnrolledCourse {
  const factory EnrolledCourse({
    required String enrollmentId,
    required String courseId,
    required String title,
    required String instructor,
    String? thumbnailUrl,
    String? duration,
    @Default(false) bool isLive,
    @Default(0) int totalLectures,
    @Default(0) int completedLectures,
    @Default(0.0) double progressPercent,
    LectureProgressSummary? nextLecture,
    DateTime? lastAccessedAt,
    @Default(false) bool isCompleted,
  }) = _EnrolledCourse;

  factory EnrolledCourse.fromJson(Map<String, dynamic> json) =>
      _$EnrolledCourseFromJson(json);
}

/// Lightweight view of the upcoming lecture for list cards and CTAs.
@freezed
class LectureProgressSummary with _$LectureProgressSummary {
  const factory LectureProgressSummary({
    required String lectureId,
    required String title,
    required String sectionTitle,
    @Default(false) bool isLocked,
    QuizRequirement? requiredQuiz,
  }) = _LectureProgressSummary;

  factory LectureProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$LectureProgressSummaryFromJson(json);
}

/// Metadata for informing the learner why a lecture is locked.
@freezed
class QuizRequirement with _$QuizRequirement {
  const factory QuizRequirement({
    required String quizId,
    required String title,
    @Default(70) int passingScore,
  }) = _QuizRequirement;

  factory QuizRequirement.fromJson(Map<String, dynamic> json) =>
      _$QuizRequirementFromJson(json);
}
