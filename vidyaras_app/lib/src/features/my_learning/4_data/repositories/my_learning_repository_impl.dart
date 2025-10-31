import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/lecture.dart';
import '../../3_domain/models/live_class.dart';
import '../../3_domain/models/course_material.dart';
import '../../3_domain/models/lecture_completion.dart';
import '../../3_domain/repositories/my_learning_repository.dart';
import '../datasources/my_learning_remote_datasource.dart';

/// Implementation of MyLearningRepository
/// Handles error wrapping and calls to remote data source
class MyLearningRepositoryImpl implements MyLearningRepository {
  final MyLearningRemoteDataSource _remoteDataSource;

  const MyLearningRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<EnrolledCourse>>> getEnrolledCourses({
    required String userId,
  }) async {
    try {
      final courses = await _remoteDataSource.getEnrolledCourses(
        userId: userId,
      );
      return right(courses);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, EnrolledCourse>> getCourseDetails({
    required String userId,
    required String courseId,
  }) async {
    try {
      final course = await _remoteDataSource.getCourseDetails(
        userId: userId,
        courseId: courseId,
      );
      return right(course);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Lecture>>> getCourseLectures({
    required String userId,
    required String courseId,
  }) async {
    try {
      final lectures = await _remoteDataSource.getCourseLectures(
        userId: userId,
        courseId: courseId,
      );
      return right(lectures);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LiveClass>>> getCourseLiveClasses({
    required String courseId,
  }) async {
    try {
      final liveClasses = await _remoteDataSource.getCourseLiveClasses(
        courseId: courseId,
      );
      return right(liveClasses);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<LiveClass>>> getUpcomingLiveClasses({
    required String userId,
  }) async {
    try {
      final liveClasses = await _remoteDataSource.getUpcomingLiveClasses(
        userId: userId,
      );
      return right(liveClasses);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseMaterial>>> getCourseMaterials({
    required String courseId,
  }) async {
    try {
      final materials = await _remoteDataSource.getCourseMaterials(
        courseId: courseId,
      );
      return right(materials);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LectureCompletion>> markLectureComplete({
    required String userId,
    required String lectureId,
    int? watchedSeconds,
  }) async {
    try {
      final completion = await _remoteDataSource.markLectureComplete(
        userId: userId,
        lectureId: lectureId,
        watchedSeconds: watchedSeconds,
      );
      return right(completion);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseProgress>> getCourseProgress({
    required String userId,
    required String courseId,
  }) async {
    try {
      final progressData = await _remoteDataSource.getCourseProgress(
        userId: userId,
        courseId: courseId,
      );

      final progress = CourseProgress(
        courseId: progressData['course_id'] as String,
        userId: progressData['user_id'] as String,
        totalLectures: progressData['total_lectures'] as int,
        completedLectures: progressData['completed_lectures'] as int,
        progressPercentage: (progressData['progress_percentage'] as num).toDouble(),
        totalDurationMinutes: progressData['total_duration_minutes'] as int,
        completedDurationMinutes:
            progressData['completed_duration_minutes'] as int,
        lastAccessedAt: progressData['last_accessed_at'] != null
            ? DateTime.parse(progressData['last_accessed_at'] as String)
            : null,
      );

      return right(progress);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateLastAccessed({
    required String userId,
    required String courseId,
  }) async {
    try {
      await _remoteDataSource.updateLastAccessed(
        userId: userId,
        courseId: courseId,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
