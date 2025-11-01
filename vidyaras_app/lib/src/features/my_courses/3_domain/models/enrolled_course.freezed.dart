// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enrolled_course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

EnrolledCourse _$EnrolledCourseFromJson(Map<String, dynamic> json) {
  return _EnrolledCourse.fromJson(json);
}

/// @nodoc
mixin _$EnrolledCourse {
  String get enrollmentId => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get instructor => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;
  int get totalLectures => throw _privateConstructorUsedError;
  int get completedLectures => throw _privateConstructorUsedError;
  double get progressPercent => throw _privateConstructorUsedError;
  LectureProgressSummary? get nextLecture => throw _privateConstructorUsedError;
  DateTime? get lastAccessedAt => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  /// Serializes this EnrolledCourse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnrolledCourseCopyWith<EnrolledCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnrolledCourseCopyWith<$Res> {
  factory $EnrolledCourseCopyWith(
    EnrolledCourse value,
    $Res Function(EnrolledCourse) then,
  ) = _$EnrolledCourseCopyWithImpl<$Res, EnrolledCourse>;
  @useResult
  $Res call({
    String enrollmentId,
    String courseId,
    String title,
    String instructor,
    String? thumbnailUrl,
    String? duration,
    bool isLive,
    int totalLectures,
    int completedLectures,
    double progressPercent,
    LectureProgressSummary? nextLecture,
    DateTime? lastAccessedAt,
    bool isCompleted,
  });

  $LectureProgressSummaryCopyWith<$Res>? get nextLecture;
}

