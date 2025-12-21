import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/home_data.dart';
import '../../3_domain/models/user_profile.dart';
import '../../3_domain/models/course.dart';
import '../../3_domain/models/course_detail.dart';
import '../../3_domain/repositories/home_repository.dart';
import '../../../auth/3_domain/repositories/auth_repository.dart';
import '../datasources/home_remote_datasource.dart';

/// Implementation of HomeRepository
/// Fetches user statistics and course data from API
class HomeRepositoryImpl implements HomeRepository {
  final AuthRepository _authRepository;
  final HomeRemoteDataSource _homeRemoteDataSource;

  HomeRepositoryImpl(this._authRepository, this._homeRemoteDataSource);

  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    try {
      // Get the actual authenticated user
      final userResult = await _authRepository.getCurrentUser();

      // If we can't get user, return error
      final user = userResult.fold((failure) => null, (user) => user);

      if (user == null) {
        return left(const AuthFailure(message: 'User not authenticated'));
      }

      // Fetch real user statistics from API
      Map<String, dynamic>? statsData;
      try {
        final statsResult = await _authRepository.getUserStatistics();
        statsResult.fold(
          (error) {
            print('Failed to fetch user statistics: $error');
            statsData = null;
          },
          (data) {
            statsData = data;
          },
        );
      } catch (e) {
        print('Failed to fetch user statistics: $e');
        // Continue with default values if API fails
      }

      // Extract statistics from API response
      final stats = statsData?['stats'] as Map<String, dynamic>?;
      final enrolledCount = stats?['activeEnrollments'] as int? ?? 0;
      final completedCount = stats?['completedEnrollments'] as int? ?? 0;
      final referralPoints = stats?['referralPoints'] as int? ?? 0;
      final certificatesCount = stats?['certificatesCount'] as int? ?? 0;

      // Build UserProfile from actual user + API stats
      final userProfile = UserProfile(
        id: user.id,
        name: user.name ?? user.email ?? 'User',
        email: user.email,
        avatarUrl: user.avatarUrl,
        bio: user.bio,
        isPremium: false, // TODO: Fetch from user profile
        enrolledCount: enrolledCount,
        completedCount: completedCount,
        certificatesCount: certificatesCount,
        referralPoints: referralPoints,
        interests:
            (user.preferences['interests'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        createdAt: user.createdAt,
      );

      // Fetch courses from API
      List<Course> allCourses = [];
      try {
        allCourses = await _homeRemoteDataSource.getFeaturedCourses();
      } catch (e) {
        print('Failed to fetch courses from API: $e');
        // Continue with empty lists if API fails
      }

      // Split courses into categories
      // For now, use simple logic - in production you might want API to return categorized data
      final myCourses = allCourses
          .take(2)
          .toList(); // First 2 courses as "my courses"
      final freeCourses = allCourses.where((c) => c.isFree).toList();
      final recommendedCourses = allCourses
          .where((c) => !c.isFree)
          .skip(myCourses.length)
          .take(4)
          .toList();

      final homeData = HomeData(
        userProfile: userProfile,
        myCourses: myCourses,
        recommendedCourses: recommendedCourses,
        freeCourses: freeCourses,
      );

      return right(homeData);
    } catch (e) {
      return left(
        DataFailure(message: 'Failed to load home data: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, HomeData>> refreshHomeData() async {
    // For now, just call getHomeData
    return getHomeData();
  }

  @override
  Future<Either<Failure, CourseDetail>> getCourseDetail(String courseId) async {
    try {
      final courseDetail = await _homeRemoteDataSource.getCourseDetail(
        courseId,
      );
      return right(courseDetail);
    } catch (e) {
      return left(
        DataFailure(message: 'Failed to load course details: ${e.toString()}'),
      );
    }
  }
}
