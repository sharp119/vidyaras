// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'batch_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BatchInfo _$BatchInfoFromJson(Map<String, dynamic> json) {
  return _BatchInfo.fromJson(json);
}

/// @nodoc
mixin _$BatchInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  String get schedule => throw _privateConstructorUsedError; // "Mon, Wed, Fri"
  String get time => throw _privateConstructorUsedError; // "7:00 AM IST"
  int get capacity => throw _privateConstructorUsedError;
  int get enrolled => throw _privateConstructorUsedError;

  /// Serializes this BatchInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BatchInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BatchInfoCopyWith<BatchInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchInfoCopyWith<$Res> {
  factory $BatchInfoCopyWith(BatchInfo value, $Res Function(BatchInfo) then) =
      _$BatchInfoCopyWithImpl<$Res, BatchInfo>;
  @useResult
  $Res call({
    String id,
    String name,
    DateTime startDate,
    String schedule,
    String time,
    int capacity,
    int enrolled,
  });
}

/// @nodoc
class _$BatchInfoCopyWithImpl<$Res, $Val extends BatchInfo>
    implements $BatchInfoCopyWith<$Res> {
  _$BatchInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BatchInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? schedule = null,
    Object? time = null,
    Object? capacity = null,
    Object? enrolled = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            schedule: null == schedule
                ? _value.schedule
                : schedule // ignore: cast_nullable_to_non_nullable
                      as String,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String,
            capacity: null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int,
            enrolled: null == enrolled
                ? _value.enrolled
                : enrolled // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BatchInfoImplCopyWith<$Res>
    implements $BatchInfoCopyWith<$Res> {
  factory _$$BatchInfoImplCopyWith(
    _$BatchInfoImpl value,
    $Res Function(_$BatchInfoImpl) then,
  ) = __$$BatchInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    DateTime startDate,
    String schedule,
    String time,
    int capacity,
    int enrolled,
  });
}

/// @nodoc
class __$$BatchInfoImplCopyWithImpl<$Res>
    extends _$BatchInfoCopyWithImpl<$Res, _$BatchInfoImpl>
    implements _$$BatchInfoImplCopyWith<$Res> {
  __$$BatchInfoImplCopyWithImpl(
    _$BatchInfoImpl _value,
    $Res Function(_$BatchInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BatchInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? schedule = null,
    Object? time = null,
    Object? capacity = null,
    Object? enrolled = null,
  }) {
    return _then(
      _$BatchInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        schedule: null == schedule
            ? _value.schedule
            : schedule // ignore: cast_nullable_to_non_nullable
                  as String,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String,
        capacity: null == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int,
        enrolled: null == enrolled
            ? _value.enrolled
            : enrolled // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchInfoImpl implements _BatchInfo {
  const _$BatchInfoImpl({
    required this.id,
    required this.name,
    required this.startDate,
    required this.schedule,
    required this.time,
    required this.capacity,
    required this.enrolled,
  });

  factory _$BatchInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime startDate;
  @override
  final String schedule;
  // "Mon, Wed, Fri"
  @override
  final String time;
  // "7:00 AM IST"
  @override
  final int capacity;
  @override
  final int enrolled;

  @override
  String toString() {
    return 'BatchInfo(id: $id, name: $name, startDate: $startDate, schedule: $schedule, time: $time, capacity: $capacity, enrolled: $enrolled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.schedule, schedule) ||
                other.schedule == schedule) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.enrolled, enrolled) ||
                other.enrolled == enrolled));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    startDate,
    schedule,
    time,
    capacity,
    enrolled,
  );

  /// Create a copy of BatchInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchInfoImplCopyWith<_$BatchInfoImpl> get copyWith =>
      __$$BatchInfoImplCopyWithImpl<_$BatchInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchInfoImplToJson(this);
  }
}

abstract class _BatchInfo implements BatchInfo {
  const factory _BatchInfo({
    required final String id,
    required final String name,
    required final DateTime startDate,
    required final String schedule,
    required final String time,
    required final int capacity,
    required final int enrolled,
  }) = _$BatchInfoImpl;

  factory _BatchInfo.fromJson(Map<String, dynamic> json) =
      _$BatchInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get startDate;
  @override
  String get schedule; // "Mon, Wed, Fri"
  @override
  String get time; // "7:00 AM IST"
  @override
  int get capacity;
  @override
  int get enrolled;

  /// Create a copy of BatchInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BatchInfoImplCopyWith<_$BatchInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
