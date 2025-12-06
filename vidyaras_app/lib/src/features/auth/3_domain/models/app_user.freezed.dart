// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  /// User ID (matches auth.users.id)
  String get id => throw _privateConstructorUsedError;

  /// Email from Google OAuth
  String? get email => throw _privateConstructorUsedError;

  /// Full name from Google OAuth metadata
  String? get fullName => throw _privateConstructorUsedError;

  /// Display name (same as fullName)
  String? get name => throw _privateConstructorUsedError;

  /// Avatar URL from Google OAuth
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Phone number (E.164 format, e.g., +911234567890)
  /// Verified via MSG91 OTP
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Whether user has completed onboarding
  bool get isOnboarded => throw _privateConstructorUsedError;

  /// Onboarding preferences (interests, goals, experience, language)
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;

  /// User role (student, teacher, admin)
  String get role => throw _privateConstructorUsedError;

  /// Created timestamp
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Updated timestamp
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call({
    String id,
    String? email,
    String? fullName,
    String? name,
    String? avatarUrl,
    String? phoneNumber,
    bool isOnboarded,
    Map<String, dynamic> preferences,
    String role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? fullName = freezed,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? isOnboarded = null,
    Object? preferences = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            phoneNumber: freezed == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            isOnboarded: null == isOnboarded
                ? _value.isOnboarded
                : isOnboarded // ignore: cast_nullable_to_non_nullable
                      as bool,
            preferences: null == preferences
                ? _value.preferences
                : preferences // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
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
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
    _$AppUserImpl value,
    $Res Function(_$AppUserImpl) then,
  ) = __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? email,
    String? fullName,
    String? name,
    String? avatarUrl,
    String? phoneNumber,
    bool isOnboarded,
    Map<String, dynamic> preferences,
    String role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
    _$AppUserImpl _value,
    $Res Function(_$AppUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = freezed,
    Object? fullName = freezed,
    Object? name = freezed,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? isOnboarded = null,
    Object? preferences = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$AppUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        phoneNumber: freezed == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        isOnboarded: null == isOnboarded
            ? _value.isOnboarded
            : isOnboarded // ignore: cast_nullable_to_non_nullable
                  as bool,
        preferences: null == preferences
            ? _value._preferences
            : preferences // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$AppUserImpl implements _AppUser {
  const _$AppUserImpl({
    required this.id,
    required this.email,
    required this.fullName,
    required this.name,
    required this.avatarUrl,
    this.phoneNumber,
    this.isOnboarded = false,
    final Map<String, dynamic> preferences = const {},
    this.role = 'student',
    this.createdAt,
    this.updatedAt,
  }) : _preferences = preferences;

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  /// User ID (matches auth.users.id)
  @override
  final String id;

  /// Email from Google OAuth
  @override
  final String? email;

  /// Full name from Google OAuth metadata
  @override
  final String? fullName;

  /// Display name (same as fullName)
  @override
  final String? name;

  /// Avatar URL from Google OAuth
  @override
  final String? avatarUrl;

  /// Phone number (E.164 format, e.g., +911234567890)
  /// Verified via MSG91 OTP
  @override
  final String? phoneNumber;

  /// Whether user has completed onboarding
  @override
  @JsonKey()
  final bool isOnboarded;

  /// Onboarding preferences (interests, goals, experience, language)
  final Map<String, dynamic> _preferences;

  /// Onboarding preferences (interests, goals, experience, language)
  @override
  @JsonKey()
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  /// User role (student, teacher, admin)
  @override
  @JsonKey()
  final String role;

  /// Created timestamp
  @override
  final DateTime? createdAt;

  /// Updated timestamp
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, fullName: $fullName, name: $name, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, isOnboarded: $isOnboarded, preferences: $preferences, role: $role, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isOnboarded, isOnboarded) ||
                other.isOnboarded == isOnboarded) &&
            const DeepCollectionEquality().equals(
              other._preferences,
              _preferences,
            ) &&
            (identical(other.role, role) || other.role == role) &&
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
    email,
    fullName,
    name,
    avatarUrl,
    phoneNumber,
    isOnboarded,
    const DeepCollectionEquality().hash(_preferences),
    role,
    createdAt,
    updatedAt,
  );

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(this);
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser({
    required final String id,
    required final String? email,
    required final String? fullName,
    required final String? name,
    required final String? avatarUrl,
    final String? phoneNumber,
    final bool isOnboarded,
    final Map<String, dynamic> preferences,
    final String role,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  /// User ID (matches auth.users.id)
  @override
  String get id;

  /// Email from Google OAuth
  @override
  String? get email;

  /// Full name from Google OAuth metadata
  @override
  String? get fullName;

  /// Display name (same as fullName)
  @override
  String? get name;

  /// Avatar URL from Google OAuth
  @override
  String? get avatarUrl;

  /// Phone number (E.164 format, e.g., +911234567890)
  /// Verified via MSG91 OTP
  @override
  String? get phoneNumber;

  /// Whether user has completed onboarding
  @override
  bool get isOnboarded;

  /// Onboarding preferences (interests, goals, experience, language)
  @override
  Map<String, dynamic> get preferences;

  /// User role (student, teacher, admin)
  @override
  String get role;

  /// Created timestamp
  @override
  DateTime? get createdAt;

  /// Updated timestamp
  @override
  DateTime? get updatedAt;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
