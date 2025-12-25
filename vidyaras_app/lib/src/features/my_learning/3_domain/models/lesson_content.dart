import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_content.freezed.dart';
part 'lesson_content.g.dart';

@freezed
class LessonContent with _$LessonContent {
  const factory LessonContent({
    required String id,
    required String lessonId,
    required String type, // video, text, pdf, etc.
    required String title,
    String? url,
    int? duration,
    int? orderIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LessonContent;

  factory LessonContent.fromJson(Map<String, dynamic> json) =>
      _$LessonContentFromJson(json);
}
