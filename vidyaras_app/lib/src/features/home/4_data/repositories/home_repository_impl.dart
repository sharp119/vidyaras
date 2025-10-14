import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/home_data.dart';
import '../../3_domain/models/user_profile.dart';
import '../../3_domain/models/course.dart';
import '../../3_domain/repositories/home_repository.dart';

/// Mock implementation of HomeRepository
/// Returns sample data for development
/// TODO: Replace with actual API implementation
class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      final homeData = HomeData(
        userProfile: const UserProfile(
          id: '1',
          name: 'Priya Sharma',
          email: 'priya@example.com',
          avatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
          isPremium: true,
          enrolledCount: 2,
          completedCount: 0,
          certificatesCount: 1,
          referralPoints: 150,
          interests: ['music', 'wellness'],
        ),
        myCourses: [
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
        ],
        recommendedCourses: [
          const Course(
            id: '3',
            title: 'Classical Hindustani Vocal - Beginner',
            instructor: 'Pandit Ravi Kumar',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400',
            rating: 4.8,
            reviewCount: 89,
            enrolledCount: 145,
            price: '₹4999',
            duration: '3 months',
            isLive: true,
            hasFreeTrial: true,
            categories: ['music'],
          ),
          const Course(
            id: '4',
            title: 'Yoga for Beginners',
            instructor: 'Swami Ramdev',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
            rating: 4.7,
            reviewCount: 156,
            enrolledCount: 234,
            price: '₹1999',
            duration: '1 month',
            isRecorded: true,
            categories: ['wellness', 'yoga'],
          ),
        ],
        freeCourses: [
          const Course(
            id: '5',
            title: 'Harmonica for Beginners - Free',
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
            title: 'Introduction to Tabla',
            instructor: 'Ustad Zakir Hussain',
            thumbnailUrl:
                'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
            rating: 4.9,
            reviewCount: 421,
            enrolledCount: 892,
            duration: '3 weeks',
            isFree: true,
            isRecorded: true,
            categories: ['music'],
          ),
        ],
      );

      return right(homeData);
    } catch (e) {
      return left(DataFailure(message: 'Failed to load home data: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, HomeData>> refreshHomeData() async {
    // For now, just call getHomeData
    return getHomeData();
  }
}
