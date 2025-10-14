// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get instructor => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;
  int get enrolledCount => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  String? get duration => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  bool get isLive => throw _privateConstructorUsedError;
  bool get hasFreeTrial => throw _privateConstructorUsedError;
  bool get isRecorded => throw _privateConstructorUsedError;
  double? get progress =>
      throw _privateConstructorUsedError; // 0.0 to 1.0 for enrolled courses
  List<String>? get categories => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call({
    String id,
    String title,
    String instructor,
    String? thumbnailUrl,
    double rating,
    int reviewCount,
    int enrolledCount,
    String? price,
    String? duration,
    bool isFree,
    bool isLive,
    bool hasFreeTrial,
    bool isRecorded,
    double? progress,
    List<String>? categories,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? instructor = null,
    Object? thumbnailUrl = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? enrolledCount = null,
    Object? price = freezed,
    Object? duration = freezed,
    Object? isFree = null,
    Object? isLive = null,
    Object? hasFreeTrial = null,
    Object? isRecorded = null,
    Object? progress = freezed,
    Object? categories = freezed,
    Object? createdAt = freezed,
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
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLive: null == isLive
                ? _value.isLive
                : isLive // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasFreeTrial: null == hasFreeTrial
                ? _value.hasFreeTrial
                : hasFreeTrial // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRecorded: null == isRecorded
                ? _value.isRecorded
                : isRecorded // ignore: cast_nullable_to_non_nullable
                      as bool,
            progress: freezed == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double?,
            categories: freezed == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
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
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
    _$CourseImpl value,
    $Res Function(_$CourseImpl) then,
  ) = __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String instructor,
    String? thumbnailUrl,
    double rating,
    int reviewCount,
    int enrolledCount,
    String? price,
    String? duration,
    bool isFree,
    bool isLive,
    bool hasFreeTrial,
    bool isRecorded,
    double? progress,
    List<String>? categories,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
    _$CourseImpl _value,
    $Res Function(_$CourseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? instructor = null,
    Object? thumbnailUrl = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? enrolledCount = null,
    Object? price = freezed,
    Object? duration = freezed,
    Object? isFree = null,
    Object? isLive = null,
    Object? hasFreeTrial = null,
    Object? isRecorded = null,
    Object? progress = freezed,
    Object? categories = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$CourseImpl(
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
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLive: null == isLive
            ? _value.isLive
            : isLive // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasFreeTrial: null == hasFreeTrial
            ? _value.hasFreeTrial
            : hasFreeTrial // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRecorded: null == isRecorded
            ? _value.isRecorded
            : isRecorded // ignore: cast_nullable_to_non_nullable
                  as bool,
        progress: freezed == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double?,
        categories: freezed == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
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
class _$CourseImpl implements _Course {
  const _$CourseImpl({
    required this.id,
    required this.title,
    required this.instructor,
    this.thumbnailUrl,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.enrolledCount = 0,
    this.price,
    this.duration,
    this.isFree = false,
    this.isLive = false,
    this.hasFreeTrial = false,
    this.isRecorded = false,
    this.progress,
    final List<String>? categories,
    this.createdAt,
  }) : _categories = categories;

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String instructor;
  @override
  final String? thumbnailUrl;
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
  final bool isFree;
  @override
  @JsonKey()
  final bool isLive;
  @override
  @JsonKey()
  final bool hasFreeTrial;
  @override
  @JsonKey()
  final bool isRecorded;
  @override
  final double? progress;
  // 0.0 to 1.0 for enrolled courses
  final List<String>? _categories;
  // 0.0 to 1.0 for enrolled courses
  @override
  List<String>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Course(id: $id, title: $title, instructor: $instructor, thumbnailUrl: $thumbnailUrl, rating: $rating, reviewCount: $reviewCount, enrolledCount: $enrolledCount, price: $price, duration: $duration, isFree: $isFree, isLive: $isLive, hasFreeTrial: $hasFreeTrial, isRecorded: $isRecorded, progress: $progress, categories: $categories, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.enrolledCount, enrolledCount) ||
                other.enrolledCount == enrolledCount) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.isLive, isLive) || other.isLive == isLive) &&
            (identical(other.hasFreeTrial, hasFreeTrial) ||
                other.hasFreeTrial == hasFreeTrial) &&
            (identical(other.isRecorded, isRecorded) ||
                other.isRecorded == isRecorded) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    instructor,
    thumbnailUrl,
    rating,
    reviewCount,
    enrolledCount,
    price,
    duration,
    isFree,
    isLive,
    hasFreeTrial,
    isRecorded,
    progress,
    const DeepCollectionEquality().hash(_categories),
    createdAt,
  );

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(this);
  }
}

abstract class _Course implements Course {
  const factory _Course({
    required final String id,
    required final String title,
    required final String instructor,
    final String? thumbnailUrl,
    final double rating,
    final int reviewCount,
    final int enrolledCount,
    final String? price,
    final String? duration,
    final bool isFree,
    final bool isLive,
    final bool hasFreeTrial,
    final bool isRecorded,
    final double? progress,
    final List<String>? categories,
    final DateTime? createdAt,
  }) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get instructor;
  @override
  String? get thumbnailUrl;
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
  bool get isFree;
  @override
  bool get isLive;
  @override
  bool get hasFreeTrial;
  @override
  bool get isRecorded;
  @override
  double? get progress; // 0.0 to 1.0 for enrolled courses
  @override
  List<String>? get categories;
  @override
  DateTime? get createdAt;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
