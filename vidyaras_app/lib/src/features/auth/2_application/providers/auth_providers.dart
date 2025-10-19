import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../4_data/datasources/auth_local_datasource.dart';
import '../../4_data/datasources/auth_supabase_datasource.dart';
import '../../4_data/repositories/auth_repository_impl.dart';
import '../../4_data/services/msg91_service.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../../3_domain/models/user.dart' as domain;

part 'auth_providers.g.dart';

/// Provides Supabase Client instance
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

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

/// Provides Auth Supabase DataSource for user management
@riverpod
AuthSupabaseDataSource authSupabaseDataSource(AuthSupabaseDataSourceRef ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return AuthSupabaseDataSource(supabaseClient);
}

/// Provides Auth Repository implementation
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final supabaseDataSource = ref.watch(authSupabaseDataSourceProvider);
  return AuthRepositoryImpl(localDataSource, supabaseDataSource);
}

/// Provides current authenticated user
/// This provider is used globally across the app to access user data
/// Returns null if no user is logged in or session expired
@riverpod
Future<domain.User?> currentUser(CurrentUserRef ref) async {
  try {
    print('🔄 currentUserProvider: Starting to fetch user...');
    final authRepository = ref.watch(authRepositoryProvider);
    final result = await authRepository.getCurrentUser();

    return result.fold(
      (failure) {
        print('❌ currentUserProvider: Failed to get user: ${failure.message}');
        return null;
      },
      (user) {
        print('✅ currentUserProvider: User retrieved: ${user?.phoneNumber ?? "null"}');
        return user;
      },
    );
  } catch (e, stack) {
    print('❌ currentUserProvider: Exception: $e');
    print('Stack: $stack');
    return null;
  }
}
