// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enrollment_message_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EnrollmentMessageData {
  // User data
  String get userName => throw _privateConstructorUsedError;
  String get userPhone => throw _privateConstructorUsedError;
  String? get userEmail => throw _privateConstructorUsedError; // Course data
  String get courseTitle => throw _privateConstructorUsedError;
  String get instructor => throw _privateConstructorUsedError;
  String get courseType =>
      throw _privateConstructorUsedError; // 'Live Classes' or 'Recorded Course'
  // Pricing
  String get selectedPrice => throw _privateConstructorUsedError;
  bool get isFullPayment =>
      throw _privateConstructorUsedError; // Live course specific
  String? get batchName => throw _privateConstructorUsedError;
  String? get batchSchedule => throw _privateConstructorUsedError;
  String? get batchStartDate =>
      throw _privateConstructorUsedError; // Recorded course specific
  int? get accessDays => throw _privateConstructorUsedError; // Additional
  bool get isFree => throw _privateConstructorUsedError;

  /// Create a copy of EnrollmentMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnrollmentMessageDataCopyWith<EnrollmentMessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnrollmentMessageDataCopyWith<$Res> {
  factory $EnrollmentMessageDataCopyWith(
    EnrollmentMessageData value,
    $Res Function(EnrollmentMessageData) then,
  ) = _$EnrollmentMessageDataCopyWithImpl<$Res, EnrollmentMessageData>;
  @useResult
  $Res call({
    String userName,
    String userPhone,
    String? userEmail,
    String courseTitle,
    String instructor,
    String courseType,
    String selectedPrice,
    bool isFullPayment,
    String? batchName,
    String? batchSchedule,
    String? batchStartDate,
    int? accessDays,
    bool isFree,
  });
}

/// @nodoc
class _$EnrollmentMessageDataCopyWithImpl<
  $Res,
  $Val extends EnrollmentMessageData
