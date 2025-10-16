// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizResult _$QuizResultFromJson(Map<String, dynamic> json) {
  return _QuizResult.fromJson(json);
}

/// @nodoc
mixin _$QuizResult {
  String get testId => throw _privateConstructorUsedError;
  String get testTitle => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get score =>
      throw _privateConstructorUsedError; // Percentage score (0-100)
  DateTime get completedAt => throw _privateConstructorUsedError;
  int get timeTakenMinutes => throw _privateConstructorUsedError;

  /// Serializes this QuizResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizResultCopyWith<QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultCopyWith<$Res> {
  factory $QuizResultCopyWith(
    QuizResult value,
    $Res Function(QuizResult) then,
  ) = _$QuizResultCopyWithImpl<$Res, QuizResult>;
  @useResult
  $Res call({
    String testId,
    String testTitle,
    int totalQuestions,
    int correctAnswers,
    int score,
    DateTime completedAt,
    int timeTakenMinutes,
  });
}

/// @nodoc
class _$QuizResultCopyWithImpl<$Res, $Val extends QuizResult>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? testTitle = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? score = null,
    Object? completedAt = null,
    Object? timeTakenMinutes = null,
  }) {
    return _then(
      _value.copyWith(
            testId: null == testId
                ? _value.testId
                : testId // ignore: cast_nullable_to_non_nullable
                      as String,
            testTitle: null == testTitle
                ? _value.testTitle
                : testTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            completedAt: null == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            timeTakenMinutes: null == timeTakenMinutes
                ? _value.timeTakenMinutes
                : timeTakenMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizResultImplCopyWith<$Res>
    implements $QuizResultCopyWith<$Res> {
  factory _$$QuizResultImplCopyWith(
    _$QuizResultImpl value,
    $Res Function(_$QuizResultImpl) then,
  ) = __$$QuizResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String testId,
    String testTitle,
    int totalQuestions,
    int correctAnswers,
    int score,
    DateTime completedAt,
    int timeTakenMinutes,
  });
}

/// @nodoc
class __$$QuizResultImplCopyWithImpl<$Res>
    extends _$QuizResultCopyWithImpl<$Res, _$QuizResultImpl>
    implements _$$QuizResultImplCopyWith<$Res> {
  __$$QuizResultImplCopyWithImpl(
    _$QuizResultImpl _value,
    $Res Function(_$QuizResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? testTitle = null,
    Object? totalQuestions = null,
    Object? correctAnswers = null,
    Object? score = null,
    Object? completedAt = null,
    Object? timeTakenMinutes = null,
  }) {
    return _then(
      _$QuizResultImpl(
        testId: null == testId
            ? _value.testId
            : testId // ignore: cast_nullable_to_non_nullable
                  as String,
        testTitle: null == testTitle
            ? _value.testTitle
            : testTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        timeTakenMinutes: null == timeTakenMinutes
            ? _value.timeTakenMinutes
            : timeTakenMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizResultImpl extends _QuizResult {
  const _$QuizResultImpl({
    required this.testId,
    required this.testTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.completedAt,
    required this.timeTakenMinutes,
  }) : super._();

  factory _$QuizResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizResultImplFromJson(json);

  @override
  final String testId;
  @override
  final String testTitle;
  @override
  final int totalQuestions;
  @override
  final int correctAnswers;
  @override
  final int score;
  // Percentage score (0-100)
  @override
  final DateTime completedAt;
  @override
  final int timeTakenMinutes;

  @override
  String toString() {
    return 'QuizResult(testId: $testId, testTitle: $testTitle, totalQuestions: $totalQuestions, correctAnswers: $correctAnswers, score: $score, completedAt: $completedAt, timeTakenMinutes: $timeTakenMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizResultImpl &&
            (identical(other.testId, testId) || other.testId == testId) &&
            (identical(other.testTitle, testTitle) ||
                other.testTitle == testTitle) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.timeTakenMinutes, timeTakenMinutes) ||
                other.timeTakenMinutes == timeTakenMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    testId,
    testTitle,
    totalQuestions,
    correctAnswers,
    score,
    completedAt,
    timeTakenMinutes,
  );

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      __$$QuizResultImplCopyWithImpl<_$QuizResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizResultImplToJson(this);
  }
}

abstract class _QuizResult extends QuizResult {
  const factory _QuizResult({
    required final String testId,
    required final String testTitle,
    required final int totalQuestions,
    required final int correctAnswers,
    required final int score,
    required final DateTime completedAt,
    required final int timeTakenMinutes,
  }) = _$QuizResultImpl;
  const _QuizResult._() : super._();

  factory _QuizResult.fromJson(Map<String, dynamic> json) =
      _$QuizResultImpl.fromJson;

  @override
  String get testId;
  @override
  String get testTitle;
  @override
  int get totalQuestions;
  @override
  int get correctAnswers;
  @override
  int get score; // Percentage score (0-100)
  @override
  DateTime get completedAt;
  @override
  int get timeTakenMinutes;

  /// Create a copy of QuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizResultImplCopyWith<_$QuizResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
