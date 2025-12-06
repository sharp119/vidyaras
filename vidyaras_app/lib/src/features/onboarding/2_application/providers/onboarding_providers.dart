import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/repositories/onboarding_repository.dart';
import '../../4_data/datasources/onboarding_local_datasource.dart';
import '../../4_data/repositories/onboarding_repository_impl.dart';

part 'onboarding_providers.g.dart';

/// Supabase client provider
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Provider for OnboardingLocalDataSource
@riverpod
OnboardingLocalDataSource onboardingLocalDataSource(
    OnboardingLocalDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return OnboardingLocalDataSource(supabase);
}

/// Provider for OnboardingRepository
@riverpod
OnboardingRepository onboardingRepository(OnboardingRepositoryRef ref) {
  final localDataSource = ref.watch(onboardingLocalDataSourceProvider);
  return OnboardingRepositoryImpl(localDataSource);
}
