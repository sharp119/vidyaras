import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_attempt_record.freezed.dart';
part 'quiz_attempt_record.g.dart';

/// Represents a user's quiz attempt record stored in the database
@freezed
class QuizAttemptRecord with _$QuizAttemptRecord {
  const factory QuizAttemptRecord({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'quiz_id') required String quizId,
    @Default(0) int score,
    @JsonKey(name: 'total_marks') required int totalMarks,
    double? percentage, // Auto-calculated by DB
    @JsonKey(name: 'time_taken_seconds') int? timeTakenSeconds,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _QuizAttemptRecord;

  factory QuizAttemptRecord.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptRecordFromJson(json);
}
