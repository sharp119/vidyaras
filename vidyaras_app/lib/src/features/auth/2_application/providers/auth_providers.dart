import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/repositories/auth_repository.dart';
import '../../3_domain/models/app_user.dart';
import '../../4_data/providers/data_providers.dart';
import '../../../../shared/providers/supabase_provider.dart';

// Re-export data providers for external use
export '../../4_data/providers/data_providers.dart';

part 'auth_providers.g.dart';

/// Current user provider
/// Watches auth state and fetches current user
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return supabase.auth.onAuthStateChange.map((data) => data.session?.user);
}

/// Current profile provider
/// Fetches current user's profile from profiles table
@Riverpod(keepAlive: true)
Future<Map<String, dynamic>?> currentProfile(CurrentProfileRef ref) async {
  final profileDataSource = ref.watch(profileDataSourceProvider);

  // Watch auth state to trigger refresh when user signs in/out
  ref.watch(authStateChangesProvider);

  return await profileDataSource.getCurrentProfile();
}

/// Current user provider (typed AppUser)
/// Fetches current user as AppUser object
@Riverpod(keepAlive: true)
Future<AppUser?> currentUser(CurrentUserRef ref) async {
  final authRepository = ref.watch(authRepositoryProvider);

  // Watch auth state to trigger refresh when user signs in/out
  ref.watch(authStateChangesProvider);

  final result = await authRepository.getCurrentUser();

  return result.fold((error) {
    print('Error fetching current user: $error');
    return null;
  }, (user) => user);
}
