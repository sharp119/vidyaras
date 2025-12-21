import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/models/app_user.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../datasources/profile_datasource.dart';

/// AuthRepositoryImpl
/// Implements AuthRepository interface
/// Handles Google OAuth via Supabase + profile operations via ProfileDataSource
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabase;
  final ProfileDataSource _profileDataSource;

  AuthRepositoryImpl(this._supabase, this._profileDataSource);

  @override
  Future<Either<String, AppUser>> signInWithGoogle() async {
    try {
      // Sign in with Google OAuth
      // For mobile: This opens browser/in-app browser
      // Callback is handled in main.dart deep link listener
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.vidyaras://login-callback',
        authScreenLaunchMode: LaunchMode.externalApplication,
      );

      if (!response) {
        return left('Google sign-in was cancelled or failed');
      }

      // For mobile OAuth, the actual sign-in happens via deep link callback
      // The auth state listener will trigger navigation after callback
      // We return a placeholder user here - actual user will be fetched by auth state listener
      return right(
        AppUser(
          id: 'pending',
          email: 'pending',
          fullName: null,
          name: null,
          avatarUrl: null,
          phoneNumber: null,
          isOnboarded: false,
          createdAt: DateTime.now(),
        ),
      );
    } on AuthException catch (e) {
      return left('Google sign-in failed: ${e.message}');
    } catch (e) {
      return left('Unexpected error during sign-in: $e');
    }
  }

  @override
  Future<Either<String, AppUser?>> getCurrentUser() async {
    try {
      final profile = await _profileDataSource.getCurrentProfile();

      if (profile == null) {
        return right(null);
      }

      final user = AppUser.fromJson(profile);
      return right(user);
    } catch (e) {
      return left('Failed to get current user: $e');
    }
  }

  @override
  Future<Either<String, void>> updatePhoneNumber(String phoneNumber) async {
    try {
      await _profileDataSource.updatePhoneNumber(phoneNumber);
      return right(null);
    } on PostgrestException catch (e) {
      // Check for unique constraint violation
      if (e.code == '23505') {
        return left(
          'This phone number is already linked to another account. '
          'Please use a different number or contact support.',
        );
      }
      return left('Database error: ${e.message}');
    } catch (e) {
      return left('Failed to update phone number: $e');
    }
  }

  @override
  Future<Either<String, void>> completeOnboarding(
    Map<String, dynamic> preferences,
  ) async {
    try {
      await _profileDataSource.completeOnboarding(preferences);
      return right(null);
    } catch (e) {
      return left('Failed to complete onboarding: $e');
    }
  }

  @override
  Future<Either<String, void>> signOut() async {
    try {
      await _supabase.auth.signOut();
      return right(null);
    } catch (e) {
      return left('Failed to sign out: $e');
    }
  }

  Future<Either<String, bool>> phoneExists(String phoneNumber) async {
    try {
      final exists = await _profileDataSource.phoneExists(phoneNumber);
      return right(exists);
    } catch (e) {
      return left('Failed to check phone existence: $e');
    }
  }

  @override
  Future<Either<String, Map<String, dynamic>>> getUserStatistics() async {
    try {
      final statistics = await _profileDataSource.getUserStatistics();
      return right(statistics);
    } catch (e) {
      return left('Failed to get user statistics: $e');
    }
  }
}
