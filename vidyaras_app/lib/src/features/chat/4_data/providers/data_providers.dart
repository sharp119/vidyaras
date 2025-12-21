import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../3_domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';
import '../repositories/chat_repository_impl.dart';

part 'data_providers.g.dart';

/// ChatRemoteDataSource provider - wires concrete datasource implementation
@riverpod
ChatRemoteDataSource chatRemoteDataSource(ChatRemoteDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return ChatRemoteDataSourceImpl(supabase);
}

/// ChatRepository provider - wires concrete repository implementation
@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final dataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(dataSource);
}
