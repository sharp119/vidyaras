import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../3_domain/repositories/courses_repository.dart';
import '../datasources/courses_remote_datasource.dart';
import '../repositories/courses_repository_impl.dart';

part 'data_providers.g.dart';

/// CoursesRemoteDataSource provider - wires concrete datasource implementation
@riverpod
CoursesRemoteDataSource coursesRemoteDataSource(
  CoursesRemoteDataSourceRef ref,
) {
  final supabase = ref.watch(supabaseClientProvider);
  return CoursesRemoteDataSource(supabase);
}

/// CoursesRepository provider - wires concrete repository implementation
@riverpod
CoursesRepository coursesRepository(CoursesRepositoryRef ref) {
  final dataSource = ref.watch(coursesRemoteDataSourceProvider);
  return CoursesRepositoryImpl(dataSource);
}
