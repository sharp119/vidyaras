import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecture.freezed.dart';
part 'lecture.g.dart';

/// Represents an individual lecture/lesson within a course
@freezed
class Lecture with _$Lecture {
  const factory Lecture({
    required String id,
    required String courseId,
    required String moduleId,
    required String title,
    String? description,
    required int orderIndex,
    @Default('video') String type, // video, live, reading, practice
    int? durationMinutes,
    String? videoUrl,
    String? requiredQuizId,
    @Default(false) bool isCompleted,
    @Default(false) bool isLocked,
    DateTime? completedAt,
    int? watchedSeconds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Lecture;

  factory Lecture.fromJson(Map<String, dynamic> json) =>
      _$LectureFromJson(json);
}
