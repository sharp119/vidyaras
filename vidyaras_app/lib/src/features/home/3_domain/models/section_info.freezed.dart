// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SectionInfo _$SectionInfoFromJson(Map<String, dynamic> json) {
  return _SectionInfo.fromJson(json);
}

/// @nodoc
mixin _$SectionInfo {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<LessonItem> get lessons => throw _privateConstructorUsedError;
  int? get totalDurationMinutes => throw _privateConstructorUsedError;

  /// Serializes this SectionInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SectionInfoCopyWith<SectionInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SectionInfoCopyWith<$Res> {
  factory $SectionInfoCopyWith(
    SectionInfo value,
    $Res Function(SectionInfo) then,
  ) = _$SectionInfoCopyWithImpl<$Res, SectionInfo>;
  @useResult
  $Res call({
    String id,
    String title,
    List<LessonItem> lessons,
    int? totalDurationMinutes,
  });
}

/// @nodoc
class _$SectionInfoCopyWithImpl<$Res, $Val extends SectionInfo>
    implements $SectionInfoCopyWith<$Res> {
  _$SectionInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? lessons = null,
    Object? totalDurationMinutes = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            lessons: null == lessons
                ? _value.lessons
                : lessons // ignore: cast_nullable_to_non_nullable
                      as List<LessonItem>,
            totalDurationMinutes: freezed == totalDurationMinutes
                ? _value.totalDurationMinutes
                : totalDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SectionInfoImplCopyWith<$Res>
    implements $SectionInfoCopyWith<$Res> {
  factory _$$SectionInfoImplCopyWith(
    _$SectionInfoImpl value,
    $Res Function(_$SectionInfoImpl) then,
  ) = __$$SectionInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    List<LessonItem> lessons,
    int? totalDurationMinutes,
  });
}

/// @nodoc
class __$$SectionInfoImplCopyWithImpl<$Res>
    extends _$SectionInfoCopyWithImpl<$Res, _$SectionInfoImpl>
    implements _$$SectionInfoImplCopyWith<$Res> {
  __$$SectionInfoImplCopyWithImpl(
    _$SectionInfoImpl _value,
    $Res Function(_$SectionInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? lessons = null,
    Object? totalDurationMinutes = freezed,
  }) {
    return _then(
      _$SectionInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        lessons: null == lessons
            ? _value._lessons
            : lessons // ignore: cast_nullable_to_non_nullable
                  as List<LessonItem>,
        totalDurationMinutes: freezed == totalDurationMinutes
            ? _value.totalDurationMinutes
            : totalDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SectionInfoImpl implements _SectionInfo {
  const _$SectionInfoImpl({
    required this.id,
    required this.title,
    required final List<LessonItem> lessons,
    this.totalDurationMinutes,
  }) : _lessons = lessons;

  factory _$SectionInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SectionInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final List<LessonItem> _lessons;
  @override
  List<LessonItem> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  @override
  final int? totalDurationMinutes;

  @override
  String toString() {
    return 'SectionInfo(id: $id, title: $title, lessons: $lessons, totalDurationMinutes: $totalDurationMinutes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SectionInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._lessons, _lessons) &&
            (identical(other.totalDurationMinutes, totalDurationMinutes) ||
                other.totalDurationMinutes == totalDurationMinutes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    const DeepCollectionEquality().hash(_lessons),
    totalDurationMinutes,
  );

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SectionInfoImplCopyWith<_$SectionInfoImpl> get copyWith =>
      __$$SectionInfoImplCopyWithImpl<_$SectionInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SectionInfoImplToJson(this);
  }
}

abstract class _SectionInfo implements SectionInfo {
  const factory _SectionInfo({
    required final String id,
    required final String title,
    required final List<LessonItem> lessons,
    final int? totalDurationMinutes,
  }) = _$SectionInfoImpl;

  factory _SectionInfo.fromJson(Map<String, dynamic> json) =
      _$SectionInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  List<LessonItem> get lessons;
  @override
  int? get totalDurationMinutes;

  /// Create a copy of SectionInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SectionInfoImplCopyWith<_$SectionInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
