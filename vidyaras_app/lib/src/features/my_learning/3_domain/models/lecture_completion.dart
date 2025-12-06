import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecture_completion.freezed.dart';
part 'lecture_completion.g.dart';

/// Represents user's progress on a specific lecture
@freezed
class LectureCompletion with _$LectureCompletion {
  const factory LectureCompletion({
    required String id,
    required String userId,
    required String lectureId,
    required DateTime completedAt,
    int? watchedSeconds,
    DateTime? createdAt,
  }) = _LectureCompletion;

  factory LectureCompletion.fromJson(Map<String, dynamic> json) =>
      _$LectureCompletionFromJson(json);
}
