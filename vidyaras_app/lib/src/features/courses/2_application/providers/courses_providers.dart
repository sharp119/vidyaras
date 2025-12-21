import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../home/3_domain/models/course.dart';
import '../../4_data/providers/data_providers.dart';

// Re-export data providers for external use
export '../../4_data/providers/data_providers.dart';

part 'courses_providers.g.dart';

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
