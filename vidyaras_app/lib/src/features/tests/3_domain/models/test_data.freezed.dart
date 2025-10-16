// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TestData _$TestDataFromJson(Map<String, dynamic> json) {
  return _TestData.fromJson(json);
}

/// @nodoc
mixin _$TestData {
  TestStats get stats => throw _privateConstructorUsedError;
  List<TestPerformance> get performanceOverview =>
      throw _privateConstructorUsedError;
  List<Test> get availableTests => throw _privateConstructorUsedError;
  List<Test> get completedTests => throw _privateConstructorUsedError;

  /// Serializes this TestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestDataCopyWith<TestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestDataCopyWith<$Res> {
  factory $TestDataCopyWith(TestData value, $Res Function(TestData) then) =
      _$TestDataCopyWithImpl<$Res, TestData>;
  @useResult
  $Res call({
    TestStats stats,
    List<TestPerformance> performanceOverview,
    List<Test> availableTests,
    List<Test> completedTests,
  });

  $TestStatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$TestDataCopyWithImpl<$Res, $Val extends TestData>
    implements $TestDataCopyWith<$Res> {
  _$TestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
    Object? performanceOverview = null,
    Object? availableTests = null,
    Object? completedTests = null,
  }) {
    return _then(
      _value.copyWith(
            stats: null == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as TestStats,
            performanceOverview: null == performanceOverview
                ? _value.performanceOverview
                : performanceOverview // ignore: cast_nullable_to_non_nullable
                      as List<TestPerformance>,
            availableTests: null == availableTests
                ? _value.availableTests
                : availableTests // ignore: cast_nullable_to_non_nullable
                      as List<Test>,
            completedTests: null == completedTests
                ? _value.completedTests
                : completedTests // ignore: cast_nullable_to_non_nullable
                      as List<Test>,
          )
          as $Val,
    );
  }

  /// Create a copy of TestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TestStatsCopyWith<$Res> get stats {
    return $TestStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TestDataImplCopyWith<$Res>
    implements $TestDataCopyWith<$Res> {
  factory _$$TestDataImplCopyWith(
    _$TestDataImpl value,
    $Res Function(_$TestDataImpl) then,
  ) = __$$TestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TestStats stats,
    List<TestPerformance> performanceOverview,
    List<Test> availableTests,
    List<Test> completedTests,
  });

  @override
  $TestStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$TestDataImplCopyWithImpl<$Res>
    extends _$TestDataCopyWithImpl<$Res, _$TestDataImpl>
    implements _$$TestDataImplCopyWith<$Res> {
  __$$TestDataImplCopyWithImpl(
    _$TestDataImpl _value,
    $Res Function(_$TestDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
    Object? performanceOverview = null,
    Object? availableTests = null,
    Object? completedTests = null,
  }) {
    return _then(
      _$TestDataImpl(
        stats: null == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as TestStats,
        performanceOverview: null == performanceOverview
            ? _value._performanceOverview
            : performanceOverview // ignore: cast_nullable_to_non_nullable
                  as List<TestPerformance>,
        availableTests: null == availableTests
            ? _value._availableTests
            : availableTests // ignore: cast_nullable_to_non_nullable
                  as List<Test>,
        completedTests: null == completedTests
            ? _value._completedTests
            : completedTests // ignore: cast_nullable_to_non_nullable
                  as List<Test>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TestDataImpl implements _TestData {
  const _$TestDataImpl({
    required this.stats,
    required final List<TestPerformance> performanceOverview,
    required final List<Test> availableTests,
    required final List<Test> completedTests,
  }) : _performanceOverview = performanceOverview,
       _availableTests = availableTests,
       _completedTests = completedTests;

  factory _$TestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestDataImplFromJson(json);

  @override
  final TestStats stats;
  final List<TestPerformance> _performanceOverview;
  @override
  List<TestPerformance> get performanceOverview {
    if (_performanceOverview is EqualUnmodifiableListView)
      return _performanceOverview;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_performanceOverview);
  }

  final List<Test> _availableTests;
  @override
  List<Test> get availableTests {
    if (_availableTests is EqualUnmodifiableListView) return _availableTests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTests);
  }

  final List<Test> _completedTests;
  @override
  List<Test> get completedTests {
    if (_completedTests is EqualUnmodifiableListView) return _completedTests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedTests);
  }

  @override
  String toString() {
    return 'TestData(stats: $stats, performanceOverview: $performanceOverview, availableTests: $availableTests, completedTests: $completedTests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestDataImpl &&
            (identical(other.stats, stats) || other.stats == stats) &&
            const DeepCollectionEquality().equals(
              other._performanceOverview,
              _performanceOverview,
            ) &&
            const DeepCollectionEquality().equals(
              other._availableTests,
              _availableTests,
            ) &&
            const DeepCollectionEquality().equals(
              other._completedTests,
              _completedTests,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    stats,
    const DeepCollectionEquality().hash(_performanceOverview),
    const DeepCollectionEquality().hash(_availableTests),
    const DeepCollectionEquality().hash(_completedTests),
  );

  /// Create a copy of TestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestDataImplCopyWith<_$TestDataImpl> get copyWith =>
      __$$TestDataImplCopyWithImpl<_$TestDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestDataImplToJson(this);
  }
}

abstract class _TestData implements TestData {
  const factory _TestData({
    required final TestStats stats,
    required final List<TestPerformance> performanceOverview,
    required final List<Test> availableTests,
    required final List<Test> completedTests,
  }) = _$TestDataImpl;

  factory _TestData.fromJson(Map<String, dynamic> json) =
      _$TestDataImpl.fromJson;

  @override
  TestStats get stats;
  @override
  List<TestPerformance> get performanceOverview;
  @override
  List<Test> get availableTests;
  @override
  List<Test> get completedTests;

  /// Create a copy of TestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestDataImplCopyWith<_$TestDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
