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
  // Course basic info
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get instructor => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  int get enrolledCount => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;
  bool get isRecorded => throw _privateConstructorUsedError; // Enrollment info
  String? get enrollmentId => throw _privateConstructorUsedError;
  DateTime? get enrolledAt => throw _privateConstructorUsedError;
  String get enrollmentStatus =>
      throw _privateConstructorUsedError; // active, completed, expired
  DateTime? get lastAccessedAt =>
      throw _privateConstructorUsedError; // Progress tracking
  double get progress => throw _privateConstructorUsedError; // 0.0 to 1.0
  int get totalLectures => throw _privateConstructorUsedError;
  int get completedLectures => throw _privateConstructorUsedError;
  int get totalDurationMinutes =>
      throw _privateConstructorUsedError; // Course content (loaded separately for performance)
  List<SectionInfo> get sections => throw _privateConstructorUsedError;
  List<Lecture> get lectures => throw _privateConstructorUsedError;
  List<LiveClass> get liveClasses => throw _privateConstructorUsedError;
  List<CourseMaterial> get materials =>
      throw _privateConstructorUsedError; // Metadata
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

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
    String id,
    String title,
    String instructor,
    String? thumbnailUrl,
    String? description,
    double rating,
    int reviewCount,
    int enrolledCount,
    String? price,
    String? duration,
    bool isLive,
    bool isRecorded,
    String? enrollmentId,
    DateTime? enrolledAt,
    String enrollmentStatus,
    DateTime? lastAccessedAt,
    double progress,
    int totalLectures,
    int completedLectures,
    int totalDurationMinutes,
    List<SectionInfo> sections,
    List<Lecture> lectures,
    List<LiveClass> liveClasses,
    List<CourseMaterial> materials,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
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
    Object? id = null,
    Object? title = null,
    Object? instructor = null,
    Object? thumbnailUrl = freezed,
    Object? description = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? enrolledCount = null,
    Object? price = freezed,
    Object? duration = freezed,
    Object? isLive = null,
    Object? isRecorded = null,
    Object? enrollmentId = freezed,
    Object? enrolledAt = freezed,
    Object? enrollmentStatus = null,
    Object? lastAccessedAt = freezed,
    Object? progress = null,
    Object? totalLectures = null,
    Object? completedLectures = null,
    Object? totalDurationMinutes = null,
    Object? sections = null,
    Object? lectures = null,
    Object? liveClasses = null,
    Object? materials = null,
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
            instructor: null == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String,
            thumbnailUrl: freezed == thumbnailUrl
                ? _value.thumbnailUrl
                : thumbnailUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            enrolledCount: null == enrolledCount
                ? _value.enrolledCount
                : enrolledCount // ignore: cast_nullable_to_non_nullable
                      as int,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as String?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String?,
            isLive: null == isLive
                ? _value.isLive
                : isLive // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRecorded: null == isRecorded
                ? _value.isRecorded
                : isRecorded // ignore: cast_nullable_to_non_nullable
                      as bool,
            enrollmentId: freezed == enrollmentId
                ? _value.enrollmentId
                : enrollmentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            enrolledAt: freezed == enrolledAt
                ? _value.enrolledAt
                : enrolledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            enrollmentStatus: null == enrollmentStatus
                ? _value.enrollmentStatus
                : enrollmentStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            lastAccessedAt: freezed == lastAccessedAt
                ? _value.lastAccessedAt
                : lastAccessedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double,
            totalLectures: null == totalLectures
                ? _value.totalLectures
                : totalLectures // ignore: cast_nullable_to_non_nullable
                      as int,
            completedLectures: null == completedLectures
                ? _value.completedLectures
                : completedLectures // ignore: cast_nullable_to_non_nullable
                      as int,
            totalDurationMinutes: null == totalDurationMinutes
                ? _value.totalDurationMinutes
                : totalDurationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            sections: null == sections
                ? _value.sections
                : sections // ignore: cast_nullable_to_non_nullable
                      as List<SectionInfo>,
            lectures: null == lectures
                ? _value.lectures
                : lectures // ignore: cast_nullable_to_non_nullable
                      as List<Lecture>,
            liveClasses: null == liveClasses
                ? _value.liveClasses
                : liveClasses // ignore: cast_nullable_to_non_nullable
                      as List<LiveClass>,
            materials: null == materials
                ? _value.materials
                : materials // ignore: cast_nullable_to_non_nullable
                      as List<CourseMaterial>,
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
abstract class _$$EnrolledCourseImplCopyWith<$Res>
    implements $EnrolledCourseCopyWith<$Res> {
  factory _$$EnrolledCourseImplCopyWith(
    _$EnrolledCourseImpl value,
    $Res Function(_$EnrolledCourseImpl) then,
  ) = __$$EnrolledCourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String instructor,
    String? thumbnailUrl,
    String? description,
    double rating,
    int reviewCount,
    int enrolledCount,
    String? price,
    String? duration,
    bool isLive,
    bool isRecorded,
    String? enrollmentId,
    DateTime? enrolledAt,
    String enrollmentStatus,
    DateTime? lastAccessedAt,
    double progress,
    int totalLectures,
    int completedLectures,
    int totalDurationMinutes,
    List<SectionInfo> sections,
    List<Lecture> lectures,
    List<LiveClass> liveClasses,
    List<CourseMaterial> materials,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
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
    Object? id = null,
    Object? title = null,
    Object? instructor = null,
    Object? thumbnailUrl = freezed,
    Object? description = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? enrolledCount = null,
    Object? price = freezed,
    Object? duration = freezed,
    Object? isLive = null,
    Object? isRecorded = null,
    Object? enrollmentId = freezed,
    Object? enrolledAt = freezed,
    Object? enrollmentStatus = null,
    Object? lastAccessedAt = freezed,
    Object? progress = null,
    Object? totalLectures = null,
    Object? completedLectures = null,
    Object? totalDurationMinutes = null,
    Object? sections = null,
    Object? lectures = null,
    Object? liveClasses = null,
    Object? materials = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$EnrolledCourseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        enrolledCount: null == enrolledCount
            ? _value.enrolledCount
            : enrolledCount // ignore: cast_nullable_to_non_nullable
                  as int,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as String?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String?,
        isLive: null == isLive
            ? _value.isLive
            : isLive // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRecorded: null == isRecorded
            ? _value.isRecorded
            : isRecorded // ignore: cast_nullable_to_non_nullable
                  as bool,
        enrollmentId: freezed == enrollmentId
            ? _value.enrollmentId
            : enrollmentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        enrolledAt: freezed == enrolledAt
            ? _value.enrolledAt
            : enrolledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        enrollmentStatus: null == enrollmentStatus
            ? _value.enrollmentStatus
            : enrollmentStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        lastAccessedAt: freezed == lastAccessedAt
            ? _value.lastAccessedAt
            : lastAccessedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double,
        totalLectures: null == totalLectures
            ? _value.totalLectures
            : totalLectures // ignore: cast_nullable_to_non_nullable
                  as int,
        completedLectures: null == completedLectures
            ? _value.completedLectures
            : completedLectures // ignore: cast_nullable_to_non_nullable
                  as int,
        totalDurationMinutes: null == totalDurationMinutes
            ? _value.totalDurationMinutes
            : totalDurationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        sections: null == sections
            ? _value._sections
            : sections // ignore: cast_nullable_to_non_nullable
                  as List<SectionInfo>,
        lectures: null == lectures
            ? _value._lectures
            : lectures // ignore: cast_nullable_to_non_nullable
                  as List<Lecture>,
        liveClasses: null == liveClasses
            ? _value._liveClasses
            : liveClasses // ignore: cast_nullable_to_non_nullable
                  as List<LiveClass>,
        materials: null == materials
            ? _value._materials
            : materials // ignore: cast_nullable_to_non_nullable
                  as List<CourseMaterial>,
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
class _$EnrolledCourseImpl implements _EnrolledCourse {
  const _$EnrolledCourseImpl({
    required this.id,
    required this.title,
    required this.instructor,
    this.thumbnailUrl,
    this.description,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.enrolledCount = 0,
    this.price,
    this.duration,
    this.isLive = false,
    this.isRecorded = false,
    this.enrollmentId,
    this.enrolledAt,
    this.enrollmentStatus = 'active',
    this.lastAccessedAt,
    this.progress = 0.0,
    this.totalLectures = 0,
    this.completedLectures = 0,
    this.totalDurationMinutes = 0,
    final List<SectionInfo> sections = const [],
    final List<Lecture> lectures = const [],
    final List<LiveClass> liveClasses = const [],
    final List<CourseMaterial> materials = const [],
    this.createdAt,
    this.updatedAt,
  }) : _sections = sections,
       _lectures = lectures,
       _liveClasses = liveClasses,
       _materials = materials;

  factory _$EnrolledCourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnrolledCourseImplFromJson(json);

  // Course basic info
  @override
  final String id;
  @override
  final String title;
  @override
  final String instructor;
  @override
  final String? thumbnailUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int reviewCount;
  @override
  @JsonKey()
  final int enrolledCount;
  @override
  final String? price;
  @override
  final String? duration;
  @override
  @JsonKey()
  final bool isLive;
  @override
  @JsonKey()
  final bool isRecorded;
  // Enrollment info
  @override
  final String? enrollmentId;
  @override
  final DateTime? enrolledAt;
  @override
  @JsonKey()
  final String enrollmentStatus;
  // active, completed, expired
  @override
  final DateTime? lastAccessedAt;
  // Progress tracking
  @override
  @JsonKey()
  final double progress;
  // 0.0 to 1.0
  @override
  @JsonKey()
  final int totalLectures;
  @override
  @JsonKey()
  final int completedLectures;
  @override
  @JsonKey()
  final int totalDurationMinutes;
  // Course content (loaded separately for performance)
  final List<SectionInfo> _sections;
  // Course content (loaded separately for performance)
  @override
  @JsonKey()
  List<SectionInfo> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  final List<Lecture> _lectures;
  @override
  @JsonKey()
  List<Lecture> get lectures {
    if (_lectures is EqualUnmodifiableListView) return _lectures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lectures);
  }

  final List<LiveClass> _liveClasses;
  @override
  @JsonKey()
  List<LiveClass> get liveClasses {
    if (_liveClasses is EqualUnmodifiableListView) return _liveClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_liveClasses);
  }

  final List<CourseMaterial> _materials;
  @override
  @JsonKey()
  List<CourseMaterial> get materials {
    if (_materials is EqualUnmodifiableListView) return _materials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materials);
  }

  // Metadata
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EnrolledCourse(id: $id, title: $title, instructor: $instructor, thumbnailUrl: $thumbnailUrl, description: $description, rating: $rating, reviewCount: $reviewCount, enrolledCount: $enrolledCount, price: $price, duration: $duration, isLive: $isLive, isRecorded: $isRecorded, enrollmentId: $enrollmentId, enrolledAt: $enrolledAt, enrollmentStatus: $enrollmentStatus, lastAccessedAt: $lastAccessedAt, progress: $progress, totalLectures: $totalLectures, completedLectures: $completedLectures, totalDurationMinutes: $totalDurationMinutes, sections: $sections, lectures: $lectures, liveClasses: $liveClasses, materials: $materials, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrolledCourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.enrolledCount, enrolledCount) ||
                other.enrolledCount == enrolledCount) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.isRecorded, isRecorded) ||
                other.isRecorded == isRecorded) &&
            (identical(other.enrollmentId, enrollmentId) ||
                other.enrollmentId == enrollmentId) &&
            (identical(other.enrolledAt, enrolledAt) ||
                other.enrolledAt == enrolledAt) &&
            (identical(other.enrollmentStatus, enrollmentStatus) ||
                other.enrollmentStatus == enrollmentStatus) &&
            (identical(other.lastAccessedAt, lastAccessedAt) ||
                other.lastAccessedAt == lastAccessedAt) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.totalLectures, totalLectures) ||
                other.totalLectures == totalLectures) &&
            (identical(other.completedLectures, completedLectures) ||
                other.completedLectures == completedLectures) &&
            (identical(other.totalDurationMinutes, totalDurationMinutes) ||
                other.totalDurationMinutes == totalDurationMinutes) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            const DeepCollectionEquality().equals(other._lectures, _lectures) &&
            const DeepCollectionEquality().equals(
              other._liveClasses,
              _liveClasses,
            ) &&
            const DeepCollectionEquality().equals(
              other._materials,
              _materials,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    instructor,
    thumbnailUrl,
    description,
    rating,
    reviewCount,
    enrolledCount,
    price,
    duration,
    isLive,
    isRecorded,
    enrollmentId,
    enrolledAt,
    enrollmentStatus,
    lastAccessedAt,
    progress,
    totalLectures,
    completedLectures,
    totalDurationMinutes,
    const DeepCollectionEquality().hash(_sections),
    const DeepCollectionEquality().hash(_lectures),
    const DeepCollectionEquality().hash(_liveClasses),
    const DeepCollectionEquality().hash(_materials),
    createdAt,
    updatedAt,
  ]);

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
    required final String id,
    required final String title,
    required final String instructor,
    final String? thumbnailUrl,
    final String? description,
    final double rating,
    final int reviewCount,
    final int enrolledCount,
    final String? price,
    final String? duration,
    final bool isLive,
    final bool isRecorded,
    final String? enrollmentId,
    final DateTime? enrolledAt,
    final String enrollmentStatus,
    final DateTime? lastAccessedAt,
    final double progress,
    final int totalLectures,
    final int completedLectures,
    final int totalDurationMinutes,
    final List<SectionInfo> sections,
    final List<Lecture> lectures,
    final List<LiveClass> liveClasses,
    final List<CourseMaterial> materials,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$EnrolledCourseImpl;

  factory _EnrolledCourse.fromJson(Map<String, dynamic> json) =
      _$EnrolledCourseImpl.fromJson;

  // Course basic info
  @override
  String get id;
  @override
  String get title;
  @override
  String get instructor;
  @override
  String? get thumbnailUrl;
  @override
  String? get description;
  @override
  double get rating;
  @override
  int get reviewCount;
  @override
  int get enrolledCount;
  @override
  String? get price;
  @override
  String? get duration;
  @override
  bool get isLive;
  @override
  bool get isRecorded; // Enrollment info
  @override
  String? get enrollmentId;
  @override
  DateTime? get enrolledAt;
  @override
  String get enrollmentStatus; // active, completed, expired
  @override
  DateTime? get lastAccessedAt; // Progress tracking
  @override
  double get progress; // 0.0 to 1.0
  @override
  int get totalLectures;
  @override
  int get completedLectures;
  @override
  int get totalDurationMinutes; // Course content (loaded separately for performance)
  @override
  List<SectionInfo> get sections;
  @override
  List<Lecture> get lectures;
  @override
  List<LiveClass> get liveClasses;
  @override
  List<CourseMaterial> get materials; // Metadata
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of EnrolledCourse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrolledCourseImplCopyWith<_$EnrolledCourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
