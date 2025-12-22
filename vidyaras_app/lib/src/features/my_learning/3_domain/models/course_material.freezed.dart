// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseMaterial _$CourseMaterialFromJson(Map<String, dynamic> json) {
  return _CourseMaterial.fromJson(json);
}

/// @nodoc
mixin _$CourseMaterial {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // pdf, video, doc, image, other
  String get fileUrl => throw _privateConstructorUsedError;
  double? get fileSizeMb => throw _privateConstructorUsedError;
  String? get sectionId =>
      throw _privateConstructorUsedError; // matches SQL schema's section_id field
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CourseMaterial to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseMaterial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseMaterialCopyWith<CourseMaterial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseMaterialCopyWith<$Res> {
  factory $CourseMaterialCopyWith(
    CourseMaterial value,
    $Res Function(CourseMaterial) then,
  ) = _$CourseMaterialCopyWithImpl<$Res, CourseMaterial>;
  @useResult
  $Res call({
    String id,
    String courseId,
    String title,
    String type,
    String fileUrl,
    double? fileSizeMb,
    String? sectionId,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$CourseMaterialCopyWithImpl<$Res, $Val extends CourseMaterial>
    implements $CourseMaterialCopyWith<$Res> {
  _$CourseMaterialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseMaterial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? title = null,
    Object? type = null,
    Object? fileUrl = null,
    Object? fileSizeMb = freezed,
    Object? sectionId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrl: null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            fileSizeMb: freezed == fileSizeMb
                ? _value.fileSizeMb
                : fileSizeMb // ignore: cast_nullable_to_non_nullable
                      as double?,
            sectionId: freezed == sectionId
                ? _value.sectionId
                : sectionId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$CourseMaterialImplCopyWith<$Res>
    implements $CourseMaterialCopyWith<$Res> {
  factory _$$CourseMaterialImplCopyWith(
    _$CourseMaterialImpl value,
    $Res Function(_$CourseMaterialImpl) then,
  ) = __$$CourseMaterialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    String title,
    String type,
    String fileUrl,
    double? fileSizeMb,
    String? sectionId,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$CourseMaterialImplCopyWithImpl<$Res>
    extends _$CourseMaterialCopyWithImpl<$Res, _$CourseMaterialImpl>
    implements _$$CourseMaterialImplCopyWith<$Res> {
  __$$CourseMaterialImplCopyWithImpl(
    _$CourseMaterialImpl _value,
    $Res Function(_$CourseMaterialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseMaterial
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? title = null,
    Object? type = null,
    Object? fileUrl = null,
    Object? fileSizeMb = freezed,
    Object? sectionId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CourseMaterialImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        fileUrl: null == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        fileSizeMb: freezed == fileSizeMb
            ? _value.fileSizeMb
            : fileSizeMb // ignore: cast_nullable_to_non_nullable
                  as double?,
        sectionId: freezed == sectionId
            ? _value.sectionId
            : sectionId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$CourseMaterialImpl implements _CourseMaterial {
  const _$CourseMaterialImpl({
    required this.id,
    required this.courseId,
    required this.title,
    this.type = 'pdf',
    required this.fileUrl,
    this.fileSizeMb,
    this.sectionId,
    this.createdAt,
  });

  factory _$CourseMaterialImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseMaterialImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String title;
  @override
  @JsonKey()
  final String type;
  // pdf, video, doc, image, other
  @override
  final String fileUrl;
  @override
  final double? fileSizeMb;
  @override
  final String? sectionId;
  // matches SQL schema's section_id field
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CourseMaterial(id: $id, courseId: $courseId, title: $title, type: $type, fileUrl: $fileUrl, fileSizeMb: $fileSizeMb, sectionId: $sectionId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseMaterialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileSizeMb, fileSizeMb) ||
                other.fileSizeMb == fileSizeMb) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseId,
    title,
    type,
    fileUrl,
    fileSizeMb,
    sectionId,
    createdAt,
  );

  /// Create a copy of CourseMaterial
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseMaterialImplCopyWith<_$CourseMaterialImpl> get copyWith =>
      __$$CourseMaterialImplCopyWithImpl<_$CourseMaterialImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseMaterialImplToJson(this);
  }
}

abstract class _CourseMaterial implements CourseMaterial {
  const factory _CourseMaterial({
    required final String id,
    required final String courseId,
    required final String title,
    final String type,
    required final String fileUrl,
    final double? fileSizeMb,
    final String? sectionId,
    final DateTime? createdAt,
  }) = _$CourseMaterialImpl;

  factory _CourseMaterial.fromJson(Map<String, dynamic> json) =
      _$CourseMaterialImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get title;
  @override
  String get type; // pdf, video, doc, image, other
  @override
  String get fileUrl;
  @override
  double? get fileSizeMb;
  @override
  String? get sectionId; // matches SQL schema's section_id field
  @override
  DateTime? get createdAt;

  /// Create a copy of CourseMaterial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseMaterialImplCopyWith<_$CourseMaterialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
