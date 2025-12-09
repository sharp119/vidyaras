import 'package:fpdart/fpdart.dart';
import 'package:vidyaras_app/src/shared/domain/failures/failure.dart';
import 'package:vidyaras_app/src/features/home/3_domain/models/course.dart';
import 'package:vidyaras_app/src/features/courses/3_domain/repositories/courses_repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  // Simulating a database of courses
  final List<Course> _allCourses = [
    const Course(
      id: '1',
      title: 'Classical Hindustani Vocal - Beginner',
      instructor: 'Pandit Ravi Kumar',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400',
      rating: 4.8,
      reviewCount: 89,
      enrolledCount: 145,
      price: '₹4999',
      duration: '3 months',
      progress: 0.35,
      isLive: true,
      hasFreeTrial: true,
      categories: ['music'],
    ),
    const Course(
      id: '2',
      title: 'Meditation & Mindfulness',
      instructor: 'Dr. Anjali Mehta',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400',
      rating: 4.7,
      reviewCount: 156,
      enrolledCount: 234,
      price: '₹1999',
      duration: '1 month',
      progress: 0.0,
      isRecorded: true,
      categories: ['wellness'],
    ),
    const Course(
      id: '3',
      title: 'Tabla Mastery - Intermediate',
      instructor: 'Ustad Zakir Hussain',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
      rating: 4.9,
      reviewCount: 156,
      enrolledCount: 234,
      price: '₹3499',
      duration: '2 months',
      isLive: true,
      hasFreeTrial: false,
      categories: ['music'],
    ),
    const Course(
      id: '4',
      title: 'Yoga for Wellness',
      instructor: 'Swami Ramdev',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      rating: 4.8,
      reviewCount: 312,
      enrolledCount: 567,
      price: '₹1999',
      duration: '1 month',
      isLive: true,
      hasFreeTrial: false,
      categories: ['wellness', 'yoga'],
    ),
    const Course(
      id: '5',
      title: 'Harmonica for Beginners',
      instructor: 'Rahul Verma',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1460036521480-ff49c08c2781?w=400',
      rating: 4.6,
      reviewCount: 234,
      enrolledCount: 567,
      duration: '2 weeks',
      isFree: true,
      isRecorded: true,
      categories: ['music'],
    ),
    const Course(
      id: '6',
      title: 'Kathak Dance Fundamentals',
      instructor: 'Pt. Birju Maharaj',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1580927752452-89d86da3fa0a?w=400',
      rating: 4.9,
      reviewCount: 201,
      enrolledCount: 356,
      price: '₹5999',
      duration: '2 months',
      isRecorded: true,
      hasFreeTrial: false,
      categories: ['dance', 'arts'],
    ),
  ];

  @override
  Future<Either<Failure, List<Course>>> getCourses() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800)); // Simulate delay
      return right(_allCourses);
    } catch (e) {
      return left(DataFailure(message: 'Failed to fetch courses: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> searchCourses(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (query.isEmpty) return right(_allCourses);

      final lowerQuery = query.toLowerCase();
      final filtered = _allCourses.where((course) {
        return course.title.toLowerCase().contains(lowerQuery) ||
            course.instructor.toLowerCase().contains(lowerQuery) ||
            (course.categories?.any(
                  (c) => c.toLowerCase().contains(lowerQuery),
                ) ??
                false);
      }).toList();

      return right(filtered);
    } catch (e) {
      return left(DataFailure(message: 'Search failed: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Course>>> getCoursesByCategory(
    String category,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      if (category.toLowerCase() == 'all') return right(_allCourses);

      final filtered = _allCourses.where((course) {
        return course.categories?.any(
              (c) => c.toLowerCase() == category.toLowerCase(),
            ) ??
            false;
      }).toList();

      return right(filtered);
    } catch (e) {
      return left(DataFailure(message: 'Filtering failed: $e'));
    }
  }
}
