import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../4_data/datasources/auth_local_datasource.dart';
import '../../4_data/repositories/auth_repository_impl.dart';
import '../../4_data/services/msg91_service.dart';
import '../../3_domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

/// Provides MSG91 Service for OTP operations (using SDK)
@riverpod
Msg91Service msg91Service(Msg91ServiceRef ref) {
  return Msg91Service();
}

/// Provides Auth Local DataSource with MSG91 integration
@riverpod
AuthLocalDataSource authLocalDataSource(AuthLocalDataSourceRef ref) {
  final msg91Service = ref.watch(msg91ServiceProvider);
  return AuthLocalDataSource(msg91Service);
}

/// Provides Auth Repository implementation
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(localDataSource);
}
