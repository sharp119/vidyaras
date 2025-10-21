// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_performance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TestPerformance _$TestPerformanceFromJson(Map<String, dynamic> json) {
  return _TestPerformance.fromJson(json);
}

/// @nodoc
mixin _$TestPerformance {
  String get testId => throw _privateConstructorUsedError;
  String get testTitle => throw _privateConstructorUsedError;
  String get score => throw _privateConstructorUsedError; // e.g., "85%"
  String get attemptId =>
      throw _privateConstructorUsedError; // For navigating to specific attempt results
  DateTime get completedAt => throw _privateConstructorUsedError;

  /// Serializes this TestPerformance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestPerformanceCopyWith<TestPerformance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestPerformanceCopyWith<$Res> {
  factory $TestPerformanceCopyWith(
    TestPerformance value,
    $Res Function(TestPerformance) then,
  ) = _$TestPerformanceCopyWithImpl<$Res, TestPerformance>;
  @useResult
  $Res call({
    String testId,
    String testTitle,
    String score,
    String attemptId,
    DateTime completedAt,
  });
}

/// @nodoc
class _$TestPerformanceCopyWithImpl<$Res, $Val extends TestPerformance>
    implements $TestPerformanceCopyWith<$Res> {
  _$TestPerformanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? testTitle = null,
    Object? score = null,
    Object? attemptId = null,
    Object? completedAt = null,
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
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as String,
            attemptId: null == attemptId
                ? _value.attemptId
                : attemptId // ignore: cast_nullable_to_non_nullable
                      as String,
            completedAt: null == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TestPerformanceImplCopyWith<$Res>
    implements $TestPerformanceCopyWith<$Res> {
  factory _$$TestPerformanceImplCopyWith(
    _$TestPerformanceImpl value,
    $Res Function(_$TestPerformanceImpl) then,
  ) = __$$TestPerformanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String testId,
    String testTitle,
    String score,
    String attemptId,
    DateTime completedAt,
  });
}

/// @nodoc
class __$$TestPerformanceImplCopyWithImpl<$Res>
    extends _$TestPerformanceCopyWithImpl<$Res, _$TestPerformanceImpl>
    implements _$$TestPerformanceImplCopyWith<$Res> {
  __$$TestPerformanceImplCopyWithImpl(
    _$TestPerformanceImpl _value,
    $Res Function(_$TestPerformanceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestPerformance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? testTitle = null,
    Object? score = null,
    Object? attemptId = null,
    Object? completedAt = null,
  }) {
    return _then(
      _$TestPerformanceImpl(
        testId: null == testId
            ? _value.testId
            : testId // ignore: cast_nullable_to_non_nullable
                  as String,
        testTitle: null == testTitle
            ? _value.testTitle
            : testTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as String,
        attemptId: null == attemptId
            ? _value.attemptId
            : attemptId // ignore: cast_nullable_to_non_nullable
                  as String,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TestPerformanceImpl implements _TestPerformance {
  const _$TestPerformanceImpl({
    required this.testId,
    required this.testTitle,
    required this.score,
    required this.attemptId,
    required this.completedAt,
  });

  factory _$TestPerformanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestPerformanceImplFromJson(json);

  @override
  final String testId;
  @override
  final String testTitle;
  @override
  final String score;
  // e.g., "85%"
  @override
  final String attemptId;
  // For navigating to specific attempt results
  @override
  final DateTime completedAt;

  @override
  String toString() {
    return 'TestPerformance(testId: $testId, testTitle: $testTitle, score: $score, attemptId: $attemptId, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestPerformanceImpl &&
            (identical(other.testId, testId) || other.testId == testId) &&
            (identical(other.testTitle, testTitle) ||
                other.testTitle == testTitle) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.attemptId, attemptId) ||
                other.attemptId == attemptId) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    testId,
    testTitle,
    score,
    attemptId,
    completedAt,
  );

  /// Create a copy of TestPerformance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestPerformanceImplCopyWith<_$TestPerformanceImpl> get copyWith =>
      __$$TestPerformanceImplCopyWithImpl<_$TestPerformanceImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TestPerformanceImplToJson(this);
  }
}

abstract class _TestPerformance implements TestPerformance {
  const factory _TestPerformance({
    required final String testId,
    required final String testTitle,
    required final String score,
    required final String attemptId,
    required final DateTime completedAt,
  }) = _$TestPerformanceImpl;

  factory _TestPerformance.fromJson(Map<String, dynamic> json) =
      _$TestPerformanceImpl.fromJson;

  @override
  String get testId;
  @override
  String get testTitle;
  @override
  String get score; // e.g., "85%"
  @override
  String get attemptId; // For navigating to specific attempt results
  @override
  DateTime get completedAt;

  /// Create a copy of TestPerformance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestPerformanceImplCopyWith<_$TestPerformanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
