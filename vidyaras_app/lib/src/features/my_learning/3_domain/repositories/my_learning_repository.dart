import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../models/enrolled_course.dart';
import '../models/lecture.dart';
import '../models/live_class.dart';
import '../models/course_material.dart';
import '../models/lecture_completion.dart';

/// Repository contract for My Learning feature
/// Defines all operations for enrolled courses, lectures, and progress tracking
abstract class MyLearningRepository {
  /// Get all courses the user is enrolled in
  /// Returns list of enrolled courses with basic info
  Future<Either<Failure, List<EnrolledCourse>>> getEnrolledCourses({
    required String userId,
  });

  /// Get detailed information for a specific enrolled course
  /// Includes lectures, live classes, and materials
  Future<Either<Failure, EnrolledCourse>> getCourseDetails({
    required String userId,
    required String courseId,
  });

  /// Get all lectures for a course
  /// Includes completion status and lock status for the user
  Future<Either<Failure, List<Lecture>>> getCourseLectures({
    required String userId,
    required String courseId,
  });

  /// Get all live classes for a course
  /// Includes past sessions with recordings and upcoming sessions
  Future<Either<Failure, List<LiveClass>>> getCourseLiveClasses({
    required String courseId,
  });

  /// Get upcoming live classes across all enrolled courses
  Future<Either<Failure, List<LiveClass>>> getUpcomingLiveClasses({
    required String userId,
  });

  /// Get all course materials
  Future<Either<Failure, List<CourseMaterial>>> getCourseMaterials({
    required String courseId,
  });

  /// Mark a lecture as completed
  Future<Either<Failure, LectureCompletion>> markLectureComplete({
    required String userId,
    required String lectureId,
    int? watchedSeconds,
  });

  /// Get user's progress for a specific course
  /// Returns completion percentage and statistics
  Future<Either<Failure, CourseProgress>> getCourseProgress({
    required String userId,
    required String courseId,
  });

  /// Update last accessed time for a course
  Future<Either<Failure, void>> updateLastAccessed({
    required String userId,
    required String courseId,
  });
}

/// Helper class to represent course progress statistics
class CourseProgress {
  final String courseId;
  final String userId;
  final int totalLectures;
  final int completedLectures;
  final double progressPercentage;
  final int totalDurationMinutes;
  final int completedDurationMinutes;
  final DateTime? lastAccessedAt;

  const CourseProgress({
    required this.courseId,
    required this.userId,
    required this.totalLectures,
    required this.completedLectures,
    required this.progressPercentage,
    required this.totalDurationMinutes,
    required this.completedDurationMinutes,
    this.lastAccessedAt,
  });
}
