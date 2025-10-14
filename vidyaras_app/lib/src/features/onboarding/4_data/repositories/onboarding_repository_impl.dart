import 'package:fpdart/fpdart.dart';
import '../../3_domain/models/onboarding_data.dart';
import '../../3_domain/repositories/onboarding_repository.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../datasources/onboarding_local_datasource.dart';

/// Implementation of OnboardingRepository using Hive local storage
/// Follows the repository pattern with Either<Failure, Success> return types
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, Unit>> saveOnboardingData(OnboardingData data) async {
    try {
      await _localDataSource.saveOnboardingData(data);
      return right(unit);
    } catch (e) {
      return left(
        StorageFailure(
          message: 'Failed to save onboarding data',
          code: 'SAVE_ONBOARDING_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, OnboardingData?>> getOnboardingData() async {
    try {
      final data = await _localDataSource.getOnboardingData();
      return right(data);
    } catch (e) {
      return left(
        StorageFailure(
          message: 'Failed to retrieve onboarding data',
          code: 'GET_ONBOARDING_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> hasCompletedOnboarding() async {
    try {
      final hasCompleted = await _localDataSource.hasCompletedOnboarding();
      return right(hasCompleted);
    } catch (e) {
      return left(
        StorageFailure(
          message: 'Failed to check onboarding status',
          code: 'CHECK_ONBOARDING_ERROR',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clearOnboardingData() async {
    try {
      await _localDataSource.clearOnboardingData();
      return right(unit);
    } catch (e) {
      return left(
        StorageFailure(
          message: 'Failed to clear onboarding data',
          code: 'CLEAR_ONBOARDING_ERROR',
        ),
      );
    }
  }
}
