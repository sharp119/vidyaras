import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../../../shared/providers/api_client_provider.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../datasources/profile_datasource.dart';
import '../repositories/auth_repository_impl.dart';
import '../services/msg91_service.dart';

part 'data_providers.g.dart';

/// ProfileDataSource provider - wires concrete datasource implementation
@riverpod
ProfileDataSource profileDataSource(ProfileDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final dio = ref.watch(apiClientProvider);
  return ProfileDataSource(supabase, dio);
}

/// AuthRepository provider - wires concrete repository implementation
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  final profileDataSource = ref.watch(profileDataSourceProvider);
  return AuthRepositoryImpl(supabase, profileDataSource);
}

/// MSG91 Service provider
@riverpod
Msg91Service msg91Service(Msg91ServiceRef ref) {
  return Msg91Service();
}
