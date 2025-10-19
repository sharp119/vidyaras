import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/auth_result.dart';
import '../../3_domain/models/user.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_supabase_datasource.dart';

/// Implementation of AuthRepository
/// Uses MSG91 for OTP and Supabase for user management
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource; // MSG91 service
  final AuthSupabaseDataSource _supabaseDataSource; // Supabase service

  AuthRepositoryImpl(this._localDataSource, this._supabaseDataSource);

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
      // Step 1: Verify OTP via MSG91
      await _localDataSource.verifyOTP(
        requestId: requestId,
        otp: otp,
        phoneNumber: phoneNumber,
      );

      print('✅ OTP verified via MSG91, now checking/creating user in Supabase...');

      // Step 2: Create or get user via Supabase database
      // This happens immediately after OTP verification
      final user = await _supabaseDataSource.createOrGetUser(
        phoneNumber: phoneNumber,
      );

      print('✅ User retrieved from Supabase: ${user.id}');

      // Step 3: Determine if user needs registration or onboarding
      // If user has no name, they need to complete registration
      final needsRegistration = user.name.isEmpty;

      // For now, we'll assume users need onboarding if they're new
      // This can be enhanced later to check a specific field in user metadata
      final needsOnboarding = needsRegistration;

      return right(AuthResult(
        user: user,
        needsRegistration: needsRegistration,
        needsOnboarding: needsOnboarding,
      ));
    } catch (e) {
      print('❌ Error in verifyOTP: $e');
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
      print('📝 Updating user profile in Supabase...');

      // Update user in Supabase with name and email
      final user = await _supabaseDataSource.createOrGetUser(
        phoneNumber: phoneNumber,
        name: name,
        email: email,
      );

      print('✅ User profile updated successfully: ${user.name}');
      return right(user);
    } catch (e) {
      print('❌ Error in registerUser: $e');
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await _supabaseDataSource.getCurrentUser();
      return right(user);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      final result = await _supabaseDataSource.signOut();
      return right(result);
    } catch (e) {
      return left(AuthFailure(message: e.toString()));
    }
  }
}
