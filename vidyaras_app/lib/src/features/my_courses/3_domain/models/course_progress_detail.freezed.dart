// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_progress_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseProgressDetail _$CourseProgressDetailFromJson(Map<String, dynamic> json) {
  return _CourseProgressDetail.fromJson(json);
}

/// @nodoc
mixin _$CourseProgressDetail {
  EnrolledCourse get summary => throw _privateConstructorUsedError;
  List<CourseSection> get sections => throw _privateConstructorUsedError;
  List<CourseMaterial> get generalMaterials =>
      throw _privateConstructorUsedError;
  LiveClassWindow? get upcomingLiveClass => throw _privateConstructorUsedError;

  /// Serializes this CourseProgressDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseProgressDetailCopyWith<CourseProgressDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseProgressDetailCopyWith<$Res> {
  factory $CourseProgressDetailCopyWith(
    CourseProgressDetail value,
    $Res Function(CourseProgressDetail) then,
  ) = _$CourseProgressDetailCopyWithImpl<$Res, CourseProgressDetail>;
  @useResult
  $Res call({
    EnrolledCourse summary,
    List<CourseSection> sections,
    List<CourseMaterial> generalMaterials,
    LiveClassWindow? upcomingLiveClass,
  });

  $EnrolledCourseCopyWith<$Res> get summary;
  $LiveClassWindowCopyWith<$Res>? get upcomingLiveClass;
}

/// @nodoc
class _$CourseProgressDetailCopyWithImpl<
  $Res,
  $Val extends CourseProgressDetail
