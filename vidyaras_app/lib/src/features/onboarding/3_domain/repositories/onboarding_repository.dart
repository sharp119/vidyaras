import 'package:fpdart/fpdart.dart';
import '../models/onboarding_data.dart';
import '../../../../shared/domain/failures/failure.dart';

/// Repository interface for onboarding data persistence
/// Defines contract for saving and retrieving user onboarding preferences
abstract class OnboardingRepository {
  /// Save onboarding data to local storage
  /// Returns Either<Failure, Unit> - Left for error, Right with Unit for success
  Future<Either<Failure, Unit>> saveOnboardingData(OnboardingData data);

  /// Retrieve saved onboarding data from local storage
  /// Returns Either<Failure, OnboardingData?> - null if no data exists
  Future<Either<Failure, OnboardingData?>> getOnboardingData();

  /// Check if user has completed onboarding
  /// Returns Either<Failure, bool>
  Future<Either<Failure, bool>> hasCompletedOnboarding();

  /// Clear onboarding data (useful for testing or resetting)
  /// Returns Either<Failure, Unit>
  Future<Either<Failure, Unit>> clearOnboardingData();
}
