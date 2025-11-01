import 'package:fpdart/fpdart.dart';

import '../../../../shared/domain/failures/failure.dart';
import '../models/course_progress_detail.dart';
import '../models/enrolled_course.dart';

/// Contract for fetching My Courses data from persistence.
abstract class MyCoursesRepository {
  Future<Either<Failure, List<EnrolledCourse>>> getEnrolledCourses({
    required String userId,
  });

  Future<Either<Failure, CourseProgressDetail>> getCourseProgressDetail({
    required String userId,
    required String courseId,
  });
}
