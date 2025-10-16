// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TestStats _$TestStatsFromJson(Map<String, dynamic> json) {
  return _TestStats.fromJson(json);
}

/// @nodoc
mixin _$TestStats {
  int get totalTests => throw _privateConstructorUsedError;
  int get completedTests => throw _privateConstructorUsedError;
  String get averageScore => throw _privateConstructorUsedError;

  /// Serializes this TestStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestStatsCopyWith<TestStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestStatsCopyWith<$Res> {
  factory $TestStatsCopyWith(TestStats value, $Res Function(TestStats) then) =
      _$TestStatsCopyWithImpl<$Res, TestStats>;
  @useResult
  $Res call({int totalTests, int completedTests, String averageScore});
}

/// @nodoc
class _$TestStatsCopyWithImpl<$Res, $Val extends TestStats>
    implements $TestStatsCopyWith<$Res> {
  _$TestStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTests = null,
    Object? completedTests = null,
    Object? averageScore = null,
  }) {
    return _then(
      _value.copyWith(
            totalTests: null == totalTests
                ? _value.totalTests
                : totalTests // ignore: cast_nullable_to_non_nullable
                      as int,
            completedTests: null == completedTests
                ? _value.completedTests
                : completedTests // ignore: cast_nullable_to_non_nullable
                      as int,
            averageScore: null == averageScore
                ? _value.averageScore
                : averageScore // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TestStatsImplCopyWith<$Res>
    implements $TestStatsCopyWith<$Res> {
  factory _$$TestStatsImplCopyWith(
    _$TestStatsImpl value,
    $Res Function(_$TestStatsImpl) then,
  ) = __$$TestStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalTests, int completedTests, String averageScore});
}

/// @nodoc
class __$$TestStatsImplCopyWithImpl<$Res>
    extends _$TestStatsCopyWithImpl<$Res, _$TestStatsImpl>
    implements _$$TestStatsImplCopyWith<$Res> {
  __$$TestStatsImplCopyWithImpl(
    _$TestStatsImpl _value,
    $Res Function(_$TestStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalTests = null,
    Object? completedTests = null,
    Object? averageScore = null,
  }) {
    return _then(
      _$TestStatsImpl(
        totalTests: null == totalTests
            ? _value.totalTests
            : totalTests // ignore: cast_nullable_to_non_nullable
                  as int,
        completedTests: null == completedTests
            ? _value.completedTests
            : completedTests // ignore: cast_nullable_to_non_nullable
                  as int,
        averageScore: null == averageScore
            ? _value.averageScore
            : averageScore // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TestStatsImpl implements _TestStats {
  const _$TestStatsImpl({
    required this.totalTests,
    required this.completedTests,
    required this.averageScore,
  });

  factory _$TestStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestStatsImplFromJson(json);

  @override
  final int totalTests;
  @override
  final int completedTests;
  @override
  final String averageScore;

  @override
  String toString() {
    return 'TestStats(totalTests: $totalTests, completedTests: $completedTests, averageScore: $averageScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestStatsImpl &&
            (identical(other.totalTests, totalTests) ||
                other.totalTests == totalTests) &&
            (identical(other.completedTests, completedTests) ||
                other.completedTests == completedTests) &&
            (identical(other.averageScore, averageScore) ||
                other.averageScore == averageScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, totalTests, completedTests, averageScore);

  /// Create a copy of TestStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestStatsImplCopyWith<_$TestStatsImpl> get copyWith =>
      __$$TestStatsImplCopyWithImpl<_$TestStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestStatsImplToJson(this);
  }
}

abstract class _TestStats implements TestStats {
  const factory _TestStats({
    required final int totalTests,
    required final int completedTests,
    required final String averageScore,
  }) = _$TestStatsImpl;

  factory _TestStats.fromJson(Map<String, dynamic> json) =
      _$TestStatsImpl.fromJson;

  @override
  int get totalTests;
  @override
  int get completedTests;
  @override
  String get averageScore;

  /// Create a copy of TestStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestStatsImplCopyWith<_$TestStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
