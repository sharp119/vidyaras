import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/auth_result.dart';
import '../../3_domain/models/user.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

/// Implementation of AuthRepository
/// Uses local datasource with dummy data for development
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, String>> sendOTP(String phoneNumber) async {
    try {
      final requestId = await _localDataSource.sendOTP(phoneNumber);
      return right(requestId);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> verifyOTP({
    required String requestId,
    required String otp,
    required String phoneNumber,
  }) async {
    try {
      final user = await _localDataSource.verifyOTP(
        requestId: requestId,
        otp: otp,
        phoneNumber: phoneNumber,
      );

      if (user == null) {
        // New user - needs registration
        // Create temporary user object for the auth result
        final tempUser = User(
          id: 'temp',
          phoneNumber: phoneNumber,
          name: '',
          isNewUser: true,
        );

        return right(AuthResult(
          user: tempUser,
          needsRegistration: true,
          needsOnboarding: true,
        ));
      } else {
        // Existing user - check if they completed onboarding
        // For simplicity, we assume existing users have completed onboarding
        return right(AuthResult(
          user: user,
          needsRegistration: false,
          needsOnboarding: false,
        ));
      }
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> registerUser({
    required String phoneNumber,
    required String name,
    String? email,
  }) async {
    try {
      final user = await _localDataSource.registerUser(
        phoneNumber: phoneNumber,
        name: name,
        email: email,
      );
      return right(user);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await _localDataSource.getCurrentUser();
      return right(user);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      final result = await _localDataSource.signOut();
      return right(result);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }
}
