// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lecture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return _Lecture.fromJson(json);
}

/// @nodoc
mixin _$Lecture {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get moduleId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // video, live, reading, practice
  int? get durationMinutes => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get requiredQuizId => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int? get watchedSeconds => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Lecture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LectureCopyWith<Lecture> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureCopyWith<$Res> {
  factory $LectureCopyWith(Lecture value, $Res Function(Lecture) then) =
      _$LectureCopyWithImpl<$Res, Lecture>;
  @useResult
  $Res call({
    String id,
    String courseId,
    String moduleId,
    String title,
    String? description,
    int orderIndex,
    String type,
    int? durationMinutes,
    String? videoUrl,
    String? requiredQuizId,
    bool isCompleted,
    bool isLocked,
    DateTime? completedAt,
    int? watchedSeconds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$LectureCopyWithImpl<$Res, $Val extends Lecture>
    implements $LectureCopyWith<$Res> {
  _$LectureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? moduleId = null,
    Object? title = null,
    Object? description = freezed,
    Object? orderIndex = null,
    Object? type = null,
    Object? durationMinutes = freezed,
    Object? videoUrl = freezed,
    Object? requiredQuizId = freezed,
    Object? isCompleted = null,
    Object? isLocked = null,
    Object? completedAt = freezed,
    Object? watchedSeconds = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            moduleId: null == moduleId
                ? _value.moduleId
                : moduleId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            requiredQuizId: freezed == requiredQuizId
                ? _value.requiredQuizId
                : requiredQuizId // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLocked: null == isLocked
                ? _value.isLocked
                : isLocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            watchedSeconds: freezed == watchedSeconds
                ? _value.watchedSeconds
                : watchedSeconds // ignore: cast_nullable_to_non_nullable
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
abstract class _$$LectureImplCopyWith<$Res> implements $LectureCopyWith<$Res> {
  factory _$$LectureImplCopyWith(
    _$LectureImpl value,
    $Res Function(_$LectureImpl) then,
  ) = __$$LectureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    String moduleId,
    String title,
    String? description,
    int orderIndex,
    String type,
    int? durationMinutes,
    String? videoUrl,
    String? requiredQuizId,
    bool isCompleted,
    bool isLocked,
    DateTime? completedAt,
    int? watchedSeconds,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$LectureImplCopyWithImpl<$Res>
    extends _$LectureCopyWithImpl<$Res, _$LectureImpl>
    implements _$$LectureImplCopyWith<$Res> {
  __$$LectureImplCopyWithImpl(
    _$LectureImpl _value,
    $Res Function(_$LectureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? moduleId = null,
    Object? title = null,
    Object? description = freezed,
    Object? orderIndex = null,
    Object? type = null,
    Object? durationMinutes = freezed,
    Object? videoUrl = freezed,
    Object? requiredQuizId = freezed,
    Object? isCompleted = null,
    Object? isLocked = null,
    Object? completedAt = freezed,
    Object? watchedSeconds = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$LectureImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        moduleId: null == moduleId
            ? _value.moduleId
            : moduleId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        requiredQuizId: freezed == requiredQuizId
            ? _value.requiredQuizId
            : requiredQuizId // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLocked: null == isLocked
            ? _value.isLocked
            : isLocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        watchedSeconds: freezed == watchedSeconds
            ? _value.watchedSeconds
            : watchedSeconds // ignore: cast_nullable_to_non_nullable
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
class _$LectureImpl implements _Lecture {
  const _$LectureImpl({
    required this.id,
    required this.courseId,
    required this.moduleId,
    required this.title,
    this.description,
    required this.orderIndex,
    this.type = 'video',
    this.durationMinutes,
    this.videoUrl,
    this.requiredQuizId,
    this.isCompleted = false,
    this.isLocked = false,
    this.completedAt,
    this.watchedSeconds,
    this.createdAt,
    this.updatedAt,
  });

  factory _$LectureImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String moduleId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int orderIndex;
  @override
  @JsonKey()
  final String type;
  // video, live, reading, practice
  @override
  final int? durationMinutes;
  @override
  final String? videoUrl;
  @override
  final String? requiredQuizId;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool isLocked;
  @override
  final DateTime? completedAt;
  @override
  final int? watchedSeconds;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Lecture(id: $id, courseId: $courseId, moduleId: $moduleId, title: $title, description: $description, orderIndex: $orderIndex, type: $type, durationMinutes: $durationMinutes, videoUrl: $videoUrl, requiredQuizId: $requiredQuizId, isCompleted: $isCompleted, isLocked: $isLocked, completedAt: $completedAt, watchedSeconds: $watchedSeconds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.requiredQuizId, requiredQuizId) ||
                other.requiredQuizId == requiredQuizId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.watchedSeconds, watchedSeconds) ||
                other.watchedSeconds == watchedSeconds) &&
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
    courseId,
    moduleId,
    title,
    description,
    orderIndex,
    type,
    durationMinutes,
    videoUrl,
    requiredQuizId,
    isCompleted,
    isLocked,
    completedAt,
    watchedSeconds,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LectureImplCopyWith<_$LectureImpl> get copyWith =>
      __$$LectureImplCopyWithImpl<_$LectureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureImplToJson(this);
  }
}

abstract class _Lecture implements Lecture {
  const factory _Lecture({
    required final String id,
    required final String courseId,
    required final String moduleId,
    required final String title,
    final String? description,
    required final int orderIndex,
    final String type,
    final int? durationMinutes,
    final String? videoUrl,
    final String? requiredQuizId,
    final bool isCompleted,
    final bool isLocked,
    final DateTime? completedAt,
    final int? watchedSeconds,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$LectureImpl;

  factory _Lecture.fromJson(Map<String, dynamic> json) = _$LectureImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get moduleId;
  @override
  String get title;
  @override
  String? get description;
  @override
  int get orderIndex;
  @override
  String get type; // video, live, reading, practice
  @override
  int? get durationMinutes;
  @override
  String? get videoUrl;
  @override
  String? get requiredQuizId;
  @override
  bool get isCompleted;
  @override
  bool get isLocked;
  @override
  DateTime? get completedAt;
  @override
  int? get watchedSeconds;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Lecture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LectureImplCopyWith<_$LectureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
