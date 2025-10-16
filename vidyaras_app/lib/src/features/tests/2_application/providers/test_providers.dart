import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/repositories/test_repository.dart';
import '../../4_data/repositories/test_repository_impl.dart';

part 'test_providers.g.dart';

/// Provider for test repository
@riverpod
TestRepository testRepository(TestRepositoryRef ref) {
  return TestRepositoryImpl();
}
