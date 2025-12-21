import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/models/course_detail.dart';
import '../../4_data/providers/data_providers.dart';

// Re-export data providers for external use
export '../../4_data/providers/data_providers.dart';

part 'home_providers.g.dart';

/// Provider for fetching course detail by ID
@riverpod
Future<CourseDetail> courseDetail(CourseDetailRef ref, String courseId) async {
  final repository = ref.watch(homeRepositoryProvider);
  final result = await repository.getCourseDetail(courseId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (courseDetail) => courseDetail,
  );
}
