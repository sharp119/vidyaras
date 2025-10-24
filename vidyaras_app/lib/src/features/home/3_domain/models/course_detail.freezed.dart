// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseDetail _$CourseDetailFromJson(Map<String, dynamic> json) {
  return _CourseDetail.fromJson(json);
}

/// @nodoc
mixin _$CourseDetail {
  Course get basicInfo => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get whatYouLearn => throw _privateConstructorUsedError;
  List<String> get courseIncludes => throw _privateConstructorUsedError;
  List<String> get prerequisites => throw _privateConstructorUsedError;
  List<SectionInfo> get curriculum => throw _privateConstructorUsedError;
  PricingOption get pricing => throw _privateConstructorUsedError;
  List<CourseReview> get reviews => throw _privateConstructorUsedError;
  BatchInfo? get liveBatch =>
      throw _privateConstructorUsedError; // Only for live courses
  int? get accessDays =>
      throw _privateConstructorUsedError; // Only for recorded courses (e.g., 90 days)
  DateTime? get accessExpiryDate =>
      throw _privateConstructorUsedError; // For enrolled students
  String? get language =>
      throw _privateConstructorUsedError; // "Hindi", "English", "Bilingual"
  bool get hasCertificate => throw _privateConstructorUsedError;
  bool get hasQuizzes => throw _privateConstructorUsedError;
  bool get hasMaterials => throw _privateConstructorUsedError;

  /// Serializes this CourseDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseDetailCopyWith<CourseDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseDetailCopyWith<$Res> {
  factory $CourseDetailCopyWith(
    CourseDetail value,
    $Res Function(CourseDetail) then,
  ) = _$CourseDetailCopyWithImpl<$Res, CourseDetail>;
  @useResult
  $Res call({
    Course basicInfo,
    String description,
    List<String> whatYouLearn,
    List<String> courseIncludes,
    List<String> prerequisites,
    List<SectionInfo> curriculum,
    PricingOption pricing,
    List<CourseReview> reviews,
    BatchInfo? liveBatch,
    int? accessDays,
    DateTime? accessExpiryDate,
    String? language,
    bool hasCertificate,
    bool hasQuizzes,
    bool hasMaterials,
  });

  $CourseCopyWith<$Res> get basicInfo;
  $PricingOptionCopyWith<$Res> get pricing;
  $BatchInfoCopyWith<$Res>? get liveBatch;
}

