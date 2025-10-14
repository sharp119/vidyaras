import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/repositories/home_repository.dart';
import '../../4_data/repositories/home_repository_impl.dart';

part 'home_providers.g.dart';

/// Provider for HomeRepository
@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}
