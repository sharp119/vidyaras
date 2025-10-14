import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../models/auth_result.dart';
import '../models/user.dart';

/// Authentication repository interface
/// Defines contract for authentication operations
/// Implementations must return Either<Failure, Success> and never throw exceptions
abstract class AuthRepository {
  /// Send OTP to phone number
  /// Returns true if OTP sent successfully
  Future<Either<Failure, bool>> sendOTP(String phoneNumber);

  /// Verify OTP and authenticate user
  /// Returns AuthResult with user data and flags for registration/onboarding
  Future<Either<Failure, AuthResult>> verifyOTP({
    required String phoneNumber,
    required String otp,
  });

  /// Register new user with profile information
  /// Returns complete User object after registration
  Future<Either<Failure, User>> registerUser({
    required String phoneNumber,
    required String name,
    String? email,
  });

  /// Get currently authenticated user
  /// Returns null if no user is authenticated
  Future<Either<Failure, User?>> getCurrentUser();

  /// Sign out current user
  Future<Either<Failure, bool>> signOut();
}