>
    implements $CourseProgressDetailCopyWith<$Res> {
  _$CourseProgressDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? sections = null,
    Object? generalMaterials = null,
    Object? upcomingLiveClass = freezed,
  }) {
    return _then(
      _value.copyWith(
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as EnrolledCourse,
            sections: null == sections
                ? _value.sections
                : sections // ignore: cast_nullable_to_non_nullable
                      as List<CourseSection>,
            generalMaterials: null == generalMaterials
                ? _value.generalMaterials
                : generalMaterials // ignore: cast_nullable_to_non_nullable
                      as List<CourseMaterial>,
            upcomingLiveClass: freezed == upcomingLiveClass
                ? _value.upcomingLiveClass
                : upcomingLiveClass // ignore: cast_nullable_to_non_nullable
                      as LiveClassWindow?,
          )
          as $Val,
    );
  }

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EnrolledCourseCopyWith<$Res> get summary {
    return $EnrolledCourseCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LiveClassWindowCopyWith<$Res>? get upcomingLiveClass {
    if (_value.upcomingLiveClass == null) {
      return null;
    }

    return $LiveClassWindowCopyWith<$Res>(_value.upcomingLiveClass!, (value) {
      return _then(_value.copyWith(upcomingLiveClass: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CourseProgressDetailImplCopyWith<$Res>
    implements $CourseProgressDetailCopyWith<$Res> {
  factory _$$CourseProgressDetailImplCopyWith(
    _$CourseProgressDetailImpl value,
    $Res Function(_$CourseProgressDetailImpl) then,
  ) = __$$CourseProgressDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EnrolledCourse summary,
    List<CourseSection> sections,
    List<CourseMaterial> generalMaterials,
    LiveClassWindow? upcomingLiveClass,
  });

  @override
  $EnrolledCourseCopyWith<$Res> get summary;
  @override
  $LiveClassWindowCopyWith<$Res>? get upcomingLiveClass;
}

/// @nodoc
class __$$CourseProgressDetailImplCopyWithImpl<$Res>
    extends _$CourseProgressDetailCopyWithImpl<$Res, _$CourseProgressDetailImpl>
    implements _$$CourseProgressDetailImplCopyWith<$Res> {
  __$$CourseProgressDetailImplCopyWithImpl(
    _$CourseProgressDetailImpl _value,
    $Res Function(_$CourseProgressDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summary = null,
    Object? sections = null,
    Object? generalMaterials = null,
    Object? upcomingLiveClass = freezed,
  }) {
    return _then(
      _$CourseProgressDetailImpl(
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as EnrolledCourse,
        sections: null == sections
            ? _value._sections
            : sections // ignore: cast_nullable_to_non_nullable
                  as List<CourseSection>,
        generalMaterials: null == generalMaterials
            ? _value._generalMaterials
            : generalMaterials // ignore: cast_nullable_to_non_nullable
                  as List<CourseMaterial>,
        upcomingLiveClass: freezed == upcomingLiveClass
            ? _value.upcomingLiveClass
            : upcomingLiveClass // ignore: cast_nullable_to_non_nullable
                  as LiveClassWindow?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseProgressDetailImpl implements _CourseProgressDetail {
  const _$CourseProgressDetailImpl({
    required this.summary,
    required final List<CourseSection> sections,
    final List<CourseMaterial> generalMaterials = const [],
    this.upcomingLiveClass,
  }) : _sections = sections,
       _generalMaterials = generalMaterials;

  factory _$CourseProgressDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseProgressDetailImplFromJson(json);

  @override
  final EnrolledCourse summary;
  final List<CourseSection> _sections;
  @override
  List<CourseSection> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  final List<CourseMaterial> _generalMaterials;
  @override
  @JsonKey()
  List<CourseMaterial> get generalMaterials {
    if (_generalMaterials is EqualUnmodifiableListView)
      return _generalMaterials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_generalMaterials);
  }

  @override
  final LiveClassWindow? upcomingLiveClass;

  @override
  String toString() {
    return 'CourseProgressDetail(summary: $summary, sections: $sections, generalMaterials: $generalMaterials, upcomingLiveClass: $upcomingLiveClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseProgressDetailImpl &&
            (identical(other.summary, summary) || other.summary == summary) &&
            const DeepCollectionEquality().equals(other._sections, _sections) &&
            const DeepCollectionEquality().equals(
              other._generalMaterials,
              _generalMaterials,
            ) &&
            (identical(other.upcomingLiveClass, upcomingLiveClass) ||
                other.upcomingLiveClass == upcomingLiveClass));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    summary,
    const DeepCollectionEquality().hash(_sections),
    const DeepCollectionEquality().hash(_generalMaterials),
    upcomingLiveClass,
  );

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseProgressDetailImplCopyWith<_$CourseProgressDetailImpl>
  get copyWith =>
      __$$CourseProgressDetailImplCopyWithImpl<_$CourseProgressDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseProgressDetailImplToJson(this);
  }
}

abstract class _CourseProgressDetail implements CourseProgressDetail {
  const factory _CourseProgressDetail({
    required final EnrolledCourse summary,
    required final List<CourseSection> sections,
    final List<CourseMaterial> generalMaterials,
    final LiveClassWindow? upcomingLiveClass,
  }) = _$CourseProgressDetailImpl;

  factory _CourseProgressDetail.fromJson(Map<String, dynamic> json) =
      _$CourseProgressDetailImpl.fromJson;

  @override
  EnrolledCourse get summary;
  @override
  List<CourseSection> get sections;
  @override
  List<CourseMaterial> get generalMaterials;
  @override
  LiveClassWindow? get upcomingLiveClass;

  /// Create a copy of CourseProgressDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseProgressDetailImplCopyWith<_$CourseProgressDetailImpl>
  get copyWith => throw _privateConstructorUsedError;
}

CourseSection _$CourseSectionFromJson(Map<String, dynamic> json) {
  return _CourseSection.fromJson(json);
}

/// @nodoc
mixin _$CourseSection {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  List<CourseLecture> get lectures => throw _privateConstructorUsedError;

  /// Serializes this CourseSection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseSectionCopyWith<CourseSection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseSectionCopyWith<$Res> {
  factory $CourseSectionCopyWith(
    CourseSection value,
    $Res Function(CourseSection) then,
  ) = _$CourseSectionCopyWithImpl<$Res, CourseSection>;
  @useResult
  $Res call({
    String id,
    String title,
    int orderIndex,
    List<CourseLecture> lectures,
  });
}

/// @nodoc
class _$CourseSectionCopyWithImpl<$Res, $Val extends CourseSection>
    implements $CourseSectionCopyWith<$Res> {
  _$CourseSectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? orderIndex = null,
    Object? lectures = null,
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
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            lectures: null == lectures
                ? _value.lectures
                : lectures // ignore: cast_nullable_to_non_nullable
                      as List<CourseLecture>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseSectionImplCopyWith<$Res>
    implements $CourseSectionCopyWith<$Res> {
  factory _$$CourseSectionImplCopyWith(
    _$CourseSectionImpl value,
    $Res Function(_$CourseSectionImpl) then,
  ) = __$$CourseSectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    int orderIndex,
    List<CourseLecture> lectures,
  });
}

/// @nodoc
class __$$CourseSectionImplCopyWithImpl<$Res>
    extends _$CourseSectionCopyWithImpl<$Res, _$CourseSectionImpl>
    implements _$$CourseSectionImplCopyWith<$Res> {
  __$$CourseSectionImplCopyWithImpl(
    _$CourseSectionImpl _value,
    $Res Function(_$CourseSectionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseSection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? orderIndex = null,
    Object? lectures = null,
  }) {
    return _then(
      _$CourseSectionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        lectures: null == lectures
            ? _value._lectures
            : lectures // ignore: cast_nullable_to_non_nullable
                  as List<CourseLecture>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseSectionImpl implements _CourseSection {
  const _$CourseSectionImpl({
    required this.id,
    required this.title,
    this.orderIndex = 0,
    final List<CourseLecture> lectures = const [],
  }) : _lectures = lectures;

  factory _$CourseSectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseSectionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final int orderIndex;
  final List<CourseLecture> _lectures;
  @override
  @JsonKey()
  List<CourseLecture> get lectures {
    if (_lectures is EqualUnmodifiableListView) return _lectures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lectures);
  }

  @override
  String toString() {
    return 'CourseSection(id: $id, title: $title, orderIndex: $orderIndex, lectures: $lectures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseSectionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            const DeepCollectionEquality().equals(other._lectures, _lectures));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    orderIndex,
    const DeepCollectionEquality().hash(_lectures),
  );

  /// Create a copy of CourseSection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseSectionImplCopyWith<_$CourseSectionImpl> get copyWith =>
      __$$CourseSectionImplCopyWithImpl<_$CourseSectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseSectionImplToJson(this);
  }
}

abstract class _CourseSection implements CourseSection {
  const factory _CourseSection({
    required final String id,
    required final String title,
    final int orderIndex,
    final List<CourseLecture> lectures,
  }) = _$CourseSectionImpl;

  factory _CourseSection.fromJson(Map<String, dynamic> json) =
      _$CourseSectionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get orderIndex;
  @override
  List<CourseLecture> get lectures;

  /// Create a copy of CourseSection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseSectionImplCopyWith<_$CourseSectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseLecture _$CourseLectureFromJson(Map<String, dynamic> json) {
  return _CourseLecture.fromJson(json);
}

/// @nodoc
mixin _$CourseLecture {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get sectionId => throw _privateConstructorUsedError;
  String get sectionTitle => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get durationMinutes => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  List<CourseMaterial> get materials => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: LectureAccessStatus.available)
  LectureAccessStatus get accessStatus => throw _privateConstructorUsedError;
  QuizRequirement? get requiredQuiz => throw _privateConstructorUsedError;
  bool? get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  LiveClassWindow? get liveClass => throw _privateConstructorUsedError;

  /// Serializes this CourseLecture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseLecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseLectureCopyWith<CourseLecture> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseLectureCopyWith<$Res> {
  factory $CourseLectureCopyWith(
    CourseLecture value,
    $Res Function(CourseLecture) then,
  ) = _$CourseLectureCopyWithImpl<$Res, CourseLecture>;
  @useResult
  $Res call({
    String id,
    String title,
    String sectionId,
    String sectionTitle,
    int orderIndex,
    String? description,
    int? durationMinutes,
    String? videoUrl,
    List<CourseMaterial> materials,
    @JsonKey(unknownEnumValue: LectureAccessStatus.available)
    LectureAccessStatus accessStatus,
    QuizRequirement? requiredQuiz,
    bool? isCompleted,
    DateTime? completedAt,
    LiveClassWindow? liveClass,
  });

  $QuizRequirementCopyWith<$Res>? get requiredQuiz;
  $LiveClassWindowCopyWith<$Res>? get liveClass;
}

/// @nodoc
class _$CourseLectureCopyWithImpl<$Res, $Val extends CourseLecture>
    implements $CourseLectureCopyWith<$Res> {
  _$CourseLectureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseLecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sectionId = null,
    Object? sectionTitle = null,
    Object? orderIndex = null,
    Object? description = freezed,
    Object? durationMinutes = freezed,
    Object? videoUrl = freezed,
    Object? materials = null,
    Object? accessStatus = null,
    Object? requiredQuiz = freezed,
    Object? isCompleted = freezed,
    Object? completedAt = freezed,
    Object? liveClass = freezed,
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
            sectionId: null == sectionId
                ? _value.sectionId
                : sectionId // ignore: cast_nullable_to_non_nullable
                      as String,
            sectionTitle: null == sectionTitle
                ? _value.sectionTitle
                : sectionTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            durationMinutes: freezed == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            videoUrl: freezed == videoUrl
                ? _value.videoUrl
                : videoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            materials: null == materials
                ? _value.materials
                : materials // ignore: cast_nullable_to_non_nullable
                      as List<CourseMaterial>,
            accessStatus: null == accessStatus
                ? _value.accessStatus
                : accessStatus // ignore: cast_nullable_to_non_nullable
                      as LectureAccessStatus,
            requiredQuiz: freezed == requiredQuiz
                ? _value.requiredQuiz
                : requiredQuiz // ignore: cast_nullable_to_non_nullable
                      as QuizRequirement?,
            isCompleted: freezed == isCompleted
                ? _value.isCompleted
                : isCompleted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            liveClass: freezed == liveClass
                ? _value.liveClass
                : liveClass // ignore: cast_nullable_to_non_nullable
                      as LiveClassWindow?,
          )
          as $Val,
    );
  }

  /// Create a copy of CourseLecture
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

  /// Create a copy of CourseLecture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LiveClassWindowCopyWith<$Res>? get liveClass {
    if (_value.liveClass == null) {
      return null;
    }

    return $LiveClassWindowCopyWith<$Res>(_value.liveClass!, (value) {
      return _then(_value.copyWith(liveClass: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CourseLectureImplCopyWith<$Res>
    implements $CourseLectureCopyWith<$Res> {
  factory _$$CourseLectureImplCopyWith(
    _$CourseLectureImpl value,
    $Res Function(_$CourseLectureImpl) then,
  ) = __$$CourseLectureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String sectionId,
    String sectionTitle,
    int orderIndex,
    String? description,
    int? durationMinutes,
    String? videoUrl,
    List<CourseMaterial> materials,
    @JsonKey(unknownEnumValue: LectureAccessStatus.available)
    LectureAccessStatus accessStatus,
    QuizRequirement? requiredQuiz,
    bool? isCompleted,
    DateTime? completedAt,
    LiveClassWindow? liveClass,
  });

  @override
  $QuizRequirementCopyWith<$Res>? get requiredQuiz;
  @override
  $LiveClassWindowCopyWith<$Res>? get liveClass;
}

/// @nodoc
class __$$CourseLectureImplCopyWithImpl<$Res>
    extends _$CourseLectureCopyWithImpl<$Res, _$CourseLectureImpl>
    implements _$$CourseLectureImplCopyWith<$Res> {
  __$$CourseLectureImplCopyWithImpl(
    _$CourseLectureImpl _value,
    $Res Function(_$CourseLectureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseLecture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sectionId = null,
    Object? sectionTitle = null,
    Object? orderIndex = null,
    Object? description = freezed,
    Object? durationMinutes = freezed,
    Object? videoUrl = freezed,
    Object? materials = null,
    Object? accessStatus = null,
    Object? requiredQuiz = freezed,
    Object? isCompleted = freezed,
    Object? completedAt = freezed,
    Object? liveClass = freezed,
  }) {
    return _then(
      _$CourseLectureImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        sectionId: null == sectionId
            ? _value.sectionId
            : sectionId // ignore: cast_nullable_to_non_nullable
                  as String,
        sectionTitle: null == sectionTitle
            ? _value.sectionTitle
            : sectionTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        durationMinutes: freezed == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        videoUrl: freezed == videoUrl
            ? _value.videoUrl
            : videoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        materials: null == materials
            ? _value._materials
            : materials // ignore: cast_nullable_to_non_nullable
                  as List<CourseMaterial>,
        accessStatus: null == accessStatus
            ? _value.accessStatus
            : accessStatus // ignore: cast_nullable_to_non_nullable
                  as LectureAccessStatus,
        requiredQuiz: freezed == requiredQuiz
            ? _value.requiredQuiz
            : requiredQuiz // ignore: cast_nullable_to_non_nullable
                  as QuizRequirement?,
        isCompleted: freezed == isCompleted
            ? _value.isCompleted
            : isCompleted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        liveClass: freezed == liveClass
            ? _value.liveClass
            : liveClass // ignore: cast_nullable_to_non_nullable
                  as LiveClassWindow?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseLectureImpl implements _CourseLecture {
  const _$CourseLectureImpl({
    required this.id,
    required this.title,
    required this.sectionId,
    required this.sectionTitle,
    this.orderIndex = 0,
    this.description,
    this.durationMinutes,
    this.videoUrl,
    final List<CourseMaterial> materials = const [],
    @JsonKey(unknownEnumValue: LectureAccessStatus.available)
    this.accessStatus = LectureAccessStatus.available,
    this.requiredQuiz,
    this.isCompleted,
    this.completedAt,
    this.liveClass,
  }) : _materials = materials;

  factory _$CourseLectureImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseLectureImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String sectionId;
  @override
  final String sectionTitle;
  @override
  @JsonKey()
  final int orderIndex;
  @override
  final String? description;
  @override
  final int? durationMinutes;
  @override
  final String? videoUrl;
  final List<CourseMaterial> _materials;
  @override
  @JsonKey()
  List<CourseMaterial> get materials {
    if (_materials is EqualUnmodifiableListView) return _materials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materials);
  }

  @override
  @JsonKey(unknownEnumValue: LectureAccessStatus.available)
  final LectureAccessStatus accessStatus;
  @override
  final QuizRequirement? requiredQuiz;
  @override
  final bool? isCompleted;
  @override
  final DateTime? completedAt;
  @override
  final LiveClassWindow? liveClass;

  @override
  String toString() {
    return 'CourseLecture(id: $id, title: $title, sectionId: $sectionId, sectionTitle: $sectionTitle, orderIndex: $orderIndex, description: $description, durationMinutes: $durationMinutes, videoUrl: $videoUrl, materials: $materials, accessStatus: $accessStatus, requiredQuiz: $requiredQuiz, isCompleted: $isCompleted, completedAt: $completedAt, liveClass: $liveClass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseLectureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.sectionTitle, sectionTitle) ||
                other.sectionTitle == sectionTitle) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            const DeepCollectionEquality().equals(
              other._materials,
              _materials,
            ) &&
            (identical(other.accessStatus, accessStatus) ||
                other.accessStatus == accessStatus) &&
            (identical(other.requiredQuiz, requiredQuiz) ||
                other.requiredQuiz == requiredQuiz) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.liveClass, liveClass) ||
                other.liveClass == liveClass));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    sectionId,
    sectionTitle,
    orderIndex,
    description,
    durationMinutes,
    videoUrl,
    const DeepCollectionEquality().hash(_materials),
    accessStatus,
    requiredQuiz,
    isCompleted,
    completedAt,
    liveClass,
  );

  /// Create a copy of CourseLecture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseLectureImplCopyWith<_$CourseLectureImpl> get copyWith =>
      __$$CourseLectureImplCopyWithImpl<_$CourseLectureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseLectureImplToJson(this);
  }
}

abstract class _CourseLecture implements CourseLecture {
  const factory _CourseLecture({
    required final String id,
    required final String title,
    required final String sectionId,
    required final String sectionTitle,
    final int orderIndex,
    final String? description,
    final int? durationMinutes,
    final String? videoUrl,
    final List<CourseMaterial> materials,
    @JsonKey(unknownEnumValue: LectureAccessStatus.available)
    final LectureAccessStatus accessStatus,
    final QuizRequirement? requiredQuiz,
    final bool? isCompleted,
    final DateTime? completedAt,
    final LiveClassWindow? liveClass,
  }) = _$CourseLectureImpl;

  factory _CourseLecture.fromJson(Map<String, dynamic> json) =
      _$CourseLectureImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get sectionId;
  @override
  String get sectionTitle;
  @override
  int get orderIndex;
  @override
  String? get description;
  @override
  int? get durationMinutes;
  @override
  String? get videoUrl;
  @override
  List<CourseMaterial> get materials;
  @override
  @JsonKey(unknownEnumValue: LectureAccessStatus.available)
  LectureAccessStatus get accessStatus;
  @override
  QuizRequirement? get requiredQuiz;
  @override
  bool? get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  LiveClassWindow? get liveClass;

  /// Create a copy of CourseLecture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseLectureImplCopyWith<_$CourseLectureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseMaterial _$CourseMaterialFromJson(Map<String, dynamic> json) {
  return _CourseMaterial.fromJson(json);
}

/// @nodoc
mixin _$CourseMaterial {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get fileUrl => throw _privateConstructorUsedError;
  String? get sectionId => throw _privateConstructorUsedError;

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
    String title,
    String type,
    String fileUrl,
    String? sectionId,
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
    Object? title = null,
    Object? type = null,
    Object? fileUrl = null,
    Object? sectionId = freezed,
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
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            fileUrl: null == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            sectionId: freezed == sectionId
                ? _value.sectionId
                : sectionId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    String title,
    String type,
    String fileUrl,
    String? sectionId,
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
    Object? title = null,
    Object? type = null,
    Object? fileUrl = null,
    Object? sectionId = freezed,
  }) {
    return _then(
      _$CourseMaterialImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
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
        sectionId: freezed == sectionId
            ? _value.sectionId
            : sectionId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseMaterialImpl implements _CourseMaterial {
  const _$CourseMaterialImpl({
    required this.id,
    required this.title,
    required this.type,
    required this.fileUrl,
    this.sectionId,
  });

  factory _$CourseMaterialImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseMaterialImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String type;
  @override
  final String fileUrl;
  @override
  final String? sectionId;

  @override
  String toString() {
    return 'CourseMaterial(id: $id, title: $title, type: $type, fileUrl: $fileUrl, sectionId: $sectionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseMaterialImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, type, fileUrl, sectionId);

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
    required final String title,
    required final String type,
    required final String fileUrl,
    final String? sectionId,
  }) = _$CourseMaterialImpl;

  factory _CourseMaterial.fromJson(Map<String, dynamic> json) =
      _$CourseMaterialImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get type;
  @override
  String get fileUrl;
  @override
  String? get sectionId;

  /// Create a copy of CourseMaterial
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseMaterialImplCopyWith<_$CourseMaterialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LiveClassWindow _$LiveClassWindowFromJson(Map<String, dynamic> json) {
  return _LiveClassWindow.fromJson(json);
}

/// @nodoc
mixin _$LiveClassWindow {
  String get id => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String get zoomLink => throw _privateConstructorUsedError;
  String? get meetingId => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get lectureId => throw _privateConstructorUsedError;

  /// Serializes this LiveClassWindow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LiveClassWindow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveClassWindowCopyWith<LiveClassWindow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveClassWindowCopyWith<$Res> {
  factory $LiveClassWindowCopyWith(
    LiveClassWindow value,
    $Res Function(LiveClassWindow) then,
  ) = _$LiveClassWindowCopyWithImpl<$Res, LiveClassWindow>;
  @useResult
  $Res call({
    String id,
    DateTime scheduledAt,
    int durationMinutes,
    String zoomLink,
    String? meetingId,
    String? title,
    String? description,
    String? lectureId,
  });
}

/// @nodoc
class _$LiveClassWindowCopyWithImpl<$Res, $Val extends LiveClassWindow>
    implements $LiveClassWindowCopyWith<$Res> {
  _$LiveClassWindowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveClassWindow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledAt = null,
    Object? durationMinutes = null,
    Object? zoomLink = null,
    Object? meetingId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? lectureId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            scheduledAt: null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            zoomLink: null == zoomLink
                ? _value.zoomLink
                : zoomLink // ignore: cast_nullable_to_non_nullable
                      as String,
            meetingId: freezed == meetingId
                ? _value.meetingId
                : meetingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            lectureId: freezed == lectureId
                ? _value.lectureId
                : lectureId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LiveClassWindowImplCopyWith<$Res>
    implements $LiveClassWindowCopyWith<$Res> {
  factory _$$LiveClassWindowImplCopyWith(
    _$LiveClassWindowImpl value,
    $Res Function(_$LiveClassWindowImpl) then,
  ) = __$$LiveClassWindowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime scheduledAt,
    int durationMinutes,
    String zoomLink,
    String? meetingId,
    String? title,
    String? description,
    String? lectureId,
  });
}

/// @nodoc
class __$$LiveClassWindowImplCopyWithImpl<$Res>
    extends _$LiveClassWindowCopyWithImpl<$Res, _$LiveClassWindowImpl>
    implements _$$LiveClassWindowImplCopyWith<$Res> {
  __$$LiveClassWindowImplCopyWithImpl(
    _$LiveClassWindowImpl _value,
    $Res Function(_$LiveClassWindowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveClassWindow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduledAt = null,
    Object? durationMinutes = null,
    Object? zoomLink = null,
    Object? meetingId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? lectureId = freezed,
  }) {
    return _then(
      _$LiveClassWindowImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduledAt: null == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        zoomLink: null == zoomLink
            ? _value.zoomLink
            : zoomLink // ignore: cast_nullable_to_non_nullable
                  as String,
        meetingId: freezed == meetingId
            ? _value.meetingId
            : meetingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        lectureId: freezed == lectureId
            ? _value.lectureId
            : lectureId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveClassWindowImpl implements _LiveClassWindow {
  const _$LiveClassWindowImpl({
    required this.id,
    required this.scheduledAt,
    this.durationMinutes = 120,
    required this.zoomLink,
    this.meetingId,
    this.title,
    this.description,
    this.lectureId,
  });

  factory _$LiveClassWindowImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveClassWindowImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime scheduledAt;
  @override
  @JsonKey()
  final int durationMinutes;
  @override
  final String zoomLink;
  @override
  final String? meetingId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? lectureId;

  @override
  String toString() {
    return 'LiveClassWindow(id: $id, scheduledAt: $scheduledAt, durationMinutes: $durationMinutes, zoomLink: $zoomLink, meetingId: $meetingId, title: $title, description: $description, lectureId: $lectureId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveClassWindowImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.zoomLink, zoomLink) ||
                other.zoomLink == zoomLink) &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.lectureId, lectureId) ||
                other.lectureId == lectureId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scheduledAt,
    durationMinutes,
    zoomLink,
    meetingId,
    title,
    description,
    lectureId,
  );

  /// Create a copy of LiveClassWindow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveClassWindowImplCopyWith<_$LiveClassWindowImpl> get copyWith =>
      __$$LiveClassWindowImplCopyWithImpl<_$LiveClassWindowImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveClassWindowImplToJson(this);
  }
}

abstract class _LiveClassWindow implements LiveClassWindow {
  const factory _LiveClassWindow({
    required final String id,
    required final DateTime scheduledAt,
    final int durationMinutes,
    required final String zoomLink,
    final String? meetingId,
    final String? title,
    final String? description,
    final String? lectureId,
  }) = _$LiveClassWindowImpl;

  factory _LiveClassWindow.fromJson(Map<String, dynamic> json) =
      _$LiveClassWindowImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get scheduledAt;
  @override
  int get durationMinutes;
  @override
  String get zoomLink;
  @override
  String? get meetingId;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get lectureId;

  /// Create a copy of LiveClassWindow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveClassWindowImplCopyWith<_$LiveClassWindowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
