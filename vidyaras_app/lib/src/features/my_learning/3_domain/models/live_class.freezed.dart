// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_class.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LiveClass _$LiveClassFromJson(Map<String, dynamic> json) {
  return _LiveClass.fromJson(json);
}

/// @nodoc
mixin _$LiveClass {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String? get lectureId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  int get durationMinutes => throw _privateConstructorUsedError;
  String get zoomLink => throw _privateConstructorUsedError;
  String? get meetingId => throw _privateConstructorUsedError;
  String? get passcode => throw _privateConstructorUsedError;
  String? get recordingUrl => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // completed, upcoming, live
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this LiveClass to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LiveClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LiveClassCopyWith<LiveClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiveClassCopyWith<$Res> {
  factory $LiveClassCopyWith(LiveClass value, $Res Function(LiveClass) then) =
      _$LiveClassCopyWithImpl<$Res, LiveClass>;
  @useResult
  $Res call({
    String id,
    String courseId,
    String? lectureId,
    String title,
    String? description,
    DateTime scheduledAt,
    int durationMinutes,
    String zoomLink,
    String? meetingId,
    String? passcode,
    String? recordingUrl,
    String status,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$LiveClassCopyWithImpl<$Res, $Val extends LiveClass>
    implements $LiveClassCopyWith<$Res> {
  _$LiveClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LiveClass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? lectureId = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? scheduledAt = null,
    Object? durationMinutes = null,
    Object? zoomLink = null,
    Object? meetingId = freezed,
    Object? passcode = freezed,
    Object? recordingUrl = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            courseId: null == courseId
                ? _value.courseId
                : courseId // ignore: cast_nullable_to_non_nullable
                      as String,
            lectureId: freezed == lectureId
                ? _value.lectureId
                : lectureId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            passcode: freezed == passcode
                ? _value.passcode
                : passcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            recordingUrl: freezed == recordingUrl
                ? _value.recordingUrl
                : recordingUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LiveClassImplCopyWith<$Res>
    implements $LiveClassCopyWith<$Res> {
  factory _$$LiveClassImplCopyWith(
    _$LiveClassImpl value,
    $Res Function(_$LiveClassImpl) then,
  ) = __$$LiveClassImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String courseId,
    String? lectureId,
    String title,
    String? description,
    DateTime scheduledAt,
    int durationMinutes,
    String zoomLink,
    String? meetingId,
    String? passcode,
    String? recordingUrl,
    String status,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$LiveClassImplCopyWithImpl<$Res>
    extends _$LiveClassCopyWithImpl<$Res, _$LiveClassImpl>
    implements _$$LiveClassImplCopyWith<$Res> {
  __$$LiveClassImplCopyWithImpl(
    _$LiveClassImpl _value,
    $Res Function(_$LiveClassImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LiveClass
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? lectureId = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? scheduledAt = null,
    Object? durationMinutes = null,
    Object? zoomLink = null,
    Object? meetingId = freezed,
    Object? passcode = freezed,
    Object? recordingUrl = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$LiveClassImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        courseId: null == courseId
            ? _value.courseId
            : courseId // ignore: cast_nullable_to_non_nullable
                  as String,
        lectureId: freezed == lectureId
            ? _value.lectureId
            : lectureId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        passcode: freezed == passcode
            ? _value.passcode
            : passcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        recordingUrl: freezed == recordingUrl
            ? _value.recordingUrl
            : recordingUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LiveClassImpl implements _LiveClass {
  const _$LiveClassImpl({
    required this.id,
    required this.courseId,
    this.lectureId,
    required this.title,
    this.description,
    required this.scheduledAt,
    this.durationMinutes = 120,
    required this.zoomLink,
    this.meetingId,
    this.passcode,
    this.recordingUrl,
    this.status = 'upcoming',
    this.createdAt,
  });

  factory _$LiveClassImpl.fromJson(Map<String, dynamic> json) =>
      _$$LiveClassImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String? lectureId;
  @override
  final String title;
  @override
  final String? description;
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
  final String? passcode;
  @override
  final String? recordingUrl;
  @override
  @JsonKey()
  final String status;
  // completed, upcoming, live
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'LiveClass(id: $id, courseId: $courseId, lectureId: $lectureId, title: $title, description: $description, scheduledAt: $scheduledAt, durationMinutes: $durationMinutes, zoomLink: $zoomLink, meetingId: $meetingId, passcode: $passcode, recordingUrl: $recordingUrl, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LiveClassImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.lectureId, lectureId) ||
                other.lectureId == lectureId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.durationMinutes, durationMinutes) ||
                other.durationMinutes == durationMinutes) &&
            (identical(other.zoomLink, zoomLink) ||
                other.zoomLink == zoomLink) &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.passcode, passcode) ||
                other.passcode == passcode) &&
            (identical(other.recordingUrl, recordingUrl) ||
                other.recordingUrl == recordingUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    courseId,
    lectureId,
    title,
    description,
    scheduledAt,
    durationMinutes,
    zoomLink,
    meetingId,
    passcode,
    recordingUrl,
    status,
    createdAt,
  );

  /// Create a copy of LiveClass
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LiveClassImplCopyWith<_$LiveClassImpl> get copyWith =>
      __$$LiveClassImplCopyWithImpl<_$LiveClassImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LiveClassImplToJson(this);
  }
}

abstract class _LiveClass implements LiveClass {
  const factory _LiveClass({
    required final String id,
    required final String courseId,
    final String? lectureId,
    required final String title,
    final String? description,
    required final DateTime scheduledAt,
    final int durationMinutes,
    required final String zoomLink,
    final String? meetingId,
    final String? passcode,
    final String? recordingUrl,
    final String status,
    final DateTime? createdAt,
  }) = _$LiveClassImpl;

  factory _LiveClass.fromJson(Map<String, dynamic> json) =
      _$LiveClassImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String? get lectureId;
  @override
  String get title;
  @override
  String? get description;
  @override
  DateTime get scheduledAt;
  @override
  int get durationMinutes;
  @override
  String get zoomLink;
  @override
  String? get meetingId;
  @override
  String? get passcode;
  @override
  String? get recordingUrl;
  @override
  String get status; // completed, upcoming, live
  @override
  DateTime? get createdAt;

  /// Create a copy of LiveClass
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LiveClassImplCopyWith<_$LiveClassImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
