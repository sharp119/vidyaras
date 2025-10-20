import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

/// Represents a quiz with all its metadata
@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String title,
    String? description,
    String? courseId, // null means standalone/public quiz
    @Default(100) int fullMarks,
    @Default(30) int timeAllottedMinutes,
    @Default(false) bool isPublished, // Toggle to show/hide quiz
    @Default(true) bool isPublic, // If true, free for all; if false, for paid users
    String? difficultyLevel, // 'beginner', 'intermediate', 'advanced'
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
