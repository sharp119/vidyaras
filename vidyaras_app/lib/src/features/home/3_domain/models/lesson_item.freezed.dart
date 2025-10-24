// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LessonItem _$LessonItemFromJson(Map<String, dynamic> json) {
  return _LessonItem.fromJson(json);
}

/// @nodoc
mixin _$LessonItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this LessonItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonItemCopyWith<LessonItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonItemCopyWith<$Res> {
  factory $LessonItemCopyWith(
    LessonItem value,
    $Res Function(LessonItem) then,
  ) = _$LessonItemCopyWithImpl<$Res, LessonItem>;
  @useResult
  $Res call({
    String id,
    String title,
    int durationMinutes,
    bool isLocked,
    bool isCompleted,
    String? description,
  });
}

/// @nodoc
class _$LessonItemCopyWithImpl<$Res, $Val extends LessonItem>
    implements $LessonItemCopyWith<$Res> {
  _$LessonItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? durationMinutes = null,
    Object? isLocked = null,
    Object? isCompleted = null,
    Object? description = freezed,
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
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            isLocked: null == isLocked
                ? _value.isLocked
                : isLocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LessonItemImplCopyWith<$Res>
    implements $LessonItemCopyWith<$Res> {
  factory _$$LessonItemImplCopyWith(
    _$LessonItemImpl value,
    $Res Function(_$LessonItemImpl) then,
  ) = __$$LessonItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    int durationMinutes,
    bool isLocked,
    bool isCompleted,
    String? description,
  });
}

/// @nodoc
class __$$LessonItemImplCopyWithImpl<$Res>
    extends _$LessonItemCopyWithImpl<$Res, _$LessonItemImpl>
    implements _$$LessonItemImplCopyWith<$Res> {
  __$$LessonItemImplCopyWithImpl(
    _$LessonItemImpl _value,
    $Res Function(_$LessonItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LessonItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? durationMinutes = null,
    Object? isLocked = null,
    Object? isCompleted = null,
    Object? description = freezed,
  }) {
    return _then(
      _$LessonItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        isLocked: null == isLocked
            ? _value.isLocked
            : isLocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonItemImpl implements _LessonItem {
  const _$LessonItemImpl({
    required this.id,
    required this.title,
    required this.durationMinutes,
    this.isLocked = false,
    this.isCompleted = false,
    this.description,
  });

  factory _$LessonItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final int durationMinutes;
  @override
  @JsonKey()
  final bool isLocked;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  final String? description;

  @override
  String toString() {
    return 'LessonItem(id: $id, title: $title, durationMinutes: $durationMinutes, isLocked: $isLocked, isCompleted: $isCompleted, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    durationMinutes,
    isLocked,
    isCompleted,
    description,
  );

  /// Create a copy of LessonItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonItemImplCopyWith<_$LessonItemImpl> get copyWith =>
      __$$LessonItemImplCopyWithImpl<_$LessonItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonItemImplToJson(this);
  }
}

abstract class _LessonItem implements LessonItem {
  const factory _LessonItem({
    required final String id,
    required final String title,
    required final int durationMinutes,
    final bool isLocked,
    final bool isCompleted,
    final String? description,
  }) = _$LessonItemImpl;

  factory _LessonItem.fromJson(Map<String, dynamic> json) =
      _$LessonItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get durationMinutes;
  @override
  bool get isLocked;
  @override
  bool get isCompleted;
  @override
  String? get description;

  /// Create a copy of LessonItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonItemImplCopyWith<_$LessonItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
