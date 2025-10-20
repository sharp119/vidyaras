// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_attempt_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizAttemptRecord _$QuizAttemptRecordFromJson(Map<String, dynamic> json) {
  return _QuizAttemptRecord.fromJson(json);
}

/// @nodoc
mixin _$QuizAttemptRecord {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'quiz_id')
  String get quizId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_marks')
  int get totalMarks => throw _privateConstructorUsedError;
  double? get percentage =>
      throw _privateConstructorUsedError; // Auto-calculated by DB
  @JsonKey(name: 'time_taken_seconds')
  int? get timeTakenSeconds => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_completed')
  bool get isCompleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this QuizAttemptRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizAttemptRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizAttemptRecordCopyWith<QuizAttemptRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizAttemptRecordCopyWith<$Res> {
  factory $QuizAttemptRecordCopyWith(
    QuizAttemptRecord value,
    $Res Function(QuizAttemptRecord) then,
  ) = _$QuizAttemptRecordCopyWithImpl<$Res, QuizAttemptRecord>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'quiz_id') String quizId,
    int score,
    @JsonKey(name: 'total_marks') int totalMarks,
    double? percentage,
    @JsonKey(name: 'time_taken_seconds') int? timeTakenSeconds,
    @JsonKey(name: 'started_at') DateTime startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'is_completed') bool isCompleted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class _$QuizAttemptRecordCopyWithImpl<$Res, $Val extends QuizAttemptRecord>
    implements $QuizAttemptRecordCopyWith<$Res> {
  _$QuizAttemptRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizAttemptRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? quizId = null,
    Object? score = null,
    Object? totalMarks = null,
    Object? percentage = freezed,
    Object? timeTakenSeconds = freezed,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? isCompleted = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            quizId: null == quizId
                ? _value.quizId
                : quizId // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMarks: null == totalMarks
                ? _value.totalMarks
                : totalMarks // ignore: cast_nullable_to_non_nullable
                      as int,
            percentage: freezed == percentage
                ? _value.percentage
                : percentage // ignore: cast_nullable_to_non_nullable
                      as double?,
            timeTakenSeconds: freezed == timeTakenSeconds
                ? _value.timeTakenSeconds
                : timeTakenSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizAttemptRecordImplCopyWith<$Res>
    implements $QuizAttemptRecordCopyWith<$Res> {
  factory _$$QuizAttemptRecordImplCopyWith(
    _$QuizAttemptRecordImpl value,
    $Res Function(_$QuizAttemptRecordImpl) then,
  ) = __$$QuizAttemptRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'quiz_id') String quizId,
    int score,
    @JsonKey(name: 'total_marks') int totalMarks,
    double? percentage,
    @JsonKey(name: 'time_taken_seconds') int? timeTakenSeconds,
    @JsonKey(name: 'started_at') DateTime startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    @JsonKey(name: 'is_completed') bool isCompleted,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  });
}

/// @nodoc
class __$$QuizAttemptRecordImplCopyWithImpl<$Res>
    extends _$QuizAttemptRecordCopyWithImpl<$Res, _$QuizAttemptRecordImpl>
    implements _$$QuizAttemptRecordImplCopyWith<$Res> {
  __$$QuizAttemptRecordImplCopyWithImpl(
    _$QuizAttemptRecordImpl _value,
    $Res Function(_$QuizAttemptRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizAttemptRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? quizId = null,
    Object? score = null,
    Object? totalMarks = null,
    Object? percentage = freezed,
    Object? timeTakenSeconds = freezed,
    Object? startedAt = null,
    Object? completedAt = freezed,
    Object? isCompleted = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$QuizAttemptRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        quizId: null == quizId
            ? _value.quizId
            : quizId // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMarks: null == totalMarks
            ? _value.totalMarks
            : totalMarks // ignore: cast_nullable_to_non_nullable
                  as int,
        percentage: freezed == percentage
            ? _value.percentage
            : percentage // ignore: cast_nullable_to_non_nullable
                  as double?,
        timeTakenSeconds: freezed == timeTakenSeconds
            ? _value.timeTakenSeconds
            : timeTakenSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizAttemptRecordImpl implements _QuizAttemptRecord {
  const _$QuizAttemptRecordImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'quiz_id') required this.quizId,
    this.score = 0,
    @JsonKey(name: 'total_marks') required this.totalMarks,
    this.percentage,
    @JsonKey(name: 'time_taken_seconds') this.timeTakenSeconds,
    @JsonKey(name: 'started_at') required this.startedAt,
    @JsonKey(name: 'completed_at') this.completedAt,
    @JsonKey(name: 'is_completed') this.isCompleted = false,
    @JsonKey(name: 'created_at') this.createdAt,
  });

  factory _$QuizAttemptRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizAttemptRecordImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'quiz_id')
  final String quizId;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey(name: 'total_marks')
  final int totalMarks;
  @override
  final double? percentage;
  // Auto-calculated by DB
  @override
  @JsonKey(name: 'time_taken_seconds')
  final int? timeTakenSeconds;
  @override
  @JsonKey(name: 'started_at')
  final DateTime startedAt;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  @JsonKey(name: 'is_completed')
  final bool isCompleted;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'QuizAttemptRecord(id: $id, userId: $userId, quizId: $quizId, score: $score, totalMarks: $totalMarks, percentage: $percentage, timeTakenSeconds: $timeTakenSeconds, startedAt: $startedAt, completedAt: $completedAt, isCompleted: $isCompleted, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizAttemptRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.totalMarks, totalMarks) ||
                other.totalMarks == totalMarks) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.timeTakenSeconds, timeTakenSeconds) ||
                other.timeTakenSeconds == timeTakenSeconds) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    quizId,
    score,
    totalMarks,
    percentage,
    timeTakenSeconds,
    startedAt,
    completedAt,
    isCompleted,
    createdAt,
  );

  /// Create a copy of QuizAttemptRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizAttemptRecordImplCopyWith<_$QuizAttemptRecordImpl> get copyWith =>
      __$$QuizAttemptRecordImplCopyWithImpl<_$QuizAttemptRecordImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizAttemptRecordImplToJson(this);
  }
}

abstract class _QuizAttemptRecord implements QuizAttemptRecord {
  const factory _QuizAttemptRecord({
    required final String id,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'quiz_id') required final String quizId,
    final int score,
    @JsonKey(name: 'total_marks') required final int totalMarks,
    final double? percentage,
    @JsonKey(name: 'time_taken_seconds') final int? timeTakenSeconds,
    @JsonKey(name: 'started_at') required final DateTime startedAt,
    @JsonKey(name: 'completed_at') final DateTime? completedAt,
    @JsonKey(name: 'is_completed') final bool isCompleted,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
  }) = _$QuizAttemptRecordImpl;

  factory _QuizAttemptRecord.fromJson(Map<String, dynamic> json) =
      _$QuizAttemptRecordImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'quiz_id')
  String get quizId;
  @override
  int get score;
  @override
  @JsonKey(name: 'total_marks')
  int get totalMarks;
  @override
  double? get percentage; // Auto-calculated by DB
  @override
  @JsonKey(name: 'time_taken_seconds')
  int? get timeTakenSeconds;
  @override
  @JsonKey(name: 'started_at')
  DateTime get startedAt;
  @override
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @override
  @JsonKey(name: 'is_completed')
  bool get isCompleted;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;

  /// Create a copy of QuizAttemptRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizAttemptRecordImplCopyWith<_$QuizAttemptRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
