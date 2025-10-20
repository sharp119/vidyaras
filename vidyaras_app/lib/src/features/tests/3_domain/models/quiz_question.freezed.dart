// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

QuizQuestion _$QuizQuestionFromJson(Map<String, dynamic> json) {
  return _QuizQuestion.fromJson(json);
}

/// @nodoc
mixin _$QuizQuestion {
  String get id => throw _privateConstructorUsedError;
  String get quizId => throw _privateConstructorUsedError;
  int get questionNumber => throw _privateConstructorUsedError;
  ContentData get questionData =>
      throw _privateConstructorUsedError; // Flexible question content
  List<QuizOption> get options =>
      throw _privateConstructorUsedError; // List of options with flexible content
  int get correctOptionId =>
      throw _privateConstructorUsedError; // Index of correct option (0-based)
  ContentData? get explanation =>
      throw _privateConstructorUsedError; // Optional explanation with flexible content
  int get marks =>
      throw _privateConstructorUsedError; // Marks for this question
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this QuizQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizQuestionCopyWith<QuizQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizQuestionCopyWith<$Res> {
  factory $QuizQuestionCopyWith(
    QuizQuestion value,
    $Res Function(QuizQuestion) then,
  ) = _$QuizQuestionCopyWithImpl<$Res, QuizQuestion>;
  @useResult
  $Res call({
    String id,
    String quizId,
    int questionNumber,
    ContentData questionData,
    List<QuizOption> options,
    int correctOptionId,
    ContentData? explanation,
    int marks,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  $ContentDataCopyWith<$Res> get questionData;
  $ContentDataCopyWith<$Res>? get explanation;
}

/// @nodoc
class _$QuizQuestionCopyWithImpl<$Res, $Val extends QuizQuestion>
    implements $QuizQuestionCopyWith<$Res> {
  _$QuizQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? questionNumber = null,
    Object? questionData = null,
    Object? options = null,
    Object? correctOptionId = null,
    Object? explanation = freezed,
    Object? marks = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            quizId: null == quizId
                ? _value.quizId
                : quizId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionNumber: null == questionNumber
                ? _value.questionNumber
                : questionNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            questionData: null == questionData
                ? _value.questionData
                : questionData // ignore: cast_nullable_to_non_nullable
                      as ContentData,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<QuizOption>,
            correctOptionId: null == correctOptionId
                ? _value.correctOptionId
                : correctOptionId // ignore: cast_nullable_to_non_nullable
                      as int,
            explanation: freezed == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as ContentData?,
            marks: null == marks
                ? _value.marks
                : marks // ignore: cast_nullable_to_non_nullable
                      as int,
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

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentDataCopyWith<$Res> get questionData {
    return $ContentDataCopyWith<$Res>(_value.questionData, (value) {
      return _then(_value.copyWith(questionData: value) as $Val);
    });
  }

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContentDataCopyWith<$Res>? get explanation {
    if (_value.explanation == null) {
      return null;
    }

    return $ContentDataCopyWith<$Res>(_value.explanation!, (value) {
      return _then(_value.copyWith(explanation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QuizQuestionImplCopyWith<$Res>
    implements $QuizQuestionCopyWith<$Res> {
  factory _$$QuizQuestionImplCopyWith(
    _$QuizQuestionImpl value,
    $Res Function(_$QuizQuestionImpl) then,
  ) = __$$QuizQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String quizId,
    int questionNumber,
    ContentData questionData,
    List<QuizOption> options,
    int correctOptionId,
    ContentData? explanation,
    int marks,
    DateTime? createdAt,
    DateTime? updatedAt,
  });

  @override
  $ContentDataCopyWith<$Res> get questionData;
  @override
  $ContentDataCopyWith<$Res>? get explanation;
}

/// @nodoc
class __$$QuizQuestionImplCopyWithImpl<$Res>
    extends _$QuizQuestionCopyWithImpl<$Res, _$QuizQuestionImpl>
    implements _$$QuizQuestionImplCopyWith<$Res> {
  __$$QuizQuestionImplCopyWithImpl(
    _$QuizQuestionImpl _value,
    $Res Function(_$QuizQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? quizId = null,
    Object? questionNumber = null,
    Object? questionData = null,
    Object? options = null,
    Object? correctOptionId = null,
    Object? explanation = freezed,
    Object? marks = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$QuizQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        quizId: null == quizId
            ? _value.quizId
            : quizId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionNumber: null == questionNumber
            ? _value.questionNumber
            : questionNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        questionData: null == questionData
            ? _value.questionData
            : questionData // ignore: cast_nullable_to_non_nullable
                  as ContentData,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<QuizOption>,
        correctOptionId: null == correctOptionId
            ? _value.correctOptionId
            : correctOptionId // ignore: cast_nullable_to_non_nullable
                  as int,
        explanation: freezed == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as ContentData?,
        marks: null == marks
            ? _value.marks
            : marks // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$QuizQuestionImpl implements _QuizQuestion {
  const _$QuizQuestionImpl({
    required this.id,
    required this.quizId,
    required this.questionNumber,
    required this.questionData,
    required final List<QuizOption> options,
    required this.correctOptionId,
    this.explanation,
    this.marks = 1,
    this.createdAt,
    this.updatedAt,
  }) : _options = options;

  factory _$QuizQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuizQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String quizId;
  @override
  final int questionNumber;
  @override
  final ContentData questionData;
  // Flexible question content
  final List<QuizOption> _options;
  // Flexible question content
  @override
  List<QuizOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  // List of options with flexible content
  @override
  final int correctOptionId;
  // Index of correct option (0-based)
  @override
  final ContentData? explanation;
  // Optional explanation with flexible content
  @override
  @JsonKey()
  final int marks;
  // Marks for this question
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'QuizQuestion(id: $id, quizId: $quizId, questionNumber: $questionNumber, questionData: $questionData, options: $options, correctOptionId: $correctOptionId, explanation: $explanation, marks: $marks, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.quizId, quizId) || other.quizId == quizId) &&
            (identical(other.questionNumber, questionNumber) ||
                other.questionNumber == questionNumber) &&
            (identical(other.questionData, questionData) ||
                other.questionData == questionData) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctOptionId, correctOptionId) ||
                other.correctOptionId == correctOptionId) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.marks, marks) || other.marks == marks) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    quizId,
    questionNumber,
    questionData,
    const DeepCollectionEquality().hash(_options),
    correctOptionId,
    explanation,
    marks,
    createdAt,
    updatedAt,
  );

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      __$$QuizQuestionImplCopyWithImpl<_$QuizQuestionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuizQuestionImplToJson(this);
  }
}

abstract class _QuizQuestion implements QuizQuestion {
  const factory _QuizQuestion({
    required final String id,
    required final String quizId,
    required final int questionNumber,
    required final ContentData questionData,
    required final List<QuizOption> options,
    required final int correctOptionId,
    final ContentData? explanation,
    final int marks,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$QuizQuestionImpl;

  factory _QuizQuestion.fromJson(Map<String, dynamic> json) =
      _$QuizQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get quizId;
  @override
  int get questionNumber;
  @override
  ContentData get questionData; // Flexible question content
  @override
  List<QuizOption> get options; // List of options with flexible content
  @override
  int get correctOptionId; // Index of correct option (0-based)
  @override
  ContentData? get explanation; // Optional explanation with flexible content
  @override
  int get marks; // Marks for this question
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of QuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizQuestionImplCopyWith<_$QuizQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
