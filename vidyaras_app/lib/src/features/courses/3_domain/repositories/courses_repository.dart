import 'package:fpdart/fpdart.dart';
import 'package:vidyaras_app/src/shared/domain/failures/failure.dart';
import 'package:vidyaras_app/src/features/home/3_domain/models/course.dart';

abstract class CoursesRepository {
  Future<Either<Failure, List<Course>>> getCourses();
  Future<Either<Failure, List<Course>>> searchCourses(String query);
  Future<Either<Failure, List<Course>>> getCoursesByCategory(String category);
}
