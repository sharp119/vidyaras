import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../../4_data/datasources/profile_datasource.dart';
import '../../4_data/repositories/auth_repository_impl.dart';
import '../../4_data/services/msg91_service.dart';

part 'auth_providers.g.dart';

/// Supabase client provider
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// ProfileDataSource provider
@riverpod
ProfileDataSource profileDataSource(ProfileDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return ProfileDataSource(supabase);
}

/// AuthRepository provider
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

/// Current user provider
/// Watches auth state and fetches current user
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return supabase.auth.onAuthStateChange.map((data) => data.session?.user);
}

/// Current profile provider
/// Fetches current user's profile from profiles table
@riverpod
Future<Map<String, dynamic>?> currentProfile(CurrentProfileRef ref) async {
  final profileDataSource = ref.watch(profileDataSourceProvider);

  // Watch auth state to trigger refresh when user signs in/out
  ref.watch(authStateChangesProvider);

  return await profileDataSource.getCurrentProfile();
}
