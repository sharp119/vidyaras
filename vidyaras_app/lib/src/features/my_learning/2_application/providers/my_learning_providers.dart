import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../main.dart'; // For supabase client
import '../../3_domain/repositories/my_learning_repository.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/lecture.dart';
import '../../3_domain/models/live_class.dart';
import '../../3_domain/models/course_material.dart';
import '../../4_data/datasources/my_learning_remote_datasource.dart';
import '../../4_data/repositories/my_learning_repository_impl.dart';
import '../../../auth/2_application/providers/auth_providers.dart';

part 'my_learning_providers.g.dart';

/// Provides the remote data source instance
@riverpod
MyLearningRemoteDataSource myLearningRemoteDataSource(
  MyLearningRemoteDataSourceRef ref,
) {
  return MyLearningRemoteDataSourceImpl(supabase);
}

/// Provides the repository instance
@riverpod
MyLearningRepository myLearningRepository(
  MyLearningRepositoryRef ref,
) {
  final dataSource = ref.watch(myLearningRemoteDataSourceProvider);
  return MyLearningRepositoryImpl(dataSource);
}

/// Fetches all enrolled courses for the current user
@riverpod
Future<List<EnrolledCourse>> enrolledCourses(
  EnrolledCoursesRef ref,
) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];

  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getEnrolledCourses(userId: user.id);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (courses) => courses,
  );
}

/// Fetches detailed course information including lectures and materials
@riverpod
Future<EnrolledCourse> courseDetails(
  CourseDetailsRef ref, {
  required String courseId,
}) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) throw Exception('User not authenticated');

  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getCourseDetails(
    userId: user.id,
    courseId: courseId,
  );

  return result.fold(
    (failure) => throw Exception(failure.message),
    (course) => course,
  );
}

/// Fetches lectures for a specific course
@riverpod
Future<List<Lecture>> courseLectures(
  CourseLecturesRef ref, {
  required String courseId,
}) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];

  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getCourseLectures(
    userId: user.id,
    courseId: courseId,
  );

  return result.fold(
    (failure) => throw Exception(failure.message),
    (lectures) => lectures,
  );
}

/// Fetches live classes for a specific course
@riverpod
Future<List<LiveClass>> courseLiveClasses(
  CourseLiveClassesRef ref, {
  required String courseId,
}) async {
  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getCourseLiveClasses(courseId: courseId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (liveClasses) => liveClasses,
  );
}

/// Fetches upcoming live classes across all enrolled courses
@riverpod
Future<List<LiveClass>> upcomingLiveClasses(
  UpcomingLiveClassesRef ref,
) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) return [];

  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getUpcomingLiveClasses(userId: user.id);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (liveClasses) => liveClasses,
  );
}

/// Fetches course materials
@riverpod
Future<List<CourseMaterial>> courseMaterials(
  CourseMaterialsRef ref, {
  required String courseId,
}) async {
  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getCourseMaterials(courseId: courseId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (materials) => materials,
  );
}

/// Fetches course progress statistics
@riverpod
Future<CourseProgress> courseProgress(
  CourseProgressRef ref, {
  required String courseId,
}) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) throw Exception('User not authenticated');

  final repository = ref.watch(myLearningRepositoryProvider);
  final result = await repository.getCourseProgress(
    userId: user.id,
    courseId: courseId,
  );

  return result.fold(
    (failure) => throw Exception(failure.message),
    (progress) => progress,
  );
}