/// @nodoc
class _$CourseDetailCopyWithImpl<$Res, $Val extends CourseDetail>
    implements $CourseDetailCopyWith<$Res> {
  _$CourseDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basicInfo = null,
    Object? description = null,
    Object? whatYouLearn = null,
    Object? courseIncludes = null,
    Object? prerequisites = null,
    Object? curriculum = null,
    Object? pricing = null,
    Object? reviews = null,
    Object? liveBatch = freezed,
    Object? accessDays = freezed,
    Object? accessExpiryDate = freezed,
    Object? language = freezed,
    Object? hasCertificate = null,
    Object? hasQuizzes = null,
    Object? hasMaterials = null,
  }) {
    return _then(
      _value.copyWith(
            basicInfo: null == basicInfo
                ? _value.basicInfo
                : basicInfo // ignore: cast_nullable_to_non_nullable
                      as Course,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            whatYouLearn: null == whatYouLearn
                ? _value.whatYouLearn
                : whatYouLearn // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            courseIncludes: null == courseIncludes
                ? _value.courseIncludes
                : courseIncludes // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            prerequisites: null == prerequisites
                ? _value.prerequisites
                : prerequisites // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            curriculum: null == curriculum
                ? _value.curriculum
                : curriculum // ignore: cast_nullable_to_non_nullable
                      as List<SectionInfo>,
            pricing: null == pricing
                ? _value.pricing
                : pricing // ignore: cast_nullable_to_non_nullable
                      as PricingOption,
            reviews: null == reviews
                ? _value.reviews
                : reviews // ignore: cast_nullable_to_non_nullable
                      as List<CourseReview>,
            liveBatch: freezed == liveBatch
                ? _value.liveBatch
                : liveBatch // ignore: cast_nullable_to_non_nullable
                      as BatchInfo?,
            accessDays: freezed == accessDays
                ? _value.accessDays
                : accessDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            accessExpiryDate: freezed == accessExpiryDate
                ? _value.accessExpiryDate
                : accessExpiryDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            language: freezed == language
                ? _value.language
                : language // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasCertificate: null == hasCertificate
                ? _value.hasCertificate
                : hasCertificate // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasQuizzes: null == hasQuizzes
                ? _value.hasQuizzes
                : hasQuizzes // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMaterials: null == hasMaterials
                ? _value.hasMaterials
                : hasMaterials // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CourseCopyWith<$Res> get basicInfo {
    return $CourseCopyWith<$Res>(_value.basicInfo, (value) {
      return _then(_value.copyWith(basicInfo: value) as $Val);
    });
  }

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PricingOptionCopyWith<$Res> get pricing {
    return $PricingOptionCopyWith<$Res>(_value.pricing, (value) {
      return _then(_value.copyWith(pricing: value) as $Val);
    });
  }

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BatchInfoCopyWith<$Res>? get liveBatch {
    if (_value.liveBatch == null) {
      return null;
    }

    return $BatchInfoCopyWith<$Res>(_value.liveBatch!, (value) {
      return _then(_value.copyWith(liveBatch: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CourseDetailImplCopyWith<$Res>
    implements $CourseDetailCopyWith<$Res> {
  factory _$$CourseDetailImplCopyWith(
    _$CourseDetailImpl value,
    $Res Function(_$CourseDetailImpl) then,
  ) = __$$CourseDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Course basicInfo,
    String description,
    List<String> whatYouLearn,
    List<String> courseIncludes,
    List<String> prerequisites,
    List<SectionInfo> curriculum,
    PricingOption pricing,
    List<CourseReview> reviews,
    BatchInfo? liveBatch,
    int? accessDays,
    DateTime? accessExpiryDate,
    String? language,
    bool hasCertificate,
    bool hasQuizzes,
    bool hasMaterials,
  });

  @override
  $CourseCopyWith<$Res> get basicInfo;
  @override
  $PricingOptionCopyWith<$Res> get pricing;
  @override
  $BatchInfoCopyWith<$Res>? get liveBatch;
}

/// @nodoc
class __$$CourseDetailImplCopyWithImpl<$Res>
    extends _$CourseDetailCopyWithImpl<$Res, _$CourseDetailImpl>
    implements _$$CourseDetailImplCopyWith<$Res> {
  __$$CourseDetailImplCopyWithImpl(
    _$CourseDetailImpl _value,
    $Res Function(_$CourseDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basicInfo = null,
    Object? description = null,
    Object? whatYouLearn = null,
    Object? courseIncludes = null,
    Object? prerequisites = null,
    Object? curriculum = null,
    Object? pricing = null,
    Object? reviews = null,
    Object? liveBatch = freezed,
    Object? accessDays = freezed,
    Object? accessExpiryDate = freezed,
    Object? language = freezed,
    Object? hasCertificate = null,
    Object? hasQuizzes = null,
    Object? hasMaterials = null,
  }) {
    return _then(
      _$CourseDetailImpl(
        basicInfo: null == basicInfo
            ? _value.basicInfo
            : basicInfo // ignore: cast_nullable_to_non_nullable
                  as Course,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        whatYouLearn: null == whatYouLearn
            ? _value._whatYouLearn
            : whatYouLearn // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        courseIncludes: null == courseIncludes
            ? _value._courseIncludes
            : courseIncludes // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        prerequisites: null == prerequisites
            ? _value._prerequisites
            : prerequisites // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        curriculum: null == curriculum
            ? _value._curriculum
            : curriculum // ignore: cast_nullable_to_non_nullable
                  as List<SectionInfo>,
        pricing: null == pricing
            ? _value.pricing
            : pricing // ignore: cast_nullable_to_non_nullable
                  as PricingOption,
        reviews: null == reviews
            ? _value._reviews
            : reviews // ignore: cast_nullable_to_non_nullable
                  as List<CourseReview>,
        liveBatch: freezed == liveBatch
            ? _value.liveBatch
            : liveBatch // ignore: cast_nullable_to_non_nullable
                  as BatchInfo?,
        accessDays: freezed == accessDays
            ? _value.accessDays
            : accessDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        accessExpiryDate: freezed == accessExpiryDate
            ? _value.accessExpiryDate
            : accessExpiryDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        language: freezed == language
            ? _value.language
            : language // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasCertificate: null == hasCertificate
            ? _value.hasCertificate
            : hasCertificate // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasQuizzes: null == hasQuizzes
            ? _value.hasQuizzes
            : hasQuizzes // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMaterials: null == hasMaterials
            ? _value.hasMaterials
            : hasMaterials // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseDetailImpl implements _CourseDetail {
  const _$CourseDetailImpl({
    required this.basicInfo,
    required this.description,
    required final List<String> whatYouLearn,
    required final List<String> courseIncludes,
    required final List<String> prerequisites,
    required final List<SectionInfo> curriculum,
    required this.pricing,
    required final List<CourseReview> reviews,
    this.liveBatch,
    this.accessDays,
    this.accessExpiryDate,
    this.language,
    this.hasCertificate = false,
    this.hasQuizzes = false,
    this.hasMaterials = false,
  }) : _whatYouLearn = whatYouLearn,
       _courseIncludes = courseIncludes,
       _prerequisites = prerequisites,
       _curriculum = curriculum,
       _reviews = reviews;

  factory _$CourseDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseDetailImplFromJson(json);

  @override
  final Course basicInfo;
  @override
  final String description;
  final List<String> _whatYouLearn;
  @override
  List<String> get whatYouLearn {
    if (_whatYouLearn is EqualUnmodifiableListView) return _whatYouLearn;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_whatYouLearn);
  }

  final List<String> _courseIncludes;
  @override
  List<String> get courseIncludes {
    if (_courseIncludes is EqualUnmodifiableListView) return _courseIncludes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courseIncludes);
  }

  final List<String> _prerequisites;
  @override
  List<String> get prerequisites {
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prerequisites);
  }

  final List<SectionInfo> _curriculum;
  @override
  List<SectionInfo> get curriculum {
    if (_curriculum is EqualUnmodifiableListView) return _curriculum;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_curriculum);
  }

  @override
  final PricingOption pricing;
  final List<CourseReview> _reviews;
  @override
  List<CourseReview> get reviews {
    if (_reviews is EqualUnmodifiableListView) return _reviews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reviews);
  }

  @override
  final BatchInfo? liveBatch;
  // Only for live courses
  @override
  final int? accessDays;
  // Only for recorded courses (e.g., 90 days)
  @override
  final DateTime? accessExpiryDate;
  // For enrolled students
  @override
  final String? language;
  // "Hindi", "English", "Bilingual"
  @override
  @JsonKey()
  final bool hasCertificate;
  @override
  @JsonKey()
  final bool hasQuizzes;
  @override
  @JsonKey()
  final bool hasMaterials;

  @override
  String toString() {
    return 'CourseDetail(basicInfo: $basicInfo, description: $description, whatYouLearn: $whatYouLearn, courseIncludes: $courseIncludes, prerequisites: $prerequisites, curriculum: $curriculum, pricing: $pricing, reviews: $reviews, liveBatch: $liveBatch, accessDays: $accessDays, accessExpiryDate: $accessExpiryDate, language: $language, hasCertificate: $hasCertificate, hasQuizzes: $hasQuizzes, hasMaterials: $hasMaterials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseDetailImpl &&
            (identical(other.basicInfo, basicInfo) ||
                other.basicInfo == basicInfo) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._whatYouLearn,
              _whatYouLearn,
            ) &&
            const DeepCollectionEquality().equals(
              other._courseIncludes,
              _courseIncludes,
            ) &&
            const DeepCollectionEquality().equals(
              other._prerequisites,
              _prerequisites,
            ) &&
            const DeepCollectionEquality().equals(
              other._curriculum,
              _curriculum,
            ) &&
            (identical(other.pricing, pricing) || other.pricing == pricing) &&
            const DeepCollectionEquality().equals(other._reviews, _reviews) &&
            (identical(other.liveBatch, liveBatch) ||
                other.liveBatch == liveBatch) &&
            (identical(other.accessDays, accessDays) ||
                other.accessDays == accessDays) &&
            (identical(other.accessExpiryDate, accessExpiryDate) ||
                other.accessExpiryDate == accessExpiryDate) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.hasCertificate, hasCertificate) ||
                other.hasCertificate == hasCertificate) &&
            (identical(other.hasQuizzes, hasQuizzes) ||
                other.hasQuizzes == hasQuizzes) &&
            (identical(other.hasMaterials, hasMaterials) ||
                other.hasMaterials == hasMaterials));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    basicInfo,
    description,
    const DeepCollectionEquality().hash(_whatYouLearn),
    const DeepCollectionEquality().hash(_courseIncludes),
    const DeepCollectionEquality().hash(_prerequisites),
    const DeepCollectionEquality().hash(_curriculum),
    pricing,
    const DeepCollectionEquality().hash(_reviews),
    liveBatch,
    accessDays,
    accessExpiryDate,
    language,
    hasCertificate,
    hasQuizzes,
    hasMaterials,
  );

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseDetailImplCopyWith<_$CourseDetailImpl> get copyWith =>
      __$$CourseDetailImplCopyWithImpl<_$CourseDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseDetailImplToJson(this);
  }
}

