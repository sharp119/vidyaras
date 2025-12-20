import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../home/3_domain/models/course.dart';
import '../../3_domain/repositories/courses_repository.dart';
import '../../4_data/datasources/courses_remote_datasource.dart';
import '../../4_data/repositories/courses_repository_impl.dart';

part 'courses_providers.g.dart';

/// Supabase client provider
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Courses remote data source provider
@riverpod
CoursesRemoteDataSource coursesRemoteDataSource(
  CoursesRemoteDataSourceRef ref,
) {
  final supabase = ref.watch(supabaseClientProvider);
  return CoursesRemoteDataSource(supabase);
}

/// Courses repository provider
@riverpod
CoursesRepository coursesRepository(CoursesRepositoryRef ref) {
  final dataSource = ref.watch(coursesRemoteDataSourceProvider);
  return CoursesRepositoryImpl(dataSource);
}

/// Provider for fetching all courses
@riverpod
Future<List<Course>> allCourses(AllCoursesRef ref) async {
  final repository = ref.watch(coursesRepositoryProvider);
  final result = await repository.getCourses();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (courses) => courses,
  );
}

/// Provider for searching courses
@riverpod
Future<List<Course>> searchCourses(SearchCoursesRef ref, String query) async {
  final repository = ref.watch(coursesRepositoryProvider);
  final result = await repository.searchCourses(query);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (courses) => courses,
  );
}

/// Provider for filtering courses by category
@riverpod
Future<List<Course>> coursesByCategory(
  CoursesByCategoryRef ref,
  String category,
) async {
  final repository = ref.watch(coursesRepositoryProvider);
  final result = await repository.getCoursesByCategory(category);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (courses) => courses,
  );
}