/// @nodoc
class _$EnrolledCourseCopyWithImpl<$Res, $Val extends EnrolledCourse>
    implements $EnrolledCourseCopyWith<$Res> {
  _$EnrolledCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enrollmentId = null,
    Object? courseId = null,
    Object? title = null,
    Object? instructor = null,
    Object? thumbnailUrl = freezed,
    Object? duration = freezed,
    Object? isLive = null,
    Object? totalLectures = null,
    Object? completedLectures = null,
    Object? progressPercent = null,
    Object? nextLecture = freezed,
    Object? lastAccessedAt = freezed,
    Object? isCompleted = null,
  }) {
    return _then(
      _value.copyWith(
            enrollmentId: null == enrollmentId
                ? _value.enrollmentId
                : enrollmentId // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            instructor: null == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLive: null == isLive
                ? _value.isLive
                : isLive // ignore: cast_nullable_to_non_nullable
                      as bool,
            totalLectures: null == totalLectures
                ? _value.totalLectures
                : totalLectures // ignore: cast_nullable_to_non_nullable
                      as int,
            completedLectures: null == completedLectures
                ? _value.completedLectures
                : completedLectures // ignore: cast_nullable_to_non_nullable
                      as int,
            progressPercent: null == progressPercent
                ? _value.progressPercent
                : progressPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            nextLecture: freezed == nextLecture
                ? _value.nextLecture
                : nextLecture // ignore: cast_nullable_to_non_nullable
                      as LectureProgressSummary?,
            lastAccessedAt: freezed == lastAccessedAt
                ? _value.lastAccessedAt
                : lastAccessedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isCompleted: null == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LectureProgressSummaryCopyWith<$Res>? get nextLecture {
    if (_value.nextLecture == null) {
      return null;
    }

    return $LectureProgressSummaryCopyWith<$Res>(_value.nextLecture!, (value) {
      return _then(_value.copyWith(nextLecture: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EnrolledCourseImplCopyWith<$Res>
    implements $EnrolledCourseCopyWith<$Res> {
  factory _$$EnrolledCourseImplCopyWith(
    _$EnrolledCourseImpl value,
    $Res Function(_$EnrolledCourseImpl) then,
  ) = __$$EnrolledCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String enrollmentId,
    String courseId,
    String title,
    String instructor,
    String? thumbnailUrl,
    String? duration,
    bool isLive,
    int totalLectures,
    int completedLectures,
    double progressPercent,
    LectureProgressSummary? nextLecture,
    DateTime? lastAccessedAt,
    bool isCompleted,
  });

  @override
  $LectureProgressSummaryCopyWith<$Res>? get nextLecture;
}

/// @nodoc
class __$$EnrolledCourseImplCopyWithImpl<$Res>
    extends _$EnrolledCourseCopyWithImpl<$Res, _$EnrolledCourseImpl>
    implements _$$EnrolledCourseImplCopyWith<$Res> {
  __$$EnrolledCourseImplCopyWithImpl(
    _$EnrolledCourseImpl _value,
    $Res Function(_$EnrolledCourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enrollmentId = null,
    Object? courseId = null,
    Object? title = null,
    Object? instructor = null,
    Object? thumbnailUrl = freezed,
    Object? duration = freezed,
    Object? isLive = null,
    Object? totalLectures = null,
    Object? completedLectures = null,
    Object? progressPercent = null,
    Object? nextLecture = freezed,
    Object? lastAccessedAt = freezed,
    Object? isCompleted = null,
  }) {
    return _then(
      _$EnrolledCourseImpl(
        enrollmentId: null == enrollmentId
            ? _value.enrollmentId
            : enrollmentId // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        instructor: null == instructor
            ? _value.instructor
            : instructor // ignore: cast_nullable_to_non_nullable
                  as String,
        thumbnailUrl: freezed == thumbnailUrl
            ? _value.thumbnailUrl
            : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLive: null == isLive
            ? _value.isLive
            : isLive // ignore: cast_nullable_to_non_nullable
                  as bool,
        totalLectures: null == totalLectures
            ? _value.totalLectures
            : totalLectures // ignore: cast_nullable_to_non_nullable
                  as int,
        completedLectures: null == completedLectures
            ? _value.completedLectures
            : completedLectures // ignore: cast_nullable_to_non_nullable
                  as int,
        progressPercent: null == progressPercent
            ? _value.progressPercent
            : progressPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        nextLecture: freezed == nextLecture
            ? _value.nextLecture
            : nextLecture // ignore: cast_nullable_to_non_nullable
                  as LectureProgressSummary?,
        lastAccessedAt: freezed == lastAccessedAt
            ? _value.lastAccessedAt
            : lastAccessedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isCompleted: null == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EnrolledCourseImpl implements _EnrolledCourse {
  const _$EnrolledCourseImpl({
    required this.enrollmentId,
    required this.courseId,
    required this.title,
    required this.instructor,
    this.thumbnailUrl,
    this.duration,
    this.isLive = false,
    this.totalLectures = 0,
    this.completedLectures = 0,
    this.progressPercent = 0.0,
    this.nextLecture,
    this.lastAccessedAt,
    this.isCompleted = false,
  });

  factory _$EnrolledCourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnrolledCourseImplFromJson(json);

  @override
  final String enrollmentId;
  @override
  final String courseId;
  @override
  final String title;
  @override
  final String instructor;
  @override
  final String? thumbnailUrl;
  @override
  final String? duration;
  @override
  @JsonKey()
  final bool isLive;
  @override
  @JsonKey()
  final int totalLectures;
  @override
  @JsonKey()
  final int completedLectures;
  @override
  @JsonKey()
  final double progressPercent;
  @override
  final LectureProgressSummary? nextLecture;
  @override
  final DateTime? lastAccessedAt;
  @override
  @JsonKey()
  final bool isCompleted;

  @override
  String toString() {
    return 'EnrolledCourse(enrollmentId: $enrollmentId, courseId: $courseId, title: $title, instructor: $instructor, thumbnailUrl: $thumbnailUrl, duration: $duration, isLive: $isLive, totalLectures: $totalLectures, completedLectures: $completedLectures, progressPercent: $progressPercent, nextLecture: $nextLecture, lastAccessedAt: $lastAccessedAt, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCourseImpl &&
            (identical(other.enrollmentId, enrollmentId) ||
                other.enrollmentId == enrollmentId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.totalLectures, totalLectures) ||
                other.totalLectures == totalLectures) &&
            (identical(other.completedLectures, completedLectures) ||
                other.completedLectures == completedLectures) &&
            (identical(other.progressPercent, progressPercent) ||
                other.progressPercent == progressPercent) &&
            (identical(other.nextLecture, nextLecture) ||
                other.nextLecture == nextLecture) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    enrollmentId,
    courseId,
    title,
    instructor,
    thumbnailUrl,
    duration,
    isLive,
    totalLectures,
    completedLectures,
    progressPercent,
    nextLecture,
    lastAccessedAt,
    isCompleted,
  );

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrolledCourseImplCopyWith<_$EnrolledCourseImpl> get copyWith =>
      __$$EnrolledCourseImplCopyWithImpl<_$EnrolledCourseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EnrolledCourseImplToJson(this);
  }
}

abstract class _EnrolledCourse implements EnrolledCourse {
  const factory _EnrolledCourse({
    required final String enrollmentId,
    required final String courseId,
    required final String title,
    required final String instructor,
    final String? thumbnailUrl,
    final String? duration,
    final bool isLive,
    final int totalLectures,
    final int completedLectures,
    final double progressPercent,
    final LectureProgressSummary? nextLecture,
    final DateTime? lastAccessedAt,
    final bool isCompleted,
  }) = _$EnrolledCourseImpl;

  factory _EnrolledCourse.fromJson(Map<String, dynamic> json) =
      _$EnrolledCourseImpl.fromJson;

  @override
  String get enrollmentId;
  @override
  String get courseId;
  @override
  String get title;
  @override
  String get instructor;
  @override
  String? get thumbnailUrl;
  @override
  String? get duration;
  @override
  bool get isLive;
  @override
  int get totalLectures;
  @override
  int get completedLectures;
  @override
  double get progressPercent;
  @override
  LectureProgressSummary? get nextLecture;
  @override
  DateTime? get lastAccessedAt;
  @override
  bool get isCompleted;

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCourseImplCopyWith<_$EnrolledCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LectureProgressSummary _$LectureProgressSummaryFromJson(
  Map<String, dynamic> json,
) {
  return _LectureProgressSummary.fromJson(json);
}

/// @nodoc
mixin _$LectureProgressSummary {
  String get lectureId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get sectionTitle => throw _privateConstructorUsedError;
  bool get isLocked => throw _privateConstructorUsedError;
  QuizRequirement? get requiredQuiz => throw _privateConstructorUsedError;

  /// Serializes this LectureProgressSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LectureProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LectureProgressSummaryCopyWith<LectureProgressSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureProgressSummaryCopyWith<$Res> {
  factory $LectureProgressSummaryCopyWith(
    LectureProgressSummary value,
    $Res Function(LectureProgressSummary) then,
  ) = _$LectureProgressSummaryCopyWithImpl<$Res, LectureProgressSummary>;
  @useResult
  $Res call({
    String lectureId,
    String title,
    String sectionTitle,
    bool isLocked,
    QuizRequirement? requiredQuiz,
  });

  $QuizRequirementCopyWith<$Res>? get requiredQuiz;
}

/// @nodoc
class _$LectureProgressSummaryCopyWithImpl<
  $Res,
  $Val extends LectureProgressSummary
>
    implements $LectureProgressSummaryCopyWith<$Res> {
  _$LectureProgressSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LectureProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lectureId = null,
    Object? title = null,
    Object? sectionTitle = null,
    Object? isLocked = null,
    Object? requiredQuiz = freezed,
  }) {
    return _then(
      _value.copyWith(
            lectureId: null == lectureId
                ? _value.lectureId
                : lectureId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            sectionTitle: null == sectionTitle
                ? _value.sectionTitle
                : sectionTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            isLocked: null == isLocked
                ? _value.isLocked
                : isLocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            requiredQuiz: freezed == requiredQuiz
                ? _value.requiredQuiz
                : requiredQuiz // ignore: cast_nullable_to_non_nullable
                      as QuizRequirement?,
          )
          as $Val,
    );
  }

  /// Create a copy of LectureProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuizRequirementCopyWith<$Res>? get requiredQuiz {
    if (_value.requiredQuiz == null) {
      return null;
    }

    return $QuizRequirementCopyWith<$Res>(_value.requiredQuiz!, (value) {
      return _then(_value.copyWith(requiredQuiz: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LectureProgressSummaryImplCopyWith<$Res>
    implements $LectureProgressSummaryCopyWith<$Res> {
  factory _$$LectureProgressSummaryImplCopyWith(
    _$LectureProgressSummaryImpl value,
    $Res Function(_$LectureProgressSummaryImpl) then,
  ) = __$$LectureProgressSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String lectureId,
    String title,
    String sectionTitle,
    bool isLocked,
    QuizRequirement? requiredQuiz,
  });

  @override
  $QuizRequirementCopyWith<$Res>? get requiredQuiz;
}

/// @nodoc
class __$$LectureProgressSummaryImplCopyWithImpl<$Res>
    extends
        _$LectureProgressSummaryCopyWithImpl<$Res, _$LectureProgressSummaryImpl>
    implements _$$LectureProgressSummaryImplCopyWith<$Res> {
  __$$LectureProgressSummaryImplCopyWithImpl(
    _$LectureProgressSummaryImpl _value,
    $Res Function(_$LectureProgressSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LectureProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lectureId = null,
    Object? title = null,
    Object? sectionTitle = null,
    Object? isLocked = null,
    Object? requiredQuiz = freezed,
  }) {
    return _then(
      _$LectureProgressSummaryImpl(
        lectureId: null == lectureId
            ? _value.lectureId
            : lectureId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        sectionTitle: null == sectionTitle
            ? _value.sectionTitle
            : sectionTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        isLocked: null == isLocked
            ? _value.isLocked
            : isLocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        requiredQuiz: freezed == requiredQuiz
            ? _value.requiredQuiz
            : requiredQuiz // ignore: cast_nullable_to_non_nullable
                  as QuizRequirement?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LectureProgressSummaryImpl implements _LectureProgressSummary {
  const _$LectureProgressSummaryImpl({
    required this.lectureId,
    required this.title,
    required this.sectionTitle,
    this.isLocked = false,
    this.requiredQuiz,
  });

  factory _$LectureProgressSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureProgressSummaryImplFromJson(json);

  @override
  final String lectureId;
  @override
  final String title;
  @override
  final String sectionTitle;
  @override
  @JsonKey()
  final bool isLocked;
  @override
  final QuizRequirement? requiredQuiz;

  @override
  String toString() {
    return 'LectureProgressSummary(lectureId: $lectureId, title: $title, sectionTitle: $sectionTitle, isLocked: $isLocked, requiredQuiz: $requiredQuiz)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureProgressSummaryImpl &&
            (identical(other.lectureId, lectureId) ||
                other.lectureId == lectureId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sectionTitle, sectionTitle) ||
                other.sectionTitle == sectionTitle) &&
            (identical(other.isLocked, isLocked) ||
                other.isLocked == isLocked) &&
            (identical(other.requiredQuiz, requiredQuiz) ||
                other.requiredQuiz == requiredQuiz));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    lectureId,
    title,
    sectionTitle,
    isLocked,
    requiredQuiz,
  );

  /// Create a copy of LectureProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LectureProgressSummaryImplCopyWith<_$LectureProgressSummaryImpl>
  get copyWith =>
      __$$LectureProgressSummaryImplCopyWithImpl<_$LectureProgressSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureProgressSummaryImplToJson(this);
  }
}

abstract class _LectureProgressSummary implements LectureProgressSummary {
  const factory _LectureProgressSummary({
    required final String lectureId,
    required final String title,
    required final String sectionTitle,
    final bool isLocked,
    final QuizRequirement? requiredQuiz,
  }) = _$LectureProgressSummaryImpl;

  factory _LectureProgressSummary.fromJson(Map<String, dynamic> json) =
      _$LectureProgressSummaryImpl.fromJson;

  @override
  String get lectureId;
  @override
  String get title;
  @override
  String get sectionTitle;
  @override
  bool get isLocked;
  @override
  QuizRequirement? get requiredQuiz;

  /// Create a copy of LectureProgressSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LectureProgressSummaryImplCopyWith<_$LectureProgressSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

QuizRequirement _$QuizRequirementFromJson(Map<String, dynamic> json) {
  return _QuizRequirement.fromJson(json);
}

/// @nodoc
mixin _$QuizRequirement {
  String get quizId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get passingScore => throw _privateConstructorUsedError;

  /// Serializes this QuizRequirement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizRequirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizRequirementCopyWith<QuizRequirement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizRequirementCopyWith<$Res> {
  factory $QuizRequirementCopyWith(
    QuizRequirement value,
    $Res Function(QuizRequirement) then,
  ) = _$QuizRequirementCopyWithImpl<$Res, QuizRequirement>;
  @useResult
  $Res call({String quizId, String title, int passingScore});
}

/// @nodoc
class _$QuizRequirementCopyWithImpl<$Res, $Val extends QuizRequirement>
    implements $QuizRequirementCopyWith<$Res> {
  _$QuizRequirementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizRequirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizId = null,
    Object? title = null,
    Object? passingScore = null,
  }) {
    return _then(
      _value.copyWith(
            quizId: null == quizId
                ? _value.quizId
                : quizId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            passingScore: null == passingScore
                ? _value.passingScore
                : passingScore // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizRequirementImplCopyWith<$Res>
    implements $QuizRequirementCopyWith<$Res> {
  factory _$$QuizRequirementImplCopyWith(
    _$QuizRequirementImpl value,
    $Res Function(_$QuizRequirementImpl) then,
  ) = __$$QuizRequirementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String quizId, String title, int passingScore});
}

/// @nodoc
class __$$QuizRequirementImplCopyWithImpl<$Res>
    extends _$QuizRequirementCopyWithImpl<$Res, _$QuizRequirementImpl>
    implements _$$QuizRequirementImplCopyWith<$Res> {
  __$$QuizRequirementImplCopyWithImpl(
    _$QuizRequirementImpl _value,
    $Res Function(_$QuizRequirementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizRequirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quizId = null,
    Object? title = null,
    Object? passingScore = null,
  }) {
    return _then(
      _$QuizRequirementImpl(
        quizId: null == quizId
            ? _value.quizId
            : quizId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        passingScore: null == passingScore
            ? _value.passingScore
            : passingScore // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizRequirementImpl implements _QuizRequirement {
  const _$QuizRequirementImpl({
    required this.quizId,
    required this.title,
    this.passingScore = 70,
  });

  factory _$QuizRequirementImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizRequirementImplFromJson(json);

  @override
  final String quizId;
  @override
  final String title;
  @override
  @JsonKey()
  final int passingScore;

  @override
  String toString() {
    return 'QuizRequirement(quizId: $quizId, title: $title, passingScore: $passingScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizRequirementImpl &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.passingScore, passingScore) ||
                other.passingScore == passingScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quizId, title, passingScore);

  /// Create a copy of QuizRequirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizRequirementImplCopyWith<_$QuizRequirementImpl> get copyWith =>
      __$$QuizRequirementImplCopyWithImpl<_$QuizRequirementImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizRequirementImplToJson(this);
  }
}

abstract class _QuizRequirement implements QuizRequirement {
  const factory _QuizRequirement({
    required final String quizId,
    required final String title,
    final int passingScore,
  }) = _$QuizRequirementImpl;

  factory _QuizRequirement.fromJson(Map<String, dynamic> json) =
      _$QuizRequirementImpl.fromJson;

  @override
  String get quizId;
  @override
  String get title;
  @override
  int get passingScore;

  /// Create a copy of QuizRequirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizRequirementImplCopyWith<_$QuizRequirementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
