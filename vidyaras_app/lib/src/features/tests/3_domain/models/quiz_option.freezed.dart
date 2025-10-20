// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizOption _$QuizOptionFromJson(Map<String, dynamic> json) {
  return _QuizOption.fromJson(json);
}

/// @nodoc
mixin _$QuizOption {
  int get id => throw _privateConstructorUsedError; // 0-based index
  ContentData get data => throw _privateConstructorUsedError;

  /// Serializes this QuizOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizOptionCopyWith<QuizOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizOptionCopyWith<$Res> {
  factory $QuizOptionCopyWith(
    QuizOption value,
    $Res Function(QuizOption) then,
  ) = _$QuizOptionCopyWithImpl<$Res, QuizOption>;
  @useResult
  $Res call({int id, ContentData data});

  $ContentDataCopyWith<$Res> get data;
}

/// @nodoc
class _$QuizOptionCopyWithImpl<$Res, $Val extends QuizOption>
    implements $QuizOptionCopyWith<$Res> {
  _$QuizOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? data = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as ContentData,
          )
          as $Val,
    );
  }

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentDataCopyWith<$Res> get data {
    return $ContentDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuizOptionImplCopyWith<$Res>
    implements $QuizOptionCopyWith<$Res> {
  factory _$$QuizOptionImplCopyWith(
    _$QuizOptionImpl value,
    $Res Function(_$QuizOptionImpl) then,
  ) = __$$QuizOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, ContentData data});

  @override
  $ContentDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$QuizOptionImplCopyWithImpl<$Res>
    extends _$QuizOptionCopyWithImpl<$Res, _$QuizOptionImpl>
    implements _$$QuizOptionImplCopyWith<$Res> {
  __$$QuizOptionImplCopyWithImpl(
    _$QuizOptionImpl _value,
    $Res Function(_$QuizOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? data = null}) {
    return _then(
      _$QuizOptionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        data: null == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as ContentData,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizOptionImpl implements _QuizOption {
  const _$QuizOptionImpl({required this.id, required this.data});

  factory _$QuizOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizOptionImplFromJson(json);

  @override
  final int id;
  // 0-based index
  @override
  final ContentData data;

  @override
  String toString() {
    return 'QuizOption(id: $id, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizOptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, data);

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizOptionImplCopyWith<_$QuizOptionImpl> get copyWith =>
      __$$QuizOptionImplCopyWithImpl<_$QuizOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizOptionImplToJson(this);
  }
}

abstract class _QuizOption implements QuizOption {
  const factory _QuizOption({
    required final int id,
    required final ContentData data,
  }) = _$QuizOptionImpl;

  factory _QuizOption.fromJson(Map<String, dynamic> json) =
      _$QuizOptionImpl.fromJson;

  @override
  int get id; // 0-based index
  @override
  ContentData get data;

  /// Create a copy of QuizOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizOptionImplCopyWith<_$QuizOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
