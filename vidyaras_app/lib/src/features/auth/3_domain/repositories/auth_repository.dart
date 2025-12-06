import 'package:fpdart/fpdart.dart';
import '../models/app_user.dart';

/// Auth Repository Interface
/// Defines contracts for authentication operations
/// Implemented by AuthRepositoryImpl in Data Layer
abstract class AuthRepository {
  /// Sign in with Google OAuth
  /// Returns Either<String, AppUser> where:
  /// - Left: Error message
  /// - Right: Authenticated user
  Future<Either<String, AppUser>> signInWithGoogle();

  /// Get current user profile from profiles table
  /// Returns Either<String, AppUser> where:
  /// - Left: Error message
  /// - Right: Current user or null if not authenticated
  Future<Either<String, AppUser?>> getCurrentUser();

  /// Update phone number after OTP verification
  /// Returns Either<String, void> where:
  /// - Left: Error message (e.g., duplicate phone)
  /// - Right: Success
  Future<Either<String, void>> updatePhoneNumber(String phoneNumber);

  /// Complete onboarding with preferences
  /// Returns Either<String, void> where:
  /// - Left: Error message
  /// - Right: Success
  Future<Either<String, void>> completeOnboarding(Map<String, dynamic> preferences);

  /// Sign out
  /// Returns Either<String, void> where:
  /// - Left: Error message
  /// - Right: Success
  Future<Either<String, void>> signOut();

  /// Check if phone number exists
  /// Returns Either<String, bool> where:
  /// - Left: Error message
  /// - Right: true if exists, false otherwise
  Future<Either<String, bool>> phoneExists(String phoneNumber);
}
