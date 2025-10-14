// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingState {
  /// Selected interests (Step 1)
  List<Interest> get selectedInterests => throw _privateConstructorUsedError;

  /// Selected learning goals (Step 2)
  List<LearningGoal> get selectedGoals => throw _privateConstructorUsedError;

  /// Selected experience level (Step 3)
  ExperienceLevel? get selectedExperienceLevel =>
      throw _privateConstructorUsedError;

  /// Selected language preference (Step 4)
  LanguagePreference? get selectedLanguagePreference =>
      throw _privateConstructorUsedError;

  /// Current step in the onboarding flow (1-4)
  int get currentStep => throw _privateConstructorUsedError;

  /// Loading state for save operation
  bool get isSaving => throw _privateConstructorUsedError;

  /// Error message if save fails
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
    OnboardingState value,
    $Res Function(OnboardingState) then,
  ) = _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call({
    List<Interest> selectedInterests,
    List<LearningGoal> selectedGoals,
    ExperienceLevel? selectedExperienceLevel,
    LanguagePreference? selectedLanguagePreference,
    int currentStep,
    bool isSaving,
    String? errorMessage,
  });
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedInterests = null,
    Object? selectedGoals = null,
    Object? selectedExperienceLevel = freezed,
    Object? selectedLanguagePreference = freezed,
    Object? currentStep = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedInterests: null == selectedInterests
                ? _value.selectedInterests
                : selectedInterests // ignore: cast_nullable_to_non_nullable
                      as List<Interest>,
            selectedGoals: null == selectedGoals
                ? _value.selectedGoals
                : selectedGoals // ignore: cast_nullable_to_non_nullable
                      as List<LearningGoal>,
            selectedExperienceLevel: freezed == selectedExperienceLevel
                ? _value.selectedExperienceLevel
                : selectedExperienceLevel // ignore: cast_nullable_to_non_nullable
                      as ExperienceLevel?,
            selectedLanguagePreference: freezed == selectedLanguagePreference
                ? _value.selectedLanguagePreference
                : selectedLanguagePreference // ignore: cast_nullable_to_non_nullable
                      as LanguagePreference?,
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OnboardingStateImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$OnboardingStateImplCopyWith(
    _$OnboardingStateImpl value,
    $Res Function(_$OnboardingStateImpl) then,
  ) = __$$OnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Interest> selectedInterests,
    List<LearningGoal> selectedGoals,
    ExperienceLevel? selectedExperienceLevel,
    LanguagePreference? selectedLanguagePreference,
    int currentStep,
    bool isSaving,
    String? errorMessage,
  });
}

/// @nodoc
class __$$OnboardingStateImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingStateImpl>
    implements _$$OnboardingStateImplCopyWith<$Res> {
  __$$OnboardingStateImplCopyWithImpl(
    _$OnboardingStateImpl _value,
    $Res Function(_$OnboardingStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedInterests = null,
    Object? selectedGoals = null,
    Object? selectedExperienceLevel = freezed,
    Object? selectedLanguagePreference = freezed,
    Object? currentStep = null,
    Object? isSaving = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$OnboardingStateImpl(
        selectedInterests: null == selectedInterests
            ? _value._selectedInterests
            : selectedInterests // ignore: cast_nullable_to_non_nullable
                  as List<Interest>,
        selectedGoals: null == selectedGoals
            ? _value._selectedGoals
            : selectedGoals // ignore: cast_nullable_to_non_nullable
                  as List<LearningGoal>,
        selectedExperienceLevel: freezed == selectedExperienceLevel
            ? _value.selectedExperienceLevel
            : selectedExperienceLevel // ignore: cast_nullable_to_non_nullable
                  as ExperienceLevel?,
        selectedLanguagePreference: freezed == selectedLanguagePreference
            ? _value.selectedLanguagePreference
            : selectedLanguagePreference // ignore: cast_nullable_to_non_nullable
                  as LanguagePreference?,
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OnboardingStateImpl extends _OnboardingState {
  const _$OnboardingStateImpl({
    final List<Interest> selectedInterests = const [],
    final List<LearningGoal> selectedGoals = const [],
    this.selectedExperienceLevel,
    this.selectedLanguagePreference,
    this.currentStep = 1,
    this.isSaving = false,
    this.errorMessage,
  }) : _selectedInterests = selectedInterests,
       _selectedGoals = selectedGoals,
       super._();

  /// Selected interests (Step 1)
  final List<Interest> _selectedInterests;

  /// Selected interests (Step 1)
  @override
  @JsonKey()
  List<Interest> get selectedInterests {
    if (_selectedInterests is EqualUnmodifiableListView)
      return _selectedInterests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedInterests);
  }

  /// Selected learning goals (Step 2)
  final List<LearningGoal> _selectedGoals;

  /// Selected learning goals (Step 2)
  @override
  @JsonKey()
  List<LearningGoal> get selectedGoals {
    if (_selectedGoals is EqualUnmodifiableListView) return _selectedGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedGoals);
  }

  /// Selected experience level (Step 3)
  @override
  final ExperienceLevel? selectedExperienceLevel;

  /// Selected language preference (Step 4)
  @override
  final LanguagePreference? selectedLanguagePreference;

  /// Current step in the onboarding flow (1-4)
  @override
  @JsonKey()
  final int currentStep;

  /// Loading state for save operation
  @override
  @JsonKey()
  final bool isSaving;

  /// Error message if save fails
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'OnboardingState(selectedInterests: $selectedInterests, selectedGoals: $selectedGoals, selectedExperienceLevel: $selectedExperienceLevel, selectedLanguagePreference: $selectedLanguagePreference, currentStep: $currentStep, isSaving: $isSaving, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            const DeepCollectionEquality().equals(
              other._selectedInterests,
              _selectedInterests,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedGoals,
              _selectedGoals,
            ) &&
            (identical(
                  other.selectedExperienceLevel,
                  selectedExperienceLevel,
                ) ||
                other.selectedExperienceLevel == selectedExperienceLevel) &&
            (identical(
                  other.selectedLanguagePreference,
                  selectedLanguagePreference,
                ) ||
                other.selectedLanguagePreference ==
                    selectedLanguagePreference) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_selectedInterests),
    const DeepCollectionEquality().hash(_selectedGoals),
    selectedExperienceLevel,
    selectedLanguagePreference,
    currentStep,
    isSaving,
    errorMessage,
  );

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      __$$OnboardingStateImplCopyWithImpl<_$OnboardingStateImpl>(
        this,
        _$identity,
      );
}

abstract class _OnboardingState extends OnboardingState {
  const factory _OnboardingState({
    final List<Interest> selectedInterests,
    final List<LearningGoal> selectedGoals,
    final ExperienceLevel? selectedExperienceLevel,
    final LanguagePreference? selectedLanguagePreference,
    final int currentStep,
    final bool isSaving,
    final String? errorMessage,
  }) = _$OnboardingStateImpl;
  const _OnboardingState._() : super._();

  /// Selected interests (Step 1)
  @override
  List<Interest> get selectedInterests;

  /// Selected learning goals (Step 2)
  @override
  List<LearningGoal> get selectedGoals;

  /// Selected experience level (Step 3)
  @override
  ExperienceLevel? get selectedExperienceLevel;

  /// Selected language preference (Step 4)
  @override
  LanguagePreference? get selectedLanguagePreference;

  /// Current step in the onboarding flow (1-4)
  @override
  int get currentStep;

  /// Loading state for save operation
  @override
  bool get isSaving;

  /// Error message if save fails
  @override
  String? get errorMessage;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
