// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$SendingOTPImplCopyWith<$Res> {
  factory _$$SendingOTPImplCopyWith(
    _$SendingOTPImpl value,
    $Res Function(_$SendingOTPImpl) then,
  ) = __$$SendingOTPImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SendingOTPImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SendingOTPImpl>
    implements _$$SendingOTPImplCopyWith<$Res> {
  __$$SendingOTPImplCopyWithImpl(
    _$SendingOTPImpl _value,
    $Res Function(_$SendingOTPImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SendingOTPImpl implements _SendingOTP {
  const _$SendingOTPImpl();

  @override
  String toString() {
    return 'AuthState.sendingOTP()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SendingOTPImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return sendingOTP();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return sendingOTP?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (sendingOTP != null) {
      return sendingOTP();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return sendingOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return sendingOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (sendingOTP != null) {
      return sendingOTP(this);
    }
    return orElse();
  }
}

abstract class _SendingOTP implements AuthState {
  const factory _SendingOTP() = _$SendingOTPImpl;
}

/// @nodoc
abstract class _$$OTPSentImplCopyWith<$Res> {
  factory _$$OTPSentImplCopyWith(
    _$OTPSentImpl value,
    $Res Function(_$OTPSentImpl) then,
  ) = __$$OTPSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$OTPSentImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OTPSentImpl>
    implements _$$OTPSentImplCopyWith<$Res> {
  __$$OTPSentImplCopyWithImpl(
    _$OTPSentImpl _value,
    $Res Function(_$OTPSentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? phoneNumber = null}) {
    return _then(
      _$OTPSentImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OTPSentImpl implements _OTPSent {
  const _$OTPSentImpl({required this.phoneNumber});

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthState.otpSent(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTPSentImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OTPSentImplCopyWith<_$OTPSentImpl> get copyWith =>
      __$$OTPSentImplCopyWithImpl<_$OTPSentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return otpSent(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return otpSent?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (otpSent != null) {
      return otpSent(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return otpSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return otpSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (otpSent != null) {
      return otpSent(this);
    }
    return orElse();
  }
}

abstract class _OTPSent implements AuthState {
  const factory _OTPSent({required final String phoneNumber}) = _$OTPSentImpl;

  String get phoneNumber;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OTPSentImplCopyWith<_$OTPSentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyingOTPImplCopyWith<$Res> {
  factory _$$VerifyingOTPImplCopyWith(
    _$VerifyingOTPImpl value,
    $Res Function(_$VerifyingOTPImpl) then,
  ) = __$$VerifyingOTPImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VerifyingOTPImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$VerifyingOTPImpl>
    implements _$$VerifyingOTPImplCopyWith<$Res> {
  __$$VerifyingOTPImplCopyWithImpl(
    _$VerifyingOTPImpl _value,
    $Res Function(_$VerifyingOTPImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$VerifyingOTPImpl implements _VerifyingOTP {
  const _$VerifyingOTPImpl();

  @override
  String toString() {
    return 'AuthState.verifyingOTP()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VerifyingOTPImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return verifyingOTP();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return verifyingOTP?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (verifyingOTP != null) {
      return verifyingOTP();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return verifyingOTP(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return verifyingOTP?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (verifyingOTP != null) {
      return verifyingOTP(this);
    }
    return orElse();
  }
}

abstract class _VerifyingOTP implements AuthState {
  const factory _VerifyingOTP() = _$VerifyingOTPImpl;
}

/// @nodoc
abstract class _$$OTPVerifiedImplCopyWith<$Res> {
  factory _$$OTPVerifiedImplCopyWith(
    _$OTPVerifiedImpl value,
    $Res Function(_$OTPVerifiedImpl) then,
  ) = __$$OTPVerifiedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AuthResult authResult});

  $AuthResultCopyWith<$Res> get authResult;
}

/// @nodoc
class __$$OTPVerifiedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$OTPVerifiedImpl>
    implements _$$OTPVerifiedImplCopyWith<$Res> {
  __$$OTPVerifiedImplCopyWithImpl(
    _$OTPVerifiedImpl _value,
    $Res Function(_$OTPVerifiedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? authResult = null}) {
    return _then(
      _$OTPVerifiedImpl(
        authResult: null == authResult
            ? _value.authResult
            : authResult // ignore: cast_nullable_to_non_nullable
                  as AuthResult,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthResultCopyWith<$Res> get authResult {
    return $AuthResultCopyWith<$Res>(_value.authResult, (value) {
      return _then(_value.copyWith(authResult: value));
    });
  }
}

/// @nodoc

class _$OTPVerifiedImpl implements _OTPVerified {
  const _$OTPVerifiedImpl({required this.authResult});

  @override
  final AuthResult authResult;

  @override
  String toString() {
    return 'AuthState.otpVerified(authResult: $authResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OTPVerifiedImpl &&
            (identical(other.authResult, authResult) ||
                other.authResult == authResult));
  }

  @override
  int get hashCode => Object.hash(runtimeType, authResult);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OTPVerifiedImplCopyWith<_$OTPVerifiedImpl> get copyWith =>
      __$$OTPVerifiedImplCopyWithImpl<_$OTPVerifiedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return otpVerified(authResult);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return otpVerified?.call(authResult);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (otpVerified != null) {
      return otpVerified(authResult);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return otpVerified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return otpVerified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (otpVerified != null) {
      return otpVerified(this);
    }
    return orElse();
  }
}

abstract class _OTPVerified implements AuthState {
  const factory _OTPVerified({required final AuthResult authResult}) =
      _$OTPVerifiedImpl;

  AuthResult get authResult;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OTPVerifiedImplCopyWith<_$OTPVerifiedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisteringImplCopyWith<$Res> {
  factory _$$RegisteringImplCopyWith(
    _$RegisteringImpl value,
    $Res Function(_$RegisteringImpl) then,
  ) = __$$RegisteringImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisteringImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegisteringImpl>
    implements _$$RegisteringImplCopyWith<$Res> {
  __$$RegisteringImplCopyWithImpl(
    _$RegisteringImpl _value,
    $Res Function(_$RegisteringImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisteringImpl implements _Registering {
  const _$RegisteringImpl();

  @override
  String toString() {
    return 'AuthState.registering()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RegisteringImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return registering();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return registering?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (registering != null) {
      return registering();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return registering(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return registering?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (registering != null) {
      return registering(this);
    }
    return orElse();
  }
}

abstract class _Registering implements AuthState {
  const factory _Registering() = _$RegisteringImpl;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
    _$AuthenticatedImpl value,
    $Res Function(_$AuthenticatedImpl) then,
  ) = __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
    _$AuthenticatedImpl _value,
    $Res Function(_$AuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null}) {
    return _then(
      _$AuthenticatedImpl(
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc

class _$AuthenticatedImpl implements _Authenticated {
  const _$AuthenticatedImpl({required this.user});

  @override
  final User user;

  @override
  String toString() {
    return 'AuthState.authenticated(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return authenticated(user);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return authenticated?.call(user);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(user);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated({required final User user}) =
      _$AuthenticatedImpl;

  User get user;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() sendingOTP,
    required TResult Function(String phoneNumber) otpSent,
    required TResult Function() verifyingOTP,
    required TResult Function(AuthResult authResult) otpVerified,
    required TResult Function() registering,
    required TResult Function(User user) authenticated,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? sendingOTP,
    TResult? Function(String phoneNumber)? otpSent,
    TResult? Function()? verifyingOTP,
    TResult? Function(AuthResult authResult)? otpVerified,
    TResult? Function()? registering,
    TResult? Function(User user)? authenticated,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? sendingOTP,
    TResult Function(String phoneNumber)? otpSent,
    TResult Function()? verifyingOTP,
    TResult Function(AuthResult authResult)? otpVerified,
    TResult Function()? registering,
    TResult Function(User user)? authenticated,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SendingOTP value) sendingOTP,
    required TResult Function(_OTPSent value) otpSent,
    required TResult Function(_VerifyingOTP value) verifyingOTP,
    required TResult Function(_OTPVerified value) otpVerified,
    required TResult Function(_Registering value) registering,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_SendingOTP value)? sendingOTP,
    TResult? Function(_OTPSent value)? otpSent,
    TResult? Function(_VerifyingOTP value)? verifyingOTP,
    TResult? Function(_OTPVerified value)? otpVerified,
    TResult? Function(_Registering value)? registering,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SendingOTP value)? sendingOTP,
    TResult Function(_OTPSent value)? otpSent,
    TResult Function(_VerifyingOTP value)? verifyingOTP,
    TResult Function(_OTPVerified value)? otpVerified,
    TResult Function(_Registering value)? registering,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
