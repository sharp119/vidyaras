import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../3_domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';
import '../repositories/onboarding_repository_impl.dart';

part 'data_providers.g.dart';

/// OnboardingLocalDataSource provider - wires concrete datasource implementation
@riverpod
OnboardingLocalDataSource onboardingLocalDataSource(
  OnboardingLocalDataSourceRef ref,
) {
  final supabase = ref.watch(supabaseClientProvider);
  return OnboardingLocalDataSource(supabase);
}

/// OnboardingRepository provider - wires concrete repository implementation
@riverpod
OnboardingRepository onboardingRepository(OnboardingRepositoryRef ref) {
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  return OnboardingRepositoryImpl(localDataSource);
}
