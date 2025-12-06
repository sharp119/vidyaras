import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/home_data.dart';
import '../../3_domain/models/user_profile.dart';
import '../../3_domain/models/course.dart';
import '../../3_domain/models/course_detail.dart';
import '../../3_domain/models/section_info.dart';
import '../../3_domain/models/lesson_item.dart';
import '../../3_domain/models/batch_info.dart';
import '../../3_domain/models/pricing_option.dart';
import '../../3_domain/models/course_review.dart';
import '../../3_domain/repositories/home_repository.dart';
import '../../../auth/3_domain/repositories/auth_repository.dart';

/// Mock implementation of HomeRepository
/// Returns sample data for development with actual user info
/// TODO: Replace with actual API implementation for stats and courses
class HomeRepositoryImpl implements HomeRepository {
  final AuthRepository _authRepository;

  HomeRepositoryImpl(this._authRepository);

  @override
  Future<Either<Failure, HomeData>> getHomeData() async {
    try {
      // Get the actual authenticated user
      final userResult = await _authRepository.getCurrentUser();

      // If we can't get user, return error
      final user = userResult.fold(
        (failure) => null,
        (user) => user,
      );

      if (user == null) {
        return left(const AuthFailure(message: 'User not authenticated'));
      }

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Build UserProfile from actual user + mock stats
      // TODO: Fetch actual stats from API
      final userProfile = UserProfile(
        id: user.id,
        name: user.name ?? user.email ?? 'User',
        email: user.email,
        avatarUrl: user.avatarUrl,
        isPremium: false, // TODO: Fetch from API
        enrolledCount: 2, // TODO: Fetch from API
        completedCount: 0, // TODO: Fetch from API
        certificatesCount: 1, // TODO: Fetch from API
        referralPoints: 150, // TODO: Fetch from API
        interests: ['music', 'wellness'], // TODO: Fetch from API
        createdAt: user.createdAt,
      );

      final homeData = HomeData(
        userProfile: userProfile,
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

  @override
  Future<Either<Failure, CourseDetail>> getCourseDetail(String courseId) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));

      // Find the basic course info first
      final mockData = await _getMockHomeData();
      final allCourses = [
        ...mockData.myCourses,
        ...mockData.recommendedCourses,
        ...mockData.freeCourses,
      ];

      final basicCourse = allCourses.firstWhere(
        (c) => c.id == courseId,
        orElse: () => throw Exception('Course not found'),
      );

      // Return detailed course information based on course ID
      final courseDetail = _getCourseDetailMockData(courseId, basicCourse);

      return right(courseDetail);
    } catch (e) {
      return left(
        DataFailure(message: 'Failed to load course details: ${e.toString()}'),
      );
    }
  }

  Future<HomeData> _getMockHomeData() async {
    // Get the actual authenticated user
    final userResult = await _authRepository.getCurrentUser();

    final user = userResult.fold(
      (failure) => null,
      (user) => user,
    );

    // Use actual user data or fallback to default
    final userProfile = user != null
        ? UserProfile(
            id: user.id,
            name: user.name ?? user.email ?? 'User',
            email: user.email,
            avatarUrl: user.avatarUrl,
            isPremium: false, // TODO: Fetch from API
            enrolledCount: 2, // TODO: Fetch from API
            completedCount: 0, // TODO: Fetch from API
            certificatesCount: 1, // TODO: Fetch from API
            referralPoints: 150, // TODO: Fetch from API
            interests: ['music', 'wellness'], // TODO: Fetch from API
            createdAt: user.createdAt,
          )
        : const UserProfile(
            id: '1',
            name: 'Guest User',
            email: 'guest@example.com',
            isPremium: false,
            enrolledCount: 0,
            completedCount: 0,
            certificatesCount: 0,
            referralPoints: 0,
          );

    return HomeData(
      userProfile: userProfile,
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
          hasFreeTrial: false,
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
          price: '₹1499',
          duration: '1 month',
          progress: 0.0,
          isRecorded: true,
          categories: ['wellness'],
        ),
      ],
      recommendedCourses: [
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
      ],
      freeCourses: [
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
      ],
    );
  }

  CourseDetail _getCourseDetailMockData(String courseId, Course basicCourse) {
    switch (courseId) {
      case '1': // Classical Hindustani Vocal - Live
        return CourseDetail(
          basicInfo: basicCourse,
          description:
              'Learn the fundamentals of Hindustani classical music with structured lessons and live practice sessions. Perfect for beginners who want to develop a strong foundation in classical vocal techniques.',
          whatYouLearn: [
            'Master fundamental techniques of Hindustani classical music',
            'Learn proper breath control and voice modulation',
            'Understand basic ragas and their applications',
            'Develop daily practice routines for continuous improvement',
            'Perform basic compositions with confidence',
          ],
          courseIncludes: [
            '24 live sessions (2 hours each)',
            'Recorded sessions available for review',
            'Quizzes after each module',
            'Downloadable practice materials and PDFs',
            'Certificate of completion',
          ],
          prerequisites: [
            'No prior music experience required',
            'Passion for classical music',
            'Commitment to regular practice',
          ],
          curriculum: [
            const SectionInfo(
              id: 's1',
              title: 'Week 1-4: Fundamentals',
              totalDurationMinutes: 360,
              lessons: [
                LessonItem(
                  id: 'l1',
                  title: 'Introduction to Swaras',
                  durationMinutes: 120,
                  description: 'Understanding the seven basic notes',
                ),
                LessonItem(
                  id: 'l2',
                  title: 'Voice Training Basics',
                  durationMinutes: 120,
                  description: 'Breath control and voice projection',
                ),
                LessonItem(
                  id: 'l3',
                  title: 'Practice Techniques',
                  durationMinutes: 120,
                  description: 'Daily practice routines and warm-ups',
                ),
              ],
            ),
            const SectionInfo(
              id: 's2',
              title: 'Week 5-8: Alankar Practice',
              totalDurationMinutes: 480,
              lessons: [
                LessonItem(
                  id: 'l4',
                  title: 'Understanding Alankar',
                  durationMinutes: 120,
                  description: 'What are Alankars and their importance',
                ),
                LessonItem(
                  id: 'l5',
                  title: 'Basic Patterns',
                  durationMinutes: 120,
                  description: 'Learning fundamental Alankar patterns',
                ),
                LessonItem(
                  id: 'l6',
                  title: 'Practice Sessions',
                  durationMinutes: 120,
                  description: 'Guided practice with instructor feedback',
                ),
                LessonItem(
                  id: 'l7',
                  title: 'Advanced Patterns',
                  durationMinutes: 120,
                  description: 'Complex Alankar variations',
                ),
              ],
            ),
            const SectionInfo(
              id: 's3',
              title: 'Week 9-12: Basic Ragas',
              totalDurationMinutes: 480,
              lessons: [
                LessonItem(
                  id: 'l8',
                  title: 'Introduction to Ragas',
                  durationMinutes: 120,
                  description: 'Understanding Raga structure',
                ),
                LessonItem(
                  id: 'l9',
                  title: 'Raag Yaman',
                  durationMinutes: 120,
                  description: 'Learning your first Raga',
                ),
                LessonItem(
                  id: 'l10',
                  title: 'Raag Bhairav',
                  durationMinutes: 120,
                  description: 'Exploring morning Ragas',
                ),
                LessonItem(
                  id: 'l11',
                  title: 'Final Performance',
                  durationMinutes: 120,
                  description: 'Live performance and feedback',
                ),
              ],
            ),
          ],
          pricing: const PricingOption(
            fullPrice: 4999,
            emiMonthlyPrice: 1666,
            emiTenure: 3,
          ),
          reviews: [
            CourseReview(
              id: 'r1',
              userName: 'Anjali Sharma',
              userAvatar:
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
              rating: 5.0,
              reviewText:
                  'Excellent course! Pandit Kumar explains everything so clearly. The live sessions are very interactive.',
              createdAt: DateTime.now().subtract(const Duration(days: 3)),
            ),
            CourseReview(
              id: 'r2',
              userName: 'Rahul Verma',
              userAvatar:
                  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
              rating: 4.5,
              reviewText:
                  'Great for beginners. The pace is perfect and practice materials are very helpful.',
              createdAt: DateTime.now().subtract(const Duration(days: 7)),
            ),
            CourseReview(
              id: 'r3',
              userName: 'Priya Desai',
              userAvatar:
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
              rating: 5.0,
              reviewText:
                  'Best decision I made this year. My voice has improved significantly!',
              createdAt: DateTime.now().subtract(const Duration(days: 14)),
            ),
          ],
          liveBatch: BatchInfo(
            id: 'b1',
            name: 'Morning Batch - January 2025',
            startDate: DateTime(2025, 1, 15),
            schedule: 'Mon, Wed, Fri',
            time: '7:00 AM IST',
            capacity: 30,
            enrolled: 28,
          ),
          language: 'Bilingual (Hindi + English)',
          hasCertificate: true,
          hasQuizzes: true,
          hasMaterials: true,
        );

      case '2': // Meditation & Mindfulness - Recorded
        return CourseDetail(
          basicInfo: basicCourse,
          description:
              'Discover inner peace and mental clarity through guided meditation and mindfulness practices. Learn techniques to reduce stress and improve focus in daily life.',
          whatYouLearn: [
            'Practice various meditation techniques',
            'Develop mindfulness in daily activities',
            'Manage stress and anxiety effectively',
            'Improve focus and concentration',
            'Create a sustainable meditation routine',
          ],
          courseIncludes: [
            '8 video lessons (4+ hours total)',
            'Quizzes to test understanding',
            'Guided meditation audio tracks',
            'PDF workbooks and practice guides',
            'Certificate upon completion',
          ],
          prerequisites: [
            'No prior meditation experience needed',
            'Open mind and willingness to practice',
            'Quiet space for practice',
          ],
          curriculum: [
            const SectionInfo(
              id: 's1',
              title: 'Section 1: Introduction to Meditation',
              totalDurationMinutes: 60,
              lessons: [
                LessonItem(
                  id: 'l1',
                  title: 'What is Meditation?',
                  durationMinutes: 20,
                  description: 'Understanding meditation and its benefits',
                ),
                LessonItem(
                  id: 'l2',
                  title: 'Creating Your Practice Space',
                  durationMinutes: 20,
                  description: 'Setting up for successful practice',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l3',
                  title: 'First Guided Session',
                  durationMinutes: 20,
                  description: 'Your first 10-minute meditation',
                  isLocked: true,
                ),
              ],
            ),
            const SectionInfo(
              id: 's2',
              title: 'Section 2: Breathing Techniques',
              totalDurationMinutes: 90,
              lessons: [
                LessonItem(
                  id: 'l4',
                  title: 'Breath Awareness',
                  durationMinutes: 25,
                  description: 'Learning to observe your breath',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l5',
                  title: 'Pranayama Basics',
                  durationMinutes: 30,
                  description: 'Introduction to yogic breathing',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l6',
                  title: 'Advanced Breathing',
                  durationMinutes: 35,
                  description: 'Alternate nostril and box breathing',
                  isLocked: true,
                ),
              ],
            ),
            const SectionInfo(
              id: 's3',
              title: 'Section 3: Mindfulness in Daily Life',
              totalDurationMinutes: 90,
              lessons: [
                LessonItem(
                  id: 'l7',
                  title: 'Mindful Eating',
                  durationMinutes: 25,
                  description: 'Bringing awareness to meals',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l8',
                  title: 'Walking Meditation',
                  durationMinutes: 30,
                  description: 'Meditation in movement',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l9',
                  title: 'Creating Your Routine',
                  durationMinutes: 35,
                  description: 'Building a sustainable practice',
                  isLocked: true,
                ),
              ],
            ),
          ],
          pricing: const PricingOption(
            fullPrice: 1499,
            emiMonthlyPrice: 500,
            emiTenure: 3,
          ),
          reviews: [
            CourseReview(
              id: 'r1',
              userName: 'Vikram Singh',
              rating: 4.5,
              reviewText:
                  'Very calming and practical. The guided sessions are perfect for beginners.',
              createdAt: DateTime.now().subtract(const Duration(days: 5)),
            ),
            CourseReview(
              id: 'r2',
              userName: 'Meera Patel',
              rating: 5.0,
              reviewText:
                  'Life-changing! I feel so much more focused and peaceful.',
              createdAt: DateTime.now().subtract(const Duration(days: 12)),
            ),
          ],
          accessDays: 90,
          language: 'Bilingual (Hindi + English)',
          hasCertificate: true,
          hasQuizzes: true,
          hasMaterials: true,
        );

      case '3': // Tabla Mastery - Live
        return CourseDetail(
          basicInfo: basicCourse,
          description:
              'Master the art of tabla playing with expert guidance from Ustad Zakir Hussain. Learn rhythmic patterns, compositions, and develop your own style.',
          whatYouLearn: [
            'Master basic to intermediate tabla techniques',
            'Learn traditional compositions (kaydas, relas)',
            'Understand taal system and rhythm cycles',
            'Develop hand technique and clarity',
            'Perform solo and accompaniment pieces',
          ],
          courseIncludes: [
            '16 live sessions (2 hours each)',
            'Recorded practice sessions',
            'Quizzes on rhythm and theory',
            'Audio recordings of compositions',
            'Certificate of completion',
          ],
          prerequisites: [
            'Own tabla set (assistance provided for purchase)',
            'Basic sense of rhythm helpful but not required',
            'Dedication to daily practice',
          ],
          curriculum: [
            const SectionInfo(
              id: 's1',
              title: 'Week 1-3: Foundations',
              totalDurationMinutes: 360,
              lessons: [
                LessonItem(
                  id: 'l1',
                  title: 'Tabla Introduction & Hand Positions',
                  durationMinutes: 120,
                  description: 'Basic strokes and positioning',
                ),
                LessonItem(
                  id: 'l2',
                  title: 'Learning Basic Bols',
                  durationMinutes: 120,
                  description: 'Fundamental syllables and sounds',
                ),
                LessonItem(
                  id: 'l3',
                  title: 'Teen Taal Introduction',
                  durationMinutes: 120,
                  description: 'Understanding 16-beat cycle',
                ),
              ],
            ),
            const SectionInfo(
              id: 's2',
              title: 'Week 4-6: Compositions',
              totalDurationMinutes: 360,
              lessons: [
                LessonItem(
                  id: 'l4',
                  title: 'First Kayda',
                  durationMinutes: 120,
                  description: 'Learning traditional composition',
                ),
                LessonItem(
                  id: 'l5',
                  title: 'Variations & Development',
                  durationMinutes: 120,
                  description: 'Creating palta variations',
                ),
                LessonItem(
                  id: 'l6',
                  title: 'Rela Practice',
                  durationMinutes: 120,
                  description: 'Fast-paced compositions',
                ),
              ],
            ),
            const SectionInfo(
              id: 's3',
              title: 'Week 7-8: Performance',
              totalDurationMinutes: 240,
              lessons: [
                LessonItem(
                  id: 'l7',
                  title: 'Solo Performance Techniques',
                  durationMinutes: 120,
                  description: 'Building a tabla solo',
                ),
                LessonItem(
                  id: 'l8',
                  title: 'Final Presentation',
                  durationMinutes: 120,
                  description: 'Live performance and feedback',
                ),
              ],
            ),
          ],
          pricing: const PricingOption(
            fullPrice: 3499,
            emiMonthlyPrice: 1166,
            emiTenure: 3,
          ),
          reviews: [
            CourseReview(
              id: 'r1',
              userName: 'Arjun Reddy',
              rating: 5.0,
              reviewText:
                  'Learning from Ustad ji is a dream come true! His teaching style is incredible.',
              createdAt: DateTime.now().subtract(const Duration(days: 2)),
            ),
            CourseReview(
              id: 'r2',
              userName: 'Kavita Iyer',
              rating: 4.5,
              reviewText:
                  'Excellent course structure. The practice materials are very helpful.',
              createdAt: DateTime.now().subtract(const Duration(days: 9)),
            ),
          ],
          liveBatch: BatchInfo(
            id: 'b2',
            name: 'Evening Batch - January 2025',
            startDate: DateTime(2025, 1, 20),
            schedule: 'Tue, Thu, Sat',
            time: '6:30 PM IST',
            capacity: 25,
            enrolled: 12,
          ),
          language: 'Bilingual (Hindi + English)',
          hasCertificate: true,
          hasQuizzes: true,
          hasMaterials: true,
        );

      case '4': // Yoga for Wellness - Live
        return CourseDetail(
          basicInfo: basicCourse,
          description:
              'Transform your body and mind with daily yoga practice. Learn asanas, pranayama, and meditation for holistic wellness and stress relief.',
          whatYouLearn: [
            'Practice 30+ essential yoga asanas',
            'Learn proper breathing techniques',
            'Develop flexibility and strength',
            'Reduce stress through yoga and meditation',
            'Create a personalized daily yoga routine',
          ],
          courseIncludes: [
            '20 live sessions (1 hour each)',
            'Daily practice videos',
            'Weekly progress quizzes',
            'PDF guides for home practice',
            'Certificate of completion',
          ],
          prerequisites: [
            'No prior yoga experience needed',
            'Yoga mat recommended',
            'Comfortable clothing for practice',
          ],
          curriculum: [
            const SectionInfo(
              id: 's1',
              title: 'Week 1: Foundations',
              totalDurationMinutes: 300,
              lessons: [
                LessonItem(
                  id: 'l1',
                  title: 'Introduction to Yoga',
                  durationMinutes: 60,
                  description: 'Philosophy and benefits',
                ),
                LessonItem(
                  id: 'l2',
                  title: 'Basic Standing Poses',
                  durationMinutes: 60,
                  description: 'Mountain, Warrior, Triangle poses',
                ),
                LessonItem(
                  id: 'l3',
                  title: 'Sun Salutation A',
                  durationMinutes: 60,
                  description: 'Learning Surya Namaskar',
                ),
                LessonItem(
                  id: 'l4',
                  title: 'Breathing Basics',
                  durationMinutes: 60,
                  description: 'Introduction to Pranayama',
                ),
                LessonItem(
                  id: 'l5',
                  title: 'Relaxation & Meditation',
                  durationMinutes: 60,
                  description: 'Savasana and basic meditation',
                ),
              ],
            ),
            const SectionInfo(
              id: 's2',
              title: 'Week 2: Building Strength',
              totalDurationMinutes: 300,
              lessons: [
                LessonItem(
                  id: 'l6',
                  title: 'Core Strengthening',
                  durationMinutes: 60,
                  description: 'Boat pose, plank variations',
                ),
                LessonItem(
                  id: 'l7',
                  title: 'Balancing Poses',
                  durationMinutes: 60,
                  description: 'Tree, Eagle, Dancer poses',
                ),
                LessonItem(
                  id: 'l8',
                  title: 'Forward Bends',
                  durationMinutes: 60,
                  description: 'Flexibility and stretching',
                ),
                LessonItem(
                  id: 'l9',
                  title: 'Backbends Basics',
                  durationMinutes: 60,
                  description: 'Cobra, Locust, Bridge poses',
                ),
                LessonItem(
                  id: 'l10',
                  title: 'Full Practice Flow',
                  durationMinutes: 60,
                  description: 'Combining all elements',
                ),
              ],
            ),
            const SectionInfo(
              id: 's3',
              title: 'Week 3-4: Advanced & Wellness',
              totalDurationMinutes: 600,
              lessons: [
                LessonItem(
                  id: 'l11',
                  title: 'Inversions Introduction',
                  durationMinutes: 60,
                  description: 'Shoulder stand, headstand prep',
                ),
                LessonItem(
                  id: 'l12',
                  title: 'Yoga for Stress Relief',
                  durationMinutes: 60,
                  description: 'Restorative poses',
                ),
                LessonItem(
                  id: 'l13',
                  title: 'Morning Energy Flow',
                  durationMinutes: 60,
                  description: 'Energizing sequences',
                ),
                LessonItem(
                  id: 'l14',
                  title: 'Evening Relaxation',
                  durationMinutes: 60,
                  description: 'Calming practice for better sleep',
                ),
                LessonItem(
                  id: 'l15',
                  title: 'Creating Your Routine',
                  durationMinutes: 60,
                  description: 'Personalizing your practice',
                ),
              ],
            ),
          ],
          pricing: const PricingOption(
            fullPrice: 1999,
            emiMonthlyPrice: 666,
            emiTenure: 3,
          ),
          reviews: [
            CourseReview(
              id: 'r1',
              userName: 'Sneha Kapoor',
              rating: 5.0,
              reviewText:
                  'Best yoga course I have taken! Swami ji is very knowledgeable and caring.',
              createdAt: DateTime.now().subtract(const Duration(days: 4)),
            ),
            CourseReview(
              id: 'r2',
              userName: 'Rohit Sharma',
              rating: 4.5,
              reviewText:
                  'Great for beginners. I feel so much more flexible and energetic!',
              createdAt: DateTime.now().subtract(const Duration(days: 11)),
            ),
            CourseReview(
              id: 'r3',
              userName: 'Anita Desai',
              rating: 5.0,
              reviewText:
                  'The daily sessions have transformed my health. Highly recommended!',
              createdAt: DateTime.now().subtract(const Duration(days: 18)),
            ),
          ],
          liveBatch: BatchInfo(
            id: 'b3',
            name: 'Morning Batch - January 2025',
            startDate: DateTime(2025, 1, 10),
            schedule: 'Daily (Mon-Sat)',
            time: '6:00 AM IST',
            capacity: 50,
            enrolled: 45,
          ),
          language: 'Bilingual (Hindi + English)',
          hasCertificate: true,
          hasQuizzes: true,
          hasMaterials: true,
        );

      case '5': // Harmonica for Beginners - FREE Recorded
        return CourseDetail(
          basicInfo: basicCourse,
          description:
              'Start your musical journey with harmonica! Learn basic techniques, play simple melodies, and discover the joy of making music. Perfect for absolute beginners.',
          whatYouLearn: [
            'Hold and position the harmonica correctly',
            'Play single notes cleanly',
            'Learn basic melodies and songs',
            'Understand harmonica notation',
            'Practice techniques for improvement',
          ],
          courseIncludes: [
            '6 video lessons (2+ hours total)',
            'Practice quizzes',
            'Song sheets and tabs (PDF)',
            'Practice backing tracks',
            'Certificate upon completion',
          ],
          prerequisites: [
            'C Major diatonic harmonica (10-hole)',
            'No prior music experience needed',
            'Enthusiasm to learn',
          ],
          curriculum: [
            const SectionInfo(
              id: 's1',
              title: 'Section 1: Getting Started',
              totalDurationMinutes: 45,
              lessons: [
                LessonItem(
                  id: 'l1',
                  title: 'Introduction to Harmonica',
                  durationMinutes: 15,
                  description: 'Types, anatomy, and how it works',
                ),
                LessonItem(
                  id: 'l2',
                  title: 'Holding and Hand Positions',
                  durationMinutes: 15,
                  description: 'Proper grip and technique',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l3',
                  title: 'First Sounds',
                  durationMinutes: 15,
                  description: 'Breathing and producing clean notes',
                  isLocked: true,
                ),
              ],
            ),
            const SectionInfo(
              id: 's2',
              title: 'Section 2: Playing Melodies',
              totalDurationMinutes: 75,
              lessons: [
                LessonItem(
                  id: 'l4',
                  title: 'Single Note Technique',
                  durationMinutes: 25,
                  description: 'Playing clear individual notes',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l5',
                  title: 'Your First Song',
                  durationMinutes: 25,
                  description: 'Playing "Mary Had a Little Lamb"',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l6',
                  title: 'Practice & Next Steps',
                  durationMinutes: 25,
                  description: 'Building your skills further',
                  isLocked: true,
                ),
              ],
            ),
          ],
          pricing: const PricingOption(
            fullPrice: 0,
            isFree: true,
          ),
          reviews: [
            CourseReview(
              id: 'r1',
              userName: 'Aditya Kumar',
              rating: 4.5,
              reviewText:
                  'Great free course! Very easy to follow and fun to learn.',
              createdAt: DateTime.now().subtract(const Duration(days: 6)),
            ),
            CourseReview(
              id: 'r2',
              userName: 'Pooja Singh',
              rating: 5.0,
              reviewText:
                  'Perfect introduction to harmonica. Now I want to learn more!',
              createdAt: DateTime.now().subtract(const Duration(days: 15)),
            ),
          ],
          accessDays: 60,
          language: 'Bilingual (Hindi + English)',
          hasCertificate: true,
          hasQuizzes: true,
          hasMaterials: true,
        );

      case '6': // Kathak Dance Fundamentals - Recorded
        return CourseDetail(
          basicInfo: basicCourse,
          description:
              'Embark on a journey into the graceful world of Kathak dance. Learn fundamental footwork, spins, expressions, and classical compositions from a master.',
          whatYouLearn: [
            'Master basic Kathak footwork (tatkar)',
            'Learn traditional compositions (tukras, todas)',
            'Develop rhythm and coordination',
            'Understand facial expressions (abhinaya)',
            'Perform chakkars (spins) with control',
          ],
          courseIncludes: [
            '15 video lessons (8+ hours total)',
            'Progress quizzes after each module',
            'Audio recordings of compositions',
            'PDF notation and practice guides',
            'Certificate of completion',
          ],
          prerequisites: [
            'No prior dance experience required',
            'Ghungroos (ankle bells) recommended',
            'Open practice space',
          ],
          curriculum: [
            const SectionInfo(
              id: 's1',
              title: 'Section 1: Foundations (Weeks 1-2)',
              totalDurationMinutes: 180,
              lessons: [
                LessonItem(
                  id: 'l1',
                  title: 'Introduction to Kathak',
                  durationMinutes: 30,
                  description: 'History and basic concepts',
                ),
                LessonItem(
                  id: 'l2',
                  title: 'Standing Position & Posture',
                  durationMinutes: 30,
                  description: 'Proper alignment and grace',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l3',
                  title: 'Basic Footwork (Tatkar)',
                  durationMinutes: 40,
                  description: 'Learning fundamental foot patterns',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l4',
                  title: 'Hand Movements (Hastak)',
                  durationMinutes: 40,
                  description: 'Basic hand gestures and positions',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l5',
                  title: 'First Composition',
                  durationMinutes: 40,
                  description: 'Simple tukra in teen taal',
                  isLocked: true,
                ),
              ],
            ),
            const SectionInfo(
              id: 's2',
              title: 'Section 2: Building Skills (Weeks 3-5)',
              totalDurationMinutes: 240,
              lessons: [
                LessonItem(
                  id: 'l6',
                  title: 'Intermediate Tatkar',
                  durationMinutes: 40,
                  description: 'Complex footwork patterns',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l7',
                  title: 'Introduction to Chakkars',
                  durationMinutes: 40,
                  description: 'Learning to spin gracefully',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l8',
                  title: 'Tukras & Todas',
                  durationMinutes: 50,
                  description: 'Traditional compositions',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l9',
                  title: 'Abhinaya Basics',
                  durationMinutes: 50,
                  description: 'Facial expressions and storytelling',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l10',
                  title: 'Rhythm & Coordination',
                  durationMinutes: 60,
                  description: 'Synchronizing movements with taal',
                  isLocked: true,
                ),
              ],
            ),
            const SectionInfo(
              id: 's3',
              title: 'Section 3: Performance (Weeks 6-8)',
              totalDurationMinutes: 300,
              lessons: [
                LessonItem(
                  id: 'l11',
                  title: 'Advanced Chakkars',
                  durationMinutes: 60,
                  description: 'Multiple spins with control',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l12',
                  title: 'Layakari (Tempo Variations)',
                  durationMinutes: 60,
                  description: 'Playing with rhythm',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l13',
                  title: 'Complete Composition',
                  durationMinutes: 60,
                  description: 'Full performance piece',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l14',
                  title: 'Stage Presence',
                  durationMinutes: 60,
                  description: 'Performance tips and techniques',
                  isLocked: true,
                ),
                LessonItem(
                  id: 'l15',
                  title: 'Final Project',
                  durationMinutes: 60,
                  description: 'Create and perform your piece',
                  isLocked: true,
                ),
              ],
            ),
          ],
          pricing: const PricingOption(
            fullPrice: 5999,
            emiMonthlyPrice: 2000,
            emiTenure: 3,
          ),
          reviews: [
            CourseReview(
              id: 'r1',
              userName: 'Divya Nair',
              rating: 5.0,
              reviewText:
                  'Absolutely beautiful course! The step-by-step progression is perfect.',
              createdAt: DateTime.now().subtract(const Duration(days: 8)),
            ),
            CourseReview(
              id: 'r2',
              userName: 'Shruti Patel',
              rating: 4.5,
              reviewText:
                  'Learning from Pandit ji is an honor. The content is very detailed.',
              createdAt: DateTime.now().subtract(const Duration(days: 20)),
            ),
          ],
          accessDays: 120,
          language: 'Bilingual (Hindi + English)',
          hasCertificate: true,
          hasQuizzes: true,
          hasMaterials: true,
        );

      default:
        throw Exception('Course not found');
    }
  }
}
