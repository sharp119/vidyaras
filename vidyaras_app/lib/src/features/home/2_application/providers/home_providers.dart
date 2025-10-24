import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/repositories/home_repository.dart';
import '../../3_domain/models/course_detail.dart';
import '../../4_data/repositories/home_repository_impl.dart';

part 'home_providers.g.dart';

/// Provider for HomeRepository
@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl();
}

/// Provider for fetching course detail by ID
/// Returns CourseDetail for the specified course
@riverpod
Future<CourseDetail> courseDetail(
  CourseDetailRef ref,
  String courseId,
) async {
  final repository = ref.watch(homeRepositoryProvider);
  final result = await repository.getCourseDetail(courseId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (detail) => detail,
  );
}
