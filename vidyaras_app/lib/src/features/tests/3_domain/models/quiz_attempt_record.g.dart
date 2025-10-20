// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizAttemptRecordImpl _$$QuizAttemptRecordImplFromJson(
  Map<String, dynamic> json,
) => _$QuizAttemptRecordImpl(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  quizId: json['quiz_id'] as String,
  score: (json['score'] as num?)?.toInt() ?? 0,
  totalMarks: (json['total_marks'] as num).toInt(),
  percentage: (json['percentage'] as num?)?.toDouble(),
  timeTakenSeconds: (json['time_taken_seconds'] as num?)?.toInt(),
  startedAt: DateTime.parse(json['started_at'] as String),
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
  isCompleted: json['is_completed'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$QuizAttemptRecordImplToJson(
  _$QuizAttemptRecordImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'quiz_id': instance.quizId,
  'score': instance.score,
  'total_marks': instance.totalMarks,
  'percentage': instance.percentage,
  'time_taken_seconds': instance.timeTakenSeconds,
  'started_at': instance.startedAt.toIso8601String(),
  'completed_at': instance.completedAt?.toIso8601String(),
  'is_completed': instance.isCompleted,
  'created_at': instance.createdAt?.toIso8601String(),
};
