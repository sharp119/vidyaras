// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'courses_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CoursesState {
  List<Course> get courses => throw _privateConstructorUsedError;
  List<Course> get filteredCourses => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  String get selectedCategory => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of CoursesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoursesStateCopyWith<CoursesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursesStateCopyWith<$Res> {
  factory $CoursesStateCopyWith(
    CoursesState value,
    $Res Function(CoursesState) then,
  ) = _$CoursesStateCopyWithImpl<$Res, CoursesState>;
  @useResult
  $Res call({
    List<Course> courses,
    List<Course> filteredCourses,
    bool isLoading,
    String searchQuery,
    String selectedCategory,
    Failure? failure,
  });
}

/// @nodoc
class _$CoursesStateCopyWithImpl<$Res, $Val extends CoursesState>
    implements $CoursesStateCopyWith<$Res> {
  _$CoursesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoursesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courses = null,
    Object? filteredCourses = null,
    Object? isLoading = null,
    Object? searchQuery = null,
    Object? selectedCategory = null,
    Object? failure = freezed,
  }) {
    return _then(
      _value.copyWith(
            courses: null == courses
                ? _value.courses
                : courses // ignore: cast_nullable_to_non_nullable
                      as List<Course>,
            filteredCourses: null == filteredCourses
                ? _value.filteredCourses
                : filteredCourses // ignore: cast_nullable_to_non_nullable
                      as List<Course>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedCategory: null == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as Failure?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoursesStateImplCopyWith<$Res>
    implements $CoursesStateCopyWith<$Res> {
  factory _$$CoursesStateImplCopyWith(
    _$CoursesStateImpl value,
    $Res Function(_$CoursesStateImpl) then,
  ) = __$$CoursesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Course> courses,
    List<Course> filteredCourses,
    bool isLoading,
    String searchQuery,
    String selectedCategory,
    Failure? failure,
  });
}

/// @nodoc
class __$$CoursesStateImplCopyWithImpl<$Res>
    extends _$CoursesStateCopyWithImpl<$Res, _$CoursesStateImpl>
    implements _$$CoursesStateImplCopyWith<$Res> {
  __$$CoursesStateImplCopyWithImpl(
    _$CoursesStateImpl _value,
    $Res Function(_$CoursesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoursesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? courses = null,
    Object? filteredCourses = null,
    Object? isLoading = null,
    Object? searchQuery = null,
    Object? selectedCategory = null,
    Object? failure = freezed,
  }) {
    return _then(
      _$CoursesStateImpl(
        courses: null == courses
            ? _value._courses
            : courses // ignore: cast_nullable_to_non_nullable
                  as List<Course>,
        filteredCourses: null == filteredCourses
            ? _value._filteredCourses
            : filteredCourses // ignore: cast_nullable_to_non_nullable
                  as List<Course>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedCategory: null == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure?,
      ),
    );
  }
}

/// @nodoc

class _$CoursesStateImpl extends _CoursesState {
  const _$CoursesStateImpl({
    final List<Course> courses = const [],
    final List<Course> filteredCourses = const [],
    this.isLoading = true,
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.failure,
  }) : _courses = courses,
       _filteredCourses = filteredCourses,
       super._();

  final List<Course> _courses;
  @override
  @JsonKey()
  List<Course> get courses {
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_courses);
  }

  final List<Course> _filteredCourses;
  @override
  @JsonKey()
  List<Course> get filteredCourses {
    if (_filteredCourses is EqualUnmodifiableListView) return _filteredCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredCourses);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final String selectedCategory;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'CoursesState(courses: $courses, filteredCourses: $filteredCourses, isLoading: $isLoading, searchQuery: $searchQuery, selectedCategory: $selectedCategory, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursesStateImpl &&
            const DeepCollectionEquality().equals(other._courses, _courses) &&
            const DeepCollectionEquality().equals(
              other._filteredCourses,
              _filteredCourses,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.selectedCategory, selectedCategory) ||
                other.selectedCategory == selectedCategory) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_courses),
    const DeepCollectionEquality().hash(_filteredCourses),
    isLoading,
    searchQuery,
    selectedCategory,
    failure,
  );

  /// Create a copy of CoursesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursesStateImplCopyWith<_$CoursesStateImpl> get copyWith =>
      __$$CoursesStateImplCopyWithImpl<_$CoursesStateImpl>(this, _$identity);
}

abstract class _CoursesState extends CoursesState {
  const factory _CoursesState({
    final List<Course> courses,
    final List<Course> filteredCourses,
    final bool isLoading,
    final String searchQuery,
    final String selectedCategory,
    final Failure? failure,
  }) = _$CoursesStateImpl;
  const _CoursesState._() : super._();

  @override
  List<Course> get courses;
  @override
  List<Course> get filteredCourses;
  @override
  bool get isLoading;
  @override
  String get searchQuery;
  @override
  String get selectedCategory;
  @override
  Failure? get failure;

  /// Create a copy of CoursesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoursesStateImplCopyWith<_$CoursesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
