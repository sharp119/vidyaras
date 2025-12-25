// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LessonContent _$LessonContentFromJson(Map<String, dynamic> json) {
  return _LessonContent.fromJson(json);
}

/// @nodoc
mixin _$LessonContent {
  String get id => throw _privateConstructorUsedError;
  String get lessonId => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // video, text, pdf, etc.
  String get title => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;
  int? get orderIndex => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this LessonContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonContentCopyWith<LessonContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonContentCopyWith<$Res> {
  factory $LessonContentCopyWith(
    LessonContent value,
    $Res Function(LessonContent) then,
  ) = _$LessonContentCopyWithImpl<$Res, LessonContent>;
  @useResult
  $Res call({
    String id,
    String lessonId,
    String type,
    String title,
    String? url,
    int? duration,
    int? orderIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$LessonContentCopyWithImpl<$Res, $Val extends LessonContent>
    implements $LessonContentCopyWith<$Res> {
  _$LessonContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lessonId = null,
    Object? type = null,
    Object? title = null,
    Object? url = freezed,
    Object? duration = freezed,
    Object? orderIndex = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            lessonId: null == lessonId
                ? _value.lessonId
                : lessonId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
            orderIndex: freezed == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonContentImplCopyWith<$Res>
    implements $LessonContentCopyWith<$Res> {
  factory _$$LessonContentImplCopyWith(
    _$LessonContentImpl value,
    $Res Function(_$LessonContentImpl) then,
  ) = __$$LessonContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String lessonId,
    String type,
    String title,
    String? url,
    int? duration,
    int? orderIndex,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$LessonContentImplCopyWithImpl<$Res>
    extends _$LessonContentCopyWithImpl<$Res, _$LessonContentImpl>
    implements _$$LessonContentImplCopyWith<$Res> {
  __$$LessonContentImplCopyWithImpl(
    _$LessonContentImpl _value,
    $Res Function(_$LessonContentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lessonId = null,
    Object? type = null,
    Object? title = null,
    Object? url = freezed,
    Object? duration = freezed,
    Object? orderIndex = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$LessonContentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        lessonId: null == lessonId
            ? _value.lessonId
            : lessonId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
        orderIndex: freezed == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonContentImpl implements _LessonContent {
  const _$LessonContentImpl({
    required this.id,
    required this.lessonId,
    required this.type,
    required this.title,
    this.url,
    this.duration,
    this.orderIndex,
    this.createdAt,
    this.updatedAt,
  });

  factory _$LessonContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonContentImplFromJson(json);

  @override
  final String id;
  @override
  final String lessonId;
  @override
  final String type;
  // video, text, pdf, etc.
  @override
  final String title;
  @override
  final String? url;
  @override
  final int? duration;
  @override
  final int? orderIndex;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LessonContent(id: $id, lessonId: $lessonId, type: $type, title: $title, url: $url, duration: $duration, orderIndex: $orderIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    lessonId,
    type,
    title,
    url,
    duration,
    orderIndex,
    createdAt,
    updatedAt,
  );

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonContentImplCopyWith<_$LessonContentImpl> get copyWith =>
      __$$LessonContentImplCopyWithImpl<_$LessonContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonContentImplToJson(this);
  }
}

abstract class _LessonContent implements LessonContent {
  const factory _LessonContent({
    required final String id,
    required final String lessonId,
    required final String type,
    required final String title,
    final String? url,
    final int? duration,
    final int? orderIndex,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$LessonContentImpl;

  factory _LessonContent.fromJson(Map<String, dynamic> json) =
      _$LessonContentImpl.fromJson;

  @override
  String get id;
  @override
  String get lessonId;
  @override
  String get type; // video, text, pdf, etc.
  @override
  String get title;
  @override
  String? get url;
  @override
  int? get duration;
  @override
  int? get orderIndex;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of LessonContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonContentImplCopyWith<_$LessonContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
