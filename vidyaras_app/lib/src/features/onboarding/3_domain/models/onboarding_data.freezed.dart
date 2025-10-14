// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OnboardingData _$OnboardingDataFromJson(Map<String, dynamic> json) {
  return _OnboardingData.fromJson(json);
}

/// @nodoc
mixin _$OnboardingData {
  /// Selected interests (Music, Wellness, Yoga, etc.)
  List<Interest> get interests => throw _privateConstructorUsedError;

  /// Selected learning goals (Hobby, Professional, etc.)
  List<LearningGoal> get learningGoals => throw _privateConstructorUsedError;

  /// Selected experience level
  ExperienceLevel get experienceLevel => throw _privateConstructorUsedError;

  /// Selected language preference
  LanguagePreference get languagePreference =>
      throw _privateConstructorUsedError;

  /// Timestamp when onboarding was completed
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this OnboardingData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingDataCopyWith<OnboardingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingDataCopyWith<$Res> {
  factory $OnboardingDataCopyWith(
    OnboardingData value,
    $Res Function(OnboardingData) then,
  ) = _$OnboardingDataCopyWithImpl<$Res, OnboardingData>;
  @useResult
  $Res call({
    List<Interest> interests,
    List<LearningGoal> learningGoals,
    ExperienceLevel experienceLevel,
    LanguagePreference languagePreference,
    DateTime? completedAt,
  });
}

/// @nodoc
class _$OnboardingDataCopyWithImpl<$Res, $Val extends OnboardingData>
    implements $OnboardingDataCopyWith<$Res> {
  _$OnboardingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interests = null,
    Object? learningGoals = null,
    Object? experienceLevel = null,
    Object? languagePreference = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            interests: null == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<Interest>,
            learningGoals: null == learningGoals
                ? _value.learningGoals
                : learningGoals // ignore: cast_nullable_to_non_nullable
                      as List<LearningGoal>,
            experienceLevel: null == experienceLevel
                ? _value.experienceLevel
                : experienceLevel // ignore: cast_nullable_to_non_nullable
                      as ExperienceLevel,
            languagePreference: null == languagePreference
                ? _value.languagePreference
                : languagePreference // ignore: cast_nullable_to_non_nullable
                      as LanguagePreference,
            completedAt: freezed == completedAt
                ? _value.completedAt
                : completedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingDataImplCopyWith<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  factory _$$OnboardingDataImplCopyWith(
    _$OnboardingDataImpl value,
    $Res Function(_$OnboardingDataImpl) then,
  ) = __$$OnboardingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Interest> interests,
    List<LearningGoal> learningGoals,
    ExperienceLevel experienceLevel,
    LanguagePreference languagePreference,
    DateTime? completedAt,
  });
}

/// @nodoc
class __$$OnboardingDataImplCopyWithImpl<$Res>
    extends _$OnboardingDataCopyWithImpl<$Res, _$OnboardingDataImpl>
    implements _$$OnboardingDataImplCopyWith<$Res> {
  __$$OnboardingDataImplCopyWithImpl(
    _$OnboardingDataImpl _value,
    $Res Function(_$OnboardingDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interests = null,
    Object? learningGoals = null,
    Object? experienceLevel = null,
    Object? languagePreference = null,
    Object? completedAt = freezed,
  }) {
    return _then(
      _$OnboardingDataImpl(
        interests: null == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<Interest>,
        learningGoals: null == learningGoals
            ? _value._learningGoals
            : learningGoals // ignore: cast_nullable_to_non_nullable
                  as List<LearningGoal>,
        experienceLevel: null == experienceLevel
            ? _value.experienceLevel
            : experienceLevel // ignore: cast_nullable_to_non_nullable
                  as ExperienceLevel,
        languagePreference: null == languagePreference
            ? _value.languagePreference
            : languagePreference // ignore: cast_nullable_to_non_nullable
                  as LanguagePreference,
        completedAt: freezed == completedAt
            ? _value.completedAt
            : completedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingDataImpl implements _OnboardingData {
  const _$OnboardingDataImpl({
    required final List<Interest> interests,
    required final List<LearningGoal> learningGoals,
    required this.experienceLevel,
    required this.languagePreference,
    this.completedAt,
  }) : _interests = interests,
       _learningGoals = learningGoals;

  factory _$OnboardingDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingDataImplFromJson(json);

  /// Selected interests (Music, Wellness, Yoga, etc.)
  final List<Interest> _interests;

  /// Selected interests (Music, Wellness, Yoga, etc.)
  @override
  List<Interest> get interests {
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interests);
  }

  /// Selected learning goals (Hobby, Professional, etc.)
  final List<LearningGoal> _learningGoals;

  /// Selected learning goals (Hobby, Professional, etc.)
  @override
  List<LearningGoal> get learningGoals {
    if (_learningGoals is EqualUnmodifiableListView) return _learningGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_learningGoals);
  }

  /// Selected experience level
  @override
  final ExperienceLevel experienceLevel;

  /// Selected language preference
  @override
  final LanguagePreference languagePreference;

  /// Timestamp when onboarding was completed
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'OnboardingData(interests: $interests, learningGoals: $learningGoals, experienceLevel: $experienceLevel, languagePreference: $languagePreference, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingDataImpl &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            const DeepCollectionEquality().equals(
              other._learningGoals,
              _learningGoals,
            ) &&
            (identical(other.experienceLevel, experienceLevel) ||
                other.experienceLevel == experienceLevel) &&
            (identical(other.languagePreference, languagePreference) ||
                other.languagePreference == languagePreference) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_interests),
    const DeepCollectionEquality().hash(_learningGoals),
    experienceLevel,
    languagePreference,
    completedAt,
  );

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingDataImplCopyWith<_$OnboardingDataImpl> get copyWith =>
      __$$OnboardingDataImplCopyWithImpl<_$OnboardingDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingDataImplToJson(this);
  }
}

abstract class _OnboardingData implements OnboardingData {
  const factory _OnboardingData({
    required final List<Interest> interests,
    required final List<LearningGoal> learningGoals,
    required final ExperienceLevel experienceLevel,
    required final LanguagePreference languagePreference,
    final DateTime? completedAt,
  }) = _$OnboardingDataImpl;

  factory _OnboardingData.fromJson(Map<String, dynamic> json) =
      _$OnboardingDataImpl.fromJson;

  /// Selected interests (Music, Wellness, Yoga, etc.)
  @override
  List<Interest> get interests;

  /// Selected learning goals (Hobby, Professional, etc.)
  @override
  List<LearningGoal> get learningGoals;

  /// Selected experience level
  @override
  ExperienceLevel get experienceLevel;

  /// Selected language preference
  @override
  LanguagePreference get languagePreference;

  /// Timestamp when onboarding was completed
  @override
  DateTime? get completedAt;

  /// Create a copy of OnboardingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingDataImplCopyWith<_$OnboardingDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