>
    implements $EnrollmentMessageDataCopyWith<$Res> {
  _$EnrollmentMessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnrollmentMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userPhone = null,
    Object? userEmail = freezed,
    Object? courseTitle = null,
    Object? instructor = null,
    Object? courseType = null,
    Object? selectedPrice = null,
    Object? isFullPayment = null,
    Object? batchName = freezed,
    Object? batchSchedule = freezed,
    Object? batchStartDate = freezed,
    Object? accessDays = freezed,
    Object? isFree = null,
  }) {
    return _then(
      _value.copyWith(
            userName: null == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String,
            userPhone: null == userPhone
                ? _value.userPhone
                : userPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            userEmail: freezed == userEmail
                ? _value.userEmail
                : userEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            courseTitle: null == courseTitle
                ? _value.courseTitle
                : courseTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            instructor: null == instructor
                ? _value.instructor
                : instructor // ignore: cast_nullable_to_non_nullable
                      as String,
            courseType: null == courseType
                ? _value.courseType
                : courseType // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedPrice: null == selectedPrice
                ? _value.selectedPrice
                : selectedPrice // ignore: cast_nullable_to_non_nullable
                      as String,
            isFullPayment: null == isFullPayment
                ? _value.isFullPayment
                : isFullPayment // ignore: cast_nullable_to_non_nullable
                      as bool,
            batchName: freezed == batchName
                ? _value.batchName
                : batchName // ignore: cast_nullable_to_non_nullable
                      as String?,
            batchSchedule: freezed == batchSchedule
                ? _value.batchSchedule
                : batchSchedule // ignore: cast_nullable_to_non_nullable
                      as String?,
            batchStartDate: freezed == batchStartDate
                ? _value.batchStartDate
                : batchStartDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            accessDays: freezed == accessDays
                ? _value.accessDays
                : accessDays // ignore: cast_nullable_to_non_nullable
                      as int?,
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EnrollmentMessageDataImplCopyWith<$Res>
    implements $EnrollmentMessageDataCopyWith<$Res> {
  factory _$$EnrollmentMessageDataImplCopyWith(
    _$EnrollmentMessageDataImpl value,
    $Res Function(_$EnrollmentMessageDataImpl) then,
  ) = __$$EnrollmentMessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userName,
    String userPhone,
    String? userEmail,
    String courseTitle,
    String instructor,
    String courseType,
    String selectedPrice,
    bool isFullPayment,
    String? batchName,
    String? batchSchedule,
    String? batchStartDate,
    int? accessDays,
    bool isFree,
  });
}

/// @nodoc
class __$$EnrollmentMessageDataImplCopyWithImpl<$Res>
    extends
        _$EnrollmentMessageDataCopyWithImpl<$Res, _$EnrollmentMessageDataImpl>
    implements _$$EnrollmentMessageDataImplCopyWith<$Res> {
  __$$EnrollmentMessageDataImplCopyWithImpl(
    _$EnrollmentMessageDataImpl _value,
    $Res Function(_$EnrollmentMessageDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EnrollmentMessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? userPhone = null,
    Object? userEmail = freezed,
    Object? courseTitle = null,
    Object? instructor = null,
    Object? courseType = null,
    Object? selectedPrice = null,
    Object? isFullPayment = null,
    Object? batchName = freezed,
    Object? batchSchedule = freezed,
    Object? batchStartDate = freezed,
    Object? accessDays = freezed,
    Object? isFree = null,
  }) {
    return _then(
      _$EnrollmentMessageDataImpl(
        userName: null == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
        userPhone: null == userPhone
            ? _value.userPhone
            : userPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        userEmail: freezed == userEmail
            ? _value.userEmail
            : userEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        courseTitle: null == courseTitle
            ? _value.courseTitle
            : courseTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        instructor: null == instructor
            ? _value.instructor
            : instructor // ignore: cast_nullable_to_non_nullable
                  as String,
        courseType: null == courseType
            ? _value.courseType
            : courseType // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedPrice: null == selectedPrice
            ? _value.selectedPrice
            : selectedPrice // ignore: cast_nullable_to_non_nullable
                  as String,
        isFullPayment: null == isFullPayment
            ? _value.isFullPayment
            : isFullPayment // ignore: cast_nullable_to_non_nullable
                  as bool,
        batchName: freezed == batchName
            ? _value.batchName
            : batchName // ignore: cast_nullable_to_non_nullable
                  as String?,
        batchSchedule: freezed == batchSchedule
            ? _value.batchSchedule
            : batchSchedule // ignore: cast_nullable_to_non_nullable
                  as String?,
        batchStartDate: freezed == batchStartDate
            ? _value.batchStartDate
            : batchStartDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        accessDays: freezed == accessDays
            ? _value.accessDays
            : accessDays // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$EnrollmentMessageDataImpl extends _EnrollmentMessageData {
  const _$EnrollmentMessageDataImpl({
    required this.userName,
    required this.userPhone,
    this.userEmail,
    required this.courseTitle,
    required this.instructor,
    required this.courseType,
    required this.selectedPrice,
    required this.isFullPayment,
    this.batchName,
    this.batchSchedule,
    this.batchStartDate,
    this.accessDays,
    this.isFree = false,
  }) : super._();

  // User data
  @override
  final String userName;
  @override
  final String userPhone;
  @override
  final String? userEmail;
  // Course data
  @override
  final String courseTitle;
  @override
  final String instructor;
  @override
  final String courseType;
  // 'Live Classes' or 'Recorded Course'
  // Pricing
  @override
  final String selectedPrice;
  @override
  final bool isFullPayment;
  // Live course specific
  @override
  final String? batchName;
  @override
  final String? batchSchedule;
  @override
  final String? batchStartDate;
  // Recorded course specific
  @override
  final int? accessDays;
  // Additional
  @override
  @JsonKey()
  final bool isFree;

  @override
  String toString() {
    return 'EnrollmentMessageData(userName: $userName, userPhone: $userPhone, userEmail: $userEmail, courseTitle: $courseTitle, instructor: $instructor, courseType: $courseType, selectedPrice: $selectedPrice, isFullPayment: $isFullPayment, batchName: $batchName, batchSchedule: $batchSchedule, batchStartDate: $batchStartDate, accessDays: $accessDays, isFree: $isFree)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrollmentMessageDataImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPhone, userPhone) ||
                other.userPhone == userPhone) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.courseTitle, courseTitle) ||
                other.courseTitle == courseTitle) &&
            (identical(other.instructor, instructor) ||
                other.instructor == instructor) &&
            (identical(other.courseType, courseType) ||
                other.courseType == courseType) &&
            (identical(other.selectedPrice, selectedPrice) ||
                other.selectedPrice == selectedPrice) &&
            (identical(other.isFullPayment, isFullPayment) ||
                other.isFullPayment == isFullPayment) &&
            (identical(other.batchName, batchName) ||
                other.batchName == batchName) &&
            (identical(other.batchSchedule, batchSchedule) ||
                other.batchSchedule == batchSchedule) &&
            (identical(other.batchStartDate, batchStartDate) ||
                other.batchStartDate == batchStartDate) &&
            (identical(other.accessDays, accessDays) ||
                other.accessDays == accessDays) &&
            (identical(other.isFree, isFree) || other.isFree == isFree));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userName,
    userPhone,
    userEmail,
    courseTitle,
    instructor,
    courseType,
    selectedPrice,
    isFullPayment,
    batchName,
    batchSchedule,
    batchStartDate,
    accessDays,
    isFree,
  );

  /// Create a copy of EnrollmentMessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrollmentMessageDataImplCopyWith<_$EnrollmentMessageDataImpl>
  get copyWith =>
      __$$EnrollmentMessageDataImplCopyWithImpl<_$EnrollmentMessageDataImpl>(
        this,
        _$identity,
      );
}

abstract class _EnrollmentMessageData extends EnrollmentMessageData {
  const factory _EnrollmentMessageData({
    required final String userName,
    required final String userPhone,
    final String? userEmail,
    required final String courseTitle,
    required final String instructor,
    required final String courseType,
    required final String selectedPrice,
    required final bool isFullPayment,
    final String? batchName,
    final String? batchSchedule,
    final String? batchStartDate,
    final int? accessDays,
    final bool isFree,
  }) = _$EnrollmentMessageDataImpl;
  const _EnrollmentMessageData._() : super._();

  // User data
  @override
  String get userName;
  @override
  String get userPhone;
  @override
  String? get userEmail; // Course data
  @override
  String get courseTitle;
  @override
  String get instructor;
  @override
  String get courseType; // 'Live Classes' or 'Recorded Course'
  // Pricing
  @override
  String get selectedPrice;
  @override
  bool get isFullPayment; // Live course specific
  @override
  String? get batchName;
  @override
  String? get batchSchedule;
  @override
  String? get batchStartDate; // Recorded course specific
  @override
  int? get accessDays; // Additional
  @override
  bool get isFree;

  /// Create a copy of EnrollmentMessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrollmentMessageDataImplCopyWith<_$EnrollmentMessageDataImpl>
  get copyWith => throw _privateConstructorUsedError;
}
