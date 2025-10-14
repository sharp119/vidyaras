// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeData _$HomeDataFromJson(Map<String, dynamic> json) {
  return _HomeData.fromJson(json);
}

/// @nodoc
mixin _$HomeData {
  UserProfile get userProfile => throw _privateConstructorUsedError;
  List<Course> get myCourses => throw _privateConstructorUsedError;
  List<Course> get recommendedCourses => throw _privateConstructorUsedError;
  List<Course> get freeCourses => throw _privateConstructorUsedError;

  /// Serializes this HomeData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeDataCopyWith<HomeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeDataCopyWith<$Res> {
  factory $HomeDataCopyWith(HomeData value, $Res Function(HomeData) then) =
      _$HomeDataCopyWithImpl<$Res, HomeData>;
  @useResult
  $Res call({
    UserProfile userProfile,
    List<Course> myCourses,
    List<Course> recommendedCourses,
    List<Course> freeCourses,
  });

  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class _$HomeDataCopyWithImpl<$Res, $Val extends HomeData>
    implements $HomeDataCopyWith<$Res> {
  _$HomeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = null,
    Object? myCourses = null,
    Object? recommendedCourses = null,
    Object? freeCourses = null,
  }) {
    return _then(
      _value.copyWith(
            userProfile: null == userProfile
                ? _value.userProfile
                : userProfile // ignore: cast_nullable_to_non_nullable
                      as UserProfile,
            myCourses: null == myCourses
                ? _value.myCourses
                : myCourses // ignore: cast_nullable_to_non_nullable
                      as List<Course>,
            recommendedCourses: null == recommendedCourses
                ? _value.recommendedCourses
                : recommendedCourses // ignore: cast_nullable_to_non_nullable
                      as List<Course>,
            freeCourses: null == freeCourses
                ? _value.freeCourses
                : freeCourses // ignore: cast_nullable_to_non_nullable
                      as List<Course>,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_value.userProfile, (value) {
      return _then(_value.copyWith(userProfile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeDataImplCopyWith<$Res>
    implements $HomeDataCopyWith<$Res> {
  factory _$$HomeDataImplCopyWith(
    _$HomeDataImpl value,
    $Res Function(_$HomeDataImpl) then,
  ) = __$$HomeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserProfile userProfile,
    List<Course> myCourses,
    List<Course> recommendedCourses,
    List<Course> freeCourses,
  });

  @override
  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class __$$HomeDataImplCopyWithImpl<$Res>
    extends _$HomeDataCopyWithImpl<$Res, _$HomeDataImpl>
    implements _$$HomeDataImplCopyWith<$Res> {
  __$$HomeDataImplCopyWithImpl(
    _$HomeDataImpl _value,
    $Res Function(_$HomeDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userProfile = null,
    Object? myCourses = null,
    Object? recommendedCourses = null,
    Object? freeCourses = null,
  }) {
    return _then(
      _$HomeDataImpl(
        userProfile: null == userProfile
            ? _value.userProfile
            : userProfile // ignore: cast_nullable_to_non_nullable
                  as UserProfile,
        myCourses: null == myCourses
            ? _value._myCourses
            : myCourses // ignore: cast_nullable_to_non_nullable
                  as List<Course>,
        recommendedCourses: null == recommendedCourses
            ? _value._recommendedCourses
            : recommendedCourses // ignore: cast_nullable_to_non_nullable
                  as List<Course>,
        freeCourses: null == freeCourses
            ? _value._freeCourses
            : freeCourses // ignore: cast_nullable_to_non_nullable
                  as List<Course>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeDataImpl implements _HomeData {
  const _$HomeDataImpl({
    required this.userProfile,
    final List<Course> myCourses = const [],
    final List<Course> recommendedCourses = const [],
    final List<Course> freeCourses = const [],
  }) : _myCourses = myCourses,
       _recommendedCourses = recommendedCourses,
       _freeCourses = freeCourses;

  factory _$HomeDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeDataImplFromJson(json);

  @override
  final UserProfile userProfile;
  final List<Course> _myCourses;
  @override
  @JsonKey()
  List<Course> get myCourses {
    if (_myCourses is EqualUnmodifiableListView) return _myCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myCourses);
  }

  final List<Course> _recommendedCourses;
  @override
  @JsonKey()
  List<Course> get recommendedCourses {
    if (_recommendedCourses is EqualUnmodifiableListView)
      return _recommendedCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommendedCourses);
  }

  final List<Course> _freeCourses;
  @override
  @JsonKey()
  List<Course> get freeCourses {
    if (_freeCourses is EqualUnmodifiableListView) return _freeCourses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_freeCourses);
  }

  @override
  String toString() {
    return 'HomeData(userProfile: $userProfile, myCourses: $myCourses, recommendedCourses: $recommendedCourses, freeCourses: $freeCourses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeDataImpl &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile) &&
            const DeepCollectionEquality().equals(
              other._myCourses,
              _myCourses,
            ) &&
            const DeepCollectionEquality().equals(
              other._recommendedCourses,
              _recommendedCourses,
            ) &&
            const DeepCollectionEquality().equals(
              other._freeCourses,
              _freeCourses,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userProfile,
    const DeepCollectionEquality().hash(_myCourses),
    const DeepCollectionEquality().hash(_recommendedCourses),
    const DeepCollectionEquality().hash(_freeCourses),
  );

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      __$$HomeDataImplCopyWithImpl<_$HomeDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeDataImplToJson(this);
  }
}

abstract class _HomeData implements HomeData {
  const factory _HomeData({
    required final UserProfile userProfile,
    final List<Course> myCourses,
    final List<Course> recommendedCourses,
    final List<Course> freeCourses,
  }) = _$HomeDataImpl;

  factory _HomeData.fromJson(Map<String, dynamic> json) =
      _$HomeDataImpl.fromJson;

  @override
  UserProfile get userProfile;
  @override
  List<Course> get myCourses;
  @override
  List<Course> get recommendedCourses;
  @override
  List<Course> get freeCourses;

  /// Create a copy of HomeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeDataImplCopyWith<_$HomeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
