// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lecture_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LectureCompletion _$LectureCompletionFromJson(Map<String, dynamic> json) {
  return _LectureCompletion.fromJson(json);
}

/// @nodoc
mixin _$LectureCompletion {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get lectureId => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;
  int? get watchedSeconds => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this LectureCompletion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LectureCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LectureCompletionCopyWith<LectureCompletion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureCompletionCopyWith<$Res> {
  factory $LectureCompletionCopyWith(
    LectureCompletion value,
    $Res Function(LectureCompletion) then,
  ) = _$LectureCompletionCopyWithImpl<$Res, LectureCompletion>;
  @useResult
  $Res call({
    String id,
    String userId,
    String lectureId,
    DateTime completedAt,
    int? watchedSeconds,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$LectureCompletionCopyWithImpl<$Res, $Val extends LectureCompletion>
    implements $LectureCompletionCopyWith<$Res> {
  _$LectureCompletionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LectureCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? lectureId = null,
    Object? completedAt = null,
    Object? watchedSeconds = freezed,
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
            lectureId: null == lectureId
                ? _value.lectureId
                : lectureId // ignore: cast_nullable_to_non_nullable
                      as String,
            completedAt: null == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            watchedSeconds: freezed == watchedSeconds
                ? _value.watchedSeconds
                : watchedSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$LectureCompletionImplCopyWith<$Res>
    implements $LectureCompletionCopyWith<$Res> {
  factory _$$LectureCompletionImplCopyWith(
    _$LectureCompletionImpl value,
    $Res Function(_$LectureCompletionImpl) then,
  ) = __$$LectureCompletionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String lectureId,
    DateTime completedAt,
    int? watchedSeconds,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$LectureCompletionImplCopyWithImpl<$Res>
    extends _$LectureCompletionCopyWithImpl<$Res, _$LectureCompletionImpl>
    implements _$$LectureCompletionImplCopyWith<$Res> {
  __$$LectureCompletionImplCopyWithImpl(
    _$LectureCompletionImpl _value,
    $Res Function(_$LectureCompletionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LectureCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? lectureId = null,
    Object? completedAt = null,
    Object? watchedSeconds = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$LectureCompletionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        lectureId: null == lectureId
            ? _value.lectureId
            : lectureId // ignore: cast_nullable_to_non_nullable
                  as String,
        completedAt: null == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        watchedSeconds: freezed == watchedSeconds
            ? _value.watchedSeconds
            : watchedSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$LectureCompletionImpl implements _LectureCompletion {
  const _$LectureCompletionImpl({
    required this.id,
    required this.userId,
    required this.lectureId,
    required this.completedAt,
    this.watchedSeconds,
    this.createdAt,
  });

  factory _$LectureCompletionImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureCompletionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String lectureId;
  @override
  final DateTime completedAt;
  @override
  final int? watchedSeconds;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'LectureCompletion(id: $id, userId: $userId, lectureId: $lectureId, completedAt: $completedAt, watchedSeconds: $watchedSeconds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureCompletionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.lectureId, lectureId) ||
                other.lectureId == lectureId) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.watchedSeconds, watchedSeconds) ||
                other.watchedSeconds == watchedSeconds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    lectureId,
    completedAt,
    watchedSeconds,
    createdAt,
  );

  /// Create a copy of LectureCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LectureCompletionImplCopyWith<_$LectureCompletionImpl> get copyWith =>
      __$$LectureCompletionImplCopyWithImpl<_$LectureCompletionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureCompletionImplToJson(this);
  }
}

abstract class _LectureCompletion implements LectureCompletion {
  const factory _LectureCompletion({
    required final String id,
    required final String userId,
    required final String lectureId,
    required final DateTime completedAt,
    final int? watchedSeconds,
    final DateTime? createdAt,
  }) = _$LectureCompletionImpl;

  factory _LectureCompletion.fromJson(Map<String, dynamic> json) =
      _$LectureCompletionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get lectureId;
  @override
  DateTime get completedAt;
  @override
  int? get watchedSeconds;
  @override
  DateTime? get createdAt;

  /// Create a copy of LectureCompletion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LectureCompletionImplCopyWith<_$LectureCompletionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
