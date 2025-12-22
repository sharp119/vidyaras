import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/models/course.dart';
import '../../3_domain/models/course_detail.dart';
import '../../3_domain/models/section_info.dart';
import '../../3_domain/models/lesson_item.dart';
import '../../3_domain/models/pricing_option.dart';

/// Remote data source for home feature
/// Uses direct Supabase queries for course data
class HomeRemoteDataSource {
  final SupabaseClient _supabase;

  HomeRemoteDataSource(this._supabase);

  /// Fetch featured/trending courses for home screen
  Future<List<Course>> getFeaturedCourses() async {
    try {
      print(
        '\n🔍 [HomeRemoteDataSource] Fetching featured courses from Supabase...',
      );

      final response = await _supabase
          .from('courses')
          .select()
          .eq('status', 'published') // Only show published courses
          .order('enrolled_count', ascending: false)
          .limit(10);

      print('✅ Successfully loaded ${response.length} featured courses');

      return (response as List).map((courseData) {
        final isPremium = courseData['is_premium'] as bool? ?? false;
        final price = courseData['price'];
        final isFree =
            !isPremium &&
            (price == null ||
                price == 0 ||
                price == '0' ||
                price == '0.00' ||
                (price is num && price == 0));

        return Course(
          id: courseData['id'] as String,
          title: courseData['title'] as String,
          instructor: courseData['instructor'] as String? ?? 'Instructor',
          thumbnailUrl: courseData['thumbnail_url'] as String?,
          rating: courseData['rating'] != null
              ? double.tryParse(courseData['rating'].toString()) ?? 0.0
              : 0.0,
          reviewCount: courseData['review_count'] as int? ?? 0,
          enrolledCount: courseData['enrolled_count'] as int? ?? 0,
          price: isFree ? null : '₹${courseData['price']}',
          duration: courseData['duration'] as String?,
          isFree: isFree,
          isLive: courseData['is_live'] as bool? ?? false,
          isRecorded: courseData['is_recorded'] as bool? ?? false,
          hasFreeTrial: courseData['has_free_trial'] as bool? ?? false,
          category: courseData['category'] as String?,
          createdAt: courseData['created_at'] != null
              ? DateTime.parse(courseData['created_at'] as String)
              : null,
        );
      }).toList();
    } catch (e) {
      print('❌ Error fetching featured courses: $e');
      throw Exception('Failed to fetch featured courses: $e');
    }
  }

  /// Fetch user's enrolled courses
  /// Note: This integrates with the enrollments table
  Future<List<Course>> getUserEnrolledCourses(String userId) async {
    try {
      print('\n🔍 Fetching enrolled courses for user: $userId');

      final response = await _supabase
          .from('enrollments')
          .select('course_id, courses(*)')
          .eq('user_id', userId)
          .order('enrolled_at', ascending: false);

      final courses = (response as List).map((enrollment) {
        final courseData = enrollment['courses'] as Map<String, dynamic>;
        final isPremium = courseData['is_premium'] as bool? ?? false;
        final price = courseData['price'];
        final isFree =
            !isPremium &&
            (price == null ||
                price == 0 ||
                price == '0' ||
                price == '0.00' ||
                (price is num && price == 0));

        return Course(
          id: courseData['id'] as String,
          title: courseData['title'] as String,
          instructor: courseData['instructor'] as String? ?? 'Instructor',
          thumbnailUrl: courseData['thumbnail_url'] as String?,
          rating: courseData['rating'] != null
              ? double.tryParse(courseData['rating'].toString()) ?? 0.0
              : 0.0,
          reviewCount: courseData['review_count'] as int? ?? 0,
          enrolledCount: courseData['enrolled_count'] as int? ?? 0,
          price: isFree ? null : '₹${courseData['price']}',
          duration: courseData['duration'] as String?,
          isFree: isFree,
          isLive: courseData['is_live'] as bool? ?? false,
          isRecorded: courseData['is_recorded'] as bool? ?? false,
          hasFreeTrial: courseData['has_free_trial'] as bool? ?? false,
          category: courseData['category'] as String?,
          createdAt: courseData['created_at'] != null
              ? DateTime.parse(courseData['created_at'] as String)
              : null,
        );
      }).toList();

      print('✅ Found ${courses.length} enrolled courses');
      return courses;
    } catch (e) {
      print('❌ Error fetching enrolled courses: $e');
      return []; // Return empty list instead of throwing
    }
  }

