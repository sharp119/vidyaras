import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../../home/3_domain/models/course.dart';
import '../../3_domain/repositories/courses_repository.dart';
import '../datasources/courses_remote_datasource.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource _remoteDataSource;

  CoursesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Course>>> getCourses() async {
    try {
      final courses = await _remoteDataSource.getAllCourses();
      return right(courses);
    } catch (e) {
      return left(DataFailure(message: 'Failed to fetch courses: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> searchCourses(String query) async {
    try {
      final courses = await _remoteDataSource.searchCourses(query);
      return right(courses);
    } catch (e) {
      return left(DataFailure(message: 'Failed to search courses: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getCoursesByCategory(
    String category,
  ) async {
    try {
      final courses = await _remoteDataSource.getCoursesByCategory(category);
      return right(courses);
    } catch (e) {
      return left(
        DataFailure(message: 'Failed to fetch courses by category: $e'),
      );
    }
  }
}
