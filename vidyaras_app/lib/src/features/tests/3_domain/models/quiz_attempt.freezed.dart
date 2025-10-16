// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizAttempt _$QuizAttemptFromJson(Map<String, dynamic> json) {
  return _QuizAttempt.fromJson(json);
}

/// @nodoc
mixin _$QuizAttempt {
  String get testId => throw _privateConstructorUsedError;
  String get testTitle => throw _privateConstructorUsedError;
  List<Question> get questions => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  Map<int, int>? get userAnswers => throw _privateConstructorUsedError;

  /// Serializes this QuizAttempt to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizAttemptCopyWith<QuizAttempt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizAttemptCopyWith<$Res> {
  factory $QuizAttemptCopyWith(
    QuizAttempt value,
    $Res Function(QuizAttempt) then,
  ) = _$QuizAttemptCopyWithImpl<$Res, QuizAttempt>;
  @useResult
  $Res call({
    String testId,
    String testTitle,
    List<Question> questions,
    int currentQuestionIndex,
    int totalQuestions,
    int durationMinutes,
    DateTime startTime,
    DateTime? endTime,
    Map<int, int>? userAnswers,
  });
}

/// @nodoc
class _$QuizAttemptCopyWithImpl<$Res, $Val extends QuizAttempt>
    implements $QuizAttemptCopyWith<$Res> {
  _$QuizAttemptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? testTitle = null,
    Object? questions = null,
    Object? currentQuestionIndex = null,
    Object? totalQuestions = null,
    Object? durationMinutes = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? userAnswers = freezed,
  }) {
    return _then(
      _value.copyWith(
            testId: null == testId
                ? _value.testId
                : testId // ignore: cast_nullable_to_non_nullable
                      as String,
            testTitle: null == testTitle
                ? _value.testTitle
                : testTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            questions: null == questions
                ? _value.questions
                : questions // ignore: cast_nullable_to_non_nullable
                      as List<Question>,
            currentQuestionIndex: null == currentQuestionIndex
                ? _value.currentQuestionIndex
                : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            durationMinutes: null == durationMinutes
                ? _value.durationMinutes
                : durationMinutes // ignore: cast_nullable_to_non_nullable
                      as int,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endTime: freezed == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            userAnswers: freezed == userAnswers
                ? _value.userAnswers
                : userAnswers // ignore: cast_nullable_to_non_nullable
                      as Map<int, int>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuizAttemptImplCopyWith<$Res>
    implements $QuizAttemptCopyWith<$Res> {
  factory _$$QuizAttemptImplCopyWith(
    _$QuizAttemptImpl value,
    $Res Function(_$QuizAttemptImpl) then,
  ) = __$$QuizAttemptImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String testId,
    String testTitle,
    List<Question> questions,
    int currentQuestionIndex,
    int totalQuestions,
    int durationMinutes,
    DateTime startTime,
    DateTime? endTime,
    Map<int, int>? userAnswers,
  });
}

/// @nodoc
class __$$QuizAttemptImplCopyWithImpl<$Res>
    extends _$QuizAttemptCopyWithImpl<$Res, _$QuizAttemptImpl>
    implements _$$QuizAttemptImplCopyWith<$Res> {
  __$$QuizAttemptImplCopyWithImpl(
    _$QuizAttemptImpl _value,
    $Res Function(_$QuizAttemptImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testId = null,
    Object? testTitle = null,
    Object? questions = null,
    Object? currentQuestionIndex = null,
    Object? totalQuestions = null,
    Object? durationMinutes = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? userAnswers = freezed,
  }) {
    return _then(
      _$QuizAttemptImpl(
        testId: null == testId
            ? _value.testId
            : testId // ignore: cast_nullable_to_non_nullable
                  as String,
        testTitle: null == testTitle
            ? _value.testTitle
            : testTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        questions: null == questions
            ? _value._questions
            : questions // ignore: cast_nullable_to_non_nullable
                  as List<Question>,
        currentQuestionIndex: null == currentQuestionIndex
            ? _value.currentQuestionIndex
            : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        durationMinutes: null == durationMinutes
            ? _value.durationMinutes
            : durationMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endTime: freezed == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        userAnswers: freezed == userAnswers
            ? _value._userAnswers
            : userAnswers // ignore: cast_nullable_to_non_nullable
                  as Map<int, int>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$QuizAttemptImpl extends _QuizAttempt {
  const _$QuizAttemptImpl({
    required this.testId,
    required this.testTitle,
    required final List<Question> questions,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.durationMinutes,
    required this.startTime,
    this.endTime,
    final Map<int, int>? userAnswers,
  }) : _questions = questions,
       _userAnswers = userAnswers,
       super._();

  factory _$QuizAttemptImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizAttemptImplFromJson(json);

  @override
  final String testId;
  @override
  final String testTitle;
  final List<Question> _questions;
  @override
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final int currentQuestionIndex;
  @override
  final int totalQuestions;
  @override
  final int durationMinutes;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  final Map<int, int>? _userAnswers;
  @override
  Map<int, int>? get userAnswers {
    final value = _userAnswers;
    if (value == null) return null;
    if (_userAnswers is EqualUnmodifiableMapView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'QuizAttempt(testId: $testId, testTitle: $testTitle, questions: $questions, currentQuestionIndex: $currentQuestionIndex, totalQuestions: $totalQuestions, durationMinutes: $durationMinutes, startTime: $startTime, endTime: $endTime, userAnswers: $userAnswers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizAttemptImpl &&
            (identical(other.testId, testId) || other.testId == testId) &&
            (identical(other.testTitle, testTitle) ||
                other.testTitle == testTitle) &&
            const DeepCollectionEquality().equals(
              other._questions,
              _questions,
            ) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality().equals(
              other._userAnswers,
              _userAnswers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    testId,
    testTitle,
    const DeepCollectionEquality().hash(_questions),
    currentQuestionIndex,
    totalQuestions,
    durationMinutes,
    startTime,
    endTime,
    const DeepCollectionEquality().hash(_userAnswers),
  );

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizAttemptImplCopyWith<_$QuizAttemptImpl> get copyWith =>
      __$$QuizAttemptImplCopyWithImpl<_$QuizAttemptImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizAttemptImplToJson(this);
  }
}

abstract class _QuizAttempt extends QuizAttempt {
  const factory _QuizAttempt({
    required final String testId,
    required final String testTitle,
    required final List<Question> questions,
    required final int currentQuestionIndex,
    required final int totalQuestions,
    required final int durationMinutes,
    required final DateTime startTime,
    final DateTime? endTime,
    final Map<int, int>? userAnswers,
  }) = _$QuizAttemptImpl;
  const _QuizAttempt._() : super._();

  factory _QuizAttempt.fromJson(Map<String, dynamic> json) =
      _$QuizAttemptImpl.fromJson;

  @override
  String get testId;
  @override
  String get testTitle;
  @override
  List<Question> get questions;
  @override
  int get currentQuestionIndex;
  @override
  int get totalQuestions;
  @override
  int get durationMinutes;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  Map<int, int>? get userAnswers;

  /// Create a copy of QuizAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizAttemptImplCopyWith<_$QuizAttemptImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
