// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CourseReview _$CourseReviewFromJson(Map<String, dynamic> json) {
  return _CourseReview.fromJson(json);
}

/// @nodoc
mixin _$CourseReview {
  String get id => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String? get userAvatar => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String get reviewText => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this CourseReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseReviewCopyWith<CourseReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseReviewCopyWith<$Res> {
  factory $CourseReviewCopyWith(
    CourseReview value,
    $Res Function(CourseReview) then,
  ) = _$CourseReviewCopyWithImpl<$Res, CourseReview>;
  @useResult
  $Res call({
    String id,
    String userName,
    String? userAvatar,
    double rating,
    String reviewText,
    DateTime createdAt,
  });
}

/// @nodoc
class _$CourseReviewCopyWithImpl<$Res, $Val extends CourseReview>
    implements $CourseReviewCopyWith<$Res> {
  _$CourseReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? rating = null,
    Object? reviewText = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            userAvatar: freezed == userAvatar
                ? _value.userAvatar
                : userAvatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewText: null == reviewText
                ? _value.reviewText
                : reviewText // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CourseReviewImplCopyWith<$Res>
    implements $CourseReviewCopyWith<$Res> {
  factory _$$CourseReviewImplCopyWith(
    _$CourseReviewImpl value,
    $Res Function(_$CourseReviewImpl) then,
  ) = __$$CourseReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userName,
    String? userAvatar,
    double rating,
    String reviewText,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$CourseReviewImplCopyWithImpl<$Res>
    extends _$CourseReviewCopyWithImpl<$Res, _$CourseReviewImpl>
    implements _$$CourseReviewImplCopyWith<$Res> {
  __$$CourseReviewImplCopyWithImpl(
    _$CourseReviewImpl _value,
    $Res Function(_$CourseReviewImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CourseReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userName = null,
    Object? userAvatar = freezed,
    Object? rating = null,
    Object? reviewText = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$CourseReviewImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        userAvatar: freezed == userAvatar
            ? _value.userAvatar
            : userAvatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewText: null == reviewText
            ? _value.reviewText
            : reviewText // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseReviewImpl implements _CourseReview {
  const _$CourseReviewImpl({
    required this.id,
    required this.userName,
    this.userAvatar,
    required this.rating,
    required this.reviewText,
    required this.createdAt,
  });

  factory _$CourseReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseReviewImplFromJson(json);

  @override
  final String id;
  @override
  final String userName;
  @override
  final String? userAvatar;
  @override
  final double rating;
  @override
  final String reviewText;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'CourseReview(id: $id, userName: $userName, userAvatar: $userAvatar, rating: $rating, reviewText: $reviewText, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseReviewImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewText, reviewText) ||
                other.reviewText == reviewText) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userName,
    userAvatar,
    rating,
    reviewText,
    createdAt,
  );

  /// Create a copy of CourseReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseReviewImplCopyWith<_$CourseReviewImpl> get copyWith =>
      __$$CourseReviewImplCopyWithImpl<_$CourseReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseReviewImplToJson(this);
  }
}

abstract class _CourseReview implements CourseReview {
  const factory _CourseReview({
    required final String id,
    required final String userName,
    final String? userAvatar,
    required final double rating,
    required final String reviewText,
    required final DateTime createdAt,
  }) = _$CourseReviewImpl;

  factory _CourseReview.fromJson(Map<String, dynamic> json) =
      _$CourseReviewImpl.fromJson;

  @override
  String get id;
  @override
  String get userName;
  @override
  String? get userAvatar;
  @override
  double get rating;
  @override
  String get reviewText;
  @override
  DateTime get createdAt;

  /// Create a copy of CourseReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseReviewImplCopyWith<_$CourseReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
