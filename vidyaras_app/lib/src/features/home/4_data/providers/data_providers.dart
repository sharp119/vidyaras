import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../3_domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../repositories/home_repository_impl.dart';

part 'data_providers.g.dart';

/// HomeRemoteDataSource provider - wires concrete datasource implementation
@riverpod
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return HomeRemoteDataSource(supabase);
}

/// HomeRepository provider - wires concrete repository implementation
@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final homeRemoteDataSource = ref.watch(homeRemoteDataSourceProvider);
  return HomeRepositoryImpl(authRepository, homeRemoteDataSource);
}
