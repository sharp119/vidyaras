import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/repositories/test_repository.dart';
import '../../4_data/repositories/test_repository_impl.dart';

part 'test_providers.g.dart';

/// Provider for Supabase client
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Provider for test repository
@riverpod
TestRepository testRepository(TestRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return TestRepositoryImpl(supabase);
}