  /// Fetch course detail by ID
  Future<CourseDetail> getCourseDetail(String courseId) async {
    try {
      print('\n🔍 Fetching course detail for: $courseId');

      // Fetch course data
      final response = await _supabase
          .from('courses')
          .select()
          .eq('id', courseId)
          .single();

      print('✅ Successfully loaded course detail');

      // Fetch modules for this course (separate query - no FK relationship)
      final modulesResponse = await _supabase
          .from('modules')
          .select()
          .eq('course_id', courseId)
          .order('order_index', ascending: true);

      print('✅ Found ${modulesResponse.length} modules');

      // Fetch lectures with nested select from modules
      final lecturesResponse = await _supabase
          .from('lectures')
          .select()
          .eq('course_id', courseId)
          .order('order_index', ascending: true);

      print('✅ Found ${lecturesResponse.length} lectures');

      // Build curriculum from modules and lectures
      final List<SectionInfo> curriculum = [];

      for (final module in modulesResponse as List) {
        final moduleId = module['id'] as String;
        final moduleTitle = module['title'] as String;

        // Filter lectures for this module
        final moduleLectures = (lecturesResponse as List)
            .where((lecture) => lecture['module_id'] == moduleId)
            .toList();

        // Map lectures to LessonItem
        final lessons = moduleLectures.map((lecture) {
          return LessonItem(
            id: lecture['id'] as String,
            title: lecture['title'] as String,
            durationMinutes: lecture['duration_minutes'] as int? ?? 0,
            description: lecture['description'] as String?,
            isLocked: false,
            isCompleted: false,
          );
        }).toList();

        // Calculate total duration for the module
        int totalDuration = 0;
        for (final lesson in lessons) {
          totalDuration += lesson.durationMinutes;
        }

        curriculum.add(
          SectionInfo(
            id: moduleId,
            title: moduleTitle,
            lessons: lessons,
            totalDurationMinutes: totalDuration,
          ),
        );
      }

      print('✅ Built curriculum with ${curriculum.length} modules');

      // Build basic course info
      final isPremium = response['is_premium'] as bool? ?? false;
      final price = response['price'];
      final isFree =
          !isPremium &&
          (price == null ||
              price == 0 ||
              price == '0' ||
              price == '0.00' ||
              (price is num && price == 0));

      final basicCourse = Course(
        id: response['id'] as String,
        title: response['title'] as String,
        instructor: response['instructor'] as String? ?? 'Instructor',
        thumbnailUrl: response['thumbnail_url'] as String?,
        rating: response['rating'] != null
            ? double.tryParse(response['rating'].toString()) ?? 0.0
            : 0.0,
        reviewCount: response['review_count'] as int? ?? 0,
        enrolledCount: response['enrolled_count'] as int? ?? 0,
        price: isFree ? null : '₹${response['price']}',
        duration: response['duration'] as String?,
        isFree: isFree,
        isLive: response['is_live'] as bool? ?? false,
        isRecorded: response['is_recorded'] as bool? ?? false,
        hasFreeTrial: response['has_free_trial'] as bool? ?? false,
        category: response['category'] as String?,
        createdAt: response['created_at'] != null
            ? DateTime.parse(response['created_at'] as String)
            : null,
      );

      // Build pricing
      final pricing = PricingOption(
        fullPrice: response['price'] != null
            ? int.tryParse(
                    response['price'].toString().replaceAll('.00', ''),
                  ) ??
                  0
            : 0,
        isFree: response['is_premium'] == false,
      );

      return CourseDetail(
        basicInfo: basicCourse,
        description: response['description'] as String? ?? '',
        whatYouLearn: response['what_you_learn'] != null
            ? (response['what_you_learn'] as List)
                  .map((e) => e.toString())
                  .toList()
            : [],
        courseIncludes: response['course_includes'] != null
            ? (response['course_includes'] as List)
                  .map((e) => e.toString())
                  .toList()
            : [],
        prerequisites: response['prerequisites'] != null
            ? (response['prerequisites'] as List)
                  .map((e) => e.toString())
                  .toList()
            : [],
        curriculum: curriculum,
        pricing: pricing,
        reviews: [],
        language:
            response['language'] as String? ?? 'Bilingual (Hindi + English)',
        hasCertificate: response['has_certificate'] as bool? ?? true,
        hasQuizzes: response['has_quizzes'] as bool? ?? true,
        hasMaterials: response['has_materials'] as bool? ?? true,
        accessDays: response['access_days'] as int?,
      );
    } catch (e) {
      print('❌ Error fetching course detail: $e');
      throw Exception('Failed to fetch course detail: $e');
    }
  }
}
