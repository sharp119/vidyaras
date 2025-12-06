import 'package:freezed_annotation/freezed_annotation.dart';
import '../../3_domain/models/auth_result.dart';
import '../../3_domain/models/user.dart';

part 'auth_state.freezed.dart';

/// Authentication state
/// Represents the current state of authentication flow
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.sendingOTP() = _SendingOTP;

  const factory AuthState.otpSent({
    required String phoneNumber,
    required String requestId,
  }) = _OTPSent;

  const factory AuthState.verifyingOTP() = _VerifyingOTP;

  const factory AuthState.otpVerified({
    required AuthResult authResult,
  }) = _OTPVerified;

  const factory AuthState.registering() = _Registering;

  const factory AuthState.authenticated({
    required User user,
  }) = _Authenticated;

  const factory AuthState.error({
    required String message,
  }) = _Error;
}
