import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';

part 'auth_result.freezed.dart';

/// Result of authentication operations
/// Contains user data and flags indicating if user needs to complete registration or onboarding
@freezed
class AuthResult with _$AuthResult {
  const factory AuthResult({
    required User user,
    required bool needsRegistration,
    required bool needsOnboarding,
  }) = _AuthResult;
}
