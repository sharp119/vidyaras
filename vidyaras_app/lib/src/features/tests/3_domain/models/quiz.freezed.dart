// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  return _Quiz.fromJson(json);
}

/// @nodoc
mixin _$Quiz {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get courseId =>
      throw _privateConstructorUsedError; // null means standalone/public quiz
  int get fullMarks => throw _privateConstructorUsedError;
  int get timeAllottedMinutes => throw _privateConstructorUsedError;
  bool get isPublished =>
      throw _privateConstructorUsedError; // Toggle to show/hide quiz
  bool get isPublic =>
      throw _privateConstructorUsedError; // If true, free for all; if false, for paid users
  String? get difficultyLevel =>
      throw _privateConstructorUsedError; // 'beginner', 'intermediate', 'advanced'
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizCopyWith<Quiz> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizCopyWith<$Res> {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) then) =
      _$QuizCopyWithImpl<$Res, Quiz>;
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? courseId,
    int fullMarks,
    int timeAllottedMinutes,
    bool isPublished,
    bool isPublic,
    String? difficultyLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$QuizCopyWithImpl<$Res, $Val extends Quiz>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? courseId = freezed,
    Object? fullMarks = null,
    Object? timeAllottedMinutes = null,
    Object? isPublished = null,
    Object? isPublic = null,
    Object? difficultyLevel = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseId: freezed == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullMarks: null == fullMarks
                ? _value.fullMarks
                : fullMarks // ignore: cast_nullable_to_non_nullable
                      as int,
            timeAllottedMinutes: null == timeAllottedMinutes
                ? _value.timeAllottedMinutes
                : timeAllottedMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            isPublished: null == isPublished
                ? _value.isPublished
                : isPublished // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPublic: null == isPublic
                ? _value.isPublic
                : isPublic // ignore: cast_nullable_to_non_nullable
                      as bool,
            difficultyLevel: freezed == difficultyLevel
                ? _value.difficultyLevel
                : difficultyLevel // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$QuizImplCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$$QuizImplCopyWith(
    _$QuizImpl value,
    $Res Function(_$QuizImpl) then,
  ) = __$$QuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? description,
    String? courseId,
    int fullMarks,
    int timeAllottedMinutes,
    bool isPublished,
    bool isPublic,
    String? difficultyLevel,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$QuizImplCopyWithImpl<$Res>
    extends _$QuizCopyWithImpl<$Res, _$QuizImpl>
    implements _$$QuizImplCopyWith<$Res> {
  __$$QuizImplCopyWithImpl(_$QuizImpl _value, $Res Function(_$QuizImpl) _then)
    : super(_value, _then);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? courseId = freezed,
    Object? fullMarks = null,
    Object? timeAllottedMinutes = null,
    Object? isPublished = null,
    Object? isPublic = null,
    Object? difficultyLevel = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$QuizImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseId: freezed == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullMarks: null == fullMarks
            ? _value.fullMarks
            : fullMarks // ignore: cast_nullable_to_non_nullable
                  as int,
        timeAllottedMinutes: null == timeAllottedMinutes
            ? _value.timeAllottedMinutes
            : timeAllottedMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        isPublished: null == isPublished
            ? _value.isPublished
            : isPublished // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPublic: null == isPublic
            ? _value.isPublic
            : isPublic // ignore: cast_nullable_to_non_nullable
                  as bool,
        difficultyLevel: freezed == difficultyLevel
            ? _value.difficultyLevel
            : difficultyLevel // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$QuizImpl implements _Quiz {
  const _$QuizImpl({
    required this.id,
    required this.title,
    this.description,
    this.courseId,
    this.fullMarks = 100,
    this.timeAllottedMinutes = 30,
    this.isPublished = false,
    this.isPublic = true,
    this.difficultyLevel,
    this.createdAt,
    this.updatedAt,
  });

  factory _$QuizImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? courseId;
  // null means standalone/public quiz
  @override
  @JsonKey()
  final int fullMarks;
  @override
  @JsonKey()
  final int timeAllottedMinutes;
  @override
  @JsonKey()
  final bool isPublished;
  // Toggle to show/hide quiz
  @override
  @JsonKey()
  final bool isPublic;
  // If true, free for all; if false, for paid users
  @override
  final String? difficultyLevel;
  // 'beginner', 'intermediate', 'advanced'
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Quiz(id: $id, title: $title, description: $description, courseId: $courseId, fullMarks: $fullMarks, timeAllottedMinutes: $timeAllottedMinutes, isPublished: $isPublished, isPublic: $isPublic, difficultyLevel: $difficultyLevel, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.fullMarks, fullMarks) ||
                other.fullMarks == fullMarks) &&
            (identical(other.timeAllottedMinutes, timeAllottedMinutes) ||
                other.timeAllottedMinutes == timeAllottedMinutes) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
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
    title,
    description,
    courseId,
    fullMarks,
    timeAllottedMinutes,
    isPublished,
    isPublic,
    difficultyLevel,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizImplCopyWith<_$QuizImpl> get copyWith =>
      __$$QuizImplCopyWithImpl<_$QuizImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizImplToJson(this);
  }
}

abstract class _Quiz implements Quiz {
  const factory _Quiz({
    required final String id,
    required final String title,
    final String? description,
    final String? courseId,
    final int fullMarks,
    final int timeAllottedMinutes,
    final bool isPublished,
    final bool isPublic,
    final String? difficultyLevel,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$QuizImpl;

  factory _Quiz.fromJson(Map<String, dynamic> json) = _$QuizImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get courseId; // null means standalone/public quiz
  @override
  int get fullMarks;
  @override
  int get timeAllottedMinutes;
  @override
  bool get isPublished; // Toggle to show/hide quiz
  @override
  bool get isPublic; // If true, free for all; if false, for paid users
  @override
  String? get difficultyLevel; // 'beginner', 'intermediate', 'advanced'
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizImplCopyWith<_$QuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
