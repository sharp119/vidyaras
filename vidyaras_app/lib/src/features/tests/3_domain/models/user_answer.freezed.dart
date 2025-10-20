// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_answer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserAnswer _$UserAnswerFromJson(Map<String, dynamic> json) {
  return _UserAnswer.fromJson(json);
}

/// @nodoc
mixin _$UserAnswer {
  int get id => throw _privateConstructorUsedError;
  String get attemptId => throw _privateConstructorUsedError;
  String get questionId => throw _privateConstructorUsedError;
  int get selectedOptionId => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get marksAwarded => throw _privateConstructorUsedError;
  DateTime get answeredAt => throw _privateConstructorUsedError;

  /// Serializes this UserAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAnswerCopyWith<UserAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAnswerCopyWith<$Res> {
  factory $UserAnswerCopyWith(
    UserAnswer value,
    $Res Function(UserAnswer) then,
  ) = _$UserAnswerCopyWithImpl<$Res, UserAnswer>;
  @useResult
  $Res call({
    int id,
    String attemptId,
    String questionId,
    int selectedOptionId,
    bool isCorrect,
    int marksAwarded,
    DateTime answeredAt,
  });
}

/// @nodoc
class _$UserAnswerCopyWithImpl<$Res, $Val extends UserAnswer>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attemptId = null,
    Object? questionId = null,
    Object? selectedOptionId = null,
    Object? isCorrect = null,
    Object? marksAwarded = null,
    Object? answeredAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            attemptId: null == attemptId
                ? _value.attemptId
                : attemptId // ignore: cast_nullable_to_non_nullable
                      as String,
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedOptionId: null == selectedOptionId
                ? _value.selectedOptionId
                : selectedOptionId // ignore: cast_nullable_to_non_nullable
                      as int,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            marksAwarded: null == marksAwarded
                ? _value.marksAwarded
                : marksAwarded // ignore: cast_nullable_to_non_nullable
                      as int,
            answeredAt: null == answeredAt
                ? _value.answeredAt
                : answeredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserAnswerImplCopyWith<$Res>
    implements $UserAnswerCopyWith<$Res> {
  factory _$$UserAnswerImplCopyWith(
    _$UserAnswerImpl value,
    $Res Function(_$UserAnswerImpl) then,
  ) = __$$UserAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String attemptId,
    String questionId,
    int selectedOptionId,
    bool isCorrect,
    int marksAwarded,
    DateTime answeredAt,
  });
}

/// @nodoc
class __$$UserAnswerImplCopyWithImpl<$Res>
    extends _$UserAnswerCopyWithImpl<$Res, _$UserAnswerImpl>
    implements _$$UserAnswerImplCopyWith<$Res> {
  __$$UserAnswerImplCopyWithImpl(
    _$UserAnswerImpl _value,
    $Res Function(_$UserAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? attemptId = null,
    Object? questionId = null,
    Object? selectedOptionId = null,
    Object? isCorrect = null,
    Object? marksAwarded = null,
    Object? answeredAt = null,
  }) {
    return _then(
      _$UserAnswerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        attemptId: null == attemptId
            ? _value.attemptId
            : attemptId // ignore: cast_nullable_to_non_nullable
                  as String,
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedOptionId: null == selectedOptionId
            ? _value.selectedOptionId
            : selectedOptionId // ignore: cast_nullable_to_non_nullable
                  as int,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        marksAwarded: null == marksAwarded
            ? _value.marksAwarded
            : marksAwarded // ignore: cast_nullable_to_non_nullable
                  as int,
        answeredAt: null == answeredAt
            ? _value.answeredAt
            : answeredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAnswerImpl implements _UserAnswer {
  const _$UserAnswerImpl({
    required this.id,
    required this.attemptId,
    required this.questionId,
    required this.selectedOptionId,
    required this.isCorrect,
    this.marksAwarded = 0,
    required this.answeredAt,
  });

  factory _$UserAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAnswerImplFromJson(json);

  @override
  final int id;
  @override
  final String attemptId;
  @override
  final String questionId;
  @override
  final int selectedOptionId;
  @override
  final bool isCorrect;
  @override
  @JsonKey()
  final int marksAwarded;
  @override
  final DateTime answeredAt;

  @override
  String toString() {
    return 'UserAnswer(id: $id, attemptId: $attemptId, questionId: $questionId, selectedOptionId: $selectedOptionId, isCorrect: $isCorrect, marksAwarded: $marksAwarded, answeredAt: $answeredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAnswerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.attemptId, attemptId) ||
                other.attemptId == attemptId) &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.marksAwarded, marksAwarded) ||
                other.marksAwarded == marksAwarded) &&
            (identical(other.answeredAt, answeredAt) ||
                other.answeredAt == answeredAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    attemptId,
    questionId,
    selectedOptionId,
    isCorrect,
    marksAwarded,
    answeredAt,
  );

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      __$$UserAnswerImplCopyWithImpl<_$UserAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAnswerImplToJson(this);
  }
}

abstract class _UserAnswer implements UserAnswer {
  const factory _UserAnswer({
    required final int id,
    required final String attemptId,
    required final String questionId,
    required final int selectedOptionId,
    required final bool isCorrect,
    final int marksAwarded,
    required final DateTime answeredAt,
  }) = _$UserAnswerImpl;

  factory _UserAnswer.fromJson(Map<String, dynamic> json) =
      _$UserAnswerImpl.fromJson;

  @override
  int get id;
  @override
  String get attemptId;
  @override
  String get questionId;
  @override
  int get selectedOptionId;
  @override
  bool get isCorrect;
  @override
  int get marksAwarded;
  @override
  DateTime get answeredAt;

  /// Create a copy of UserAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAnswerImplCopyWith<_$UserAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