abstract class _CourseDetail implements CourseDetail {
  const factory _CourseDetail({
    required final Course basicInfo,
    required final String description,
    required final List<String> whatYouLearn,
    required final List<String> courseIncludes,
    required final List<String> prerequisites,
    required final List<SectionInfo> curriculum,
    required final PricingOption pricing,
    required final List<CourseReview> reviews,
    final BatchInfo? liveBatch,
    final int? accessDays,
    final DateTime? accessExpiryDate,
    final String? language,
    final bool hasCertificate,
    final bool hasQuizzes,
    final bool hasMaterials,
  }) = _$CourseDetailImpl;

  factory _CourseDetail.fromJson(Map<String, dynamic> json) =
      _$CourseDetailImpl.fromJson;

  @override
  Course get basicInfo;
  @override
  String get description;
  @override
  List<String> get whatYouLearn;
  @override
  List<String> get courseIncludes;
  @override
  List<String> get prerequisites;
  @override
  List<SectionInfo> get curriculum;
  @override
  PricingOption get pricing;
  @override
  List<CourseReview> get reviews;
  @override
  BatchInfo? get liveBatch; // Only for live courses
  @override
  int? get accessDays; // Only for recorded courses (e.g., 90 days)
  @override
  DateTime? get accessExpiryDate; // For enrolled students
  @override
  String? get language; // "Hindi", "English", "Bilingual"
  @override
  bool get hasCertificate;
  @override
  bool get hasQuizzes;
  @override
  bool get hasMaterials;

  /// Create a copy of CourseDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseDetailImplCopyWith<_$CourseDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
