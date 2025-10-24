import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_item.freezed.dart';
part 'lesson_item.g.dart';

/// Represents a single lesson/video in a course
@freezed
class LessonItem with _$LessonItem {
  const factory LessonItem({
    required String id,
    required String title,
    required int durationMinutes,
    @Default(false) bool isLocked,
    @Default(false) bool isCompleted,
    String? description,
  }) = _LessonItem;

  factory LessonItem.fromJson(Map<String, dynamic> json) =>
      _$LessonItemFromJson(json);
}
