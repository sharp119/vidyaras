import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../3_domain/repositories/my_learning_repository.dart';
import '../datasources/my_learning_remote_datasource.dart';
import '../repositories/my_learning_repository_impl.dart';

part 'data_providers.g.dart';

/// MyLearningRemoteDataSource provider - wires concrete datasource implementation
@riverpod
MyLearningRemoteDataSource myLearningRemoteDataSource(
  MyLearningRemoteDataSourceRef ref,
) {
  final supabase = ref.watch(supabaseClientProvider);
  return MyLearningRemoteDataSourceImpl(supabase);
}

/// MyLearningRepository provider - wires concrete repository implementation
@riverpod
MyLearningRepository myLearningRepository(MyLearningRepositoryRef ref) {
  final dataSource = ref.watch(myLearningRemoteDataSourceProvider);
  return MyLearningRepositoryImpl(dataSource);
}
