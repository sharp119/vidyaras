import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../home/3_domain/models/course.dart';

/// Remote data source for courses feature
/// Uses direct Supabase queries instead of API endpoints
class CoursesRemoteDataSource {
  final SupabaseClient _supabase;

  CoursesRemoteDataSource(this._supabase);

  /// Fetch all courses from Supabase
  Future<List<Course>> getAllCourses() async {
    try {
      print('\n🔍 [CoursesRemoteDataSource] Fetching courses from Supabase...');

      final response = await _supabase
          .from('courses')
          .select()
          .eq('status', 'published') // Only show published courses
          .order('created_at', ascending: false);

      print('✅ Successfully loaded ${response.length} courses from Supabase');

      return (response as List).map((courseData) {
        // A course is free only if NOT premium AND price is null/zero
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
      print('❌ Error fetching courses from Supabase: $e');
      throw Exception('Failed to fetch courses: $e');
    }
  }

  /// Search courses by query
  Future<List<Course>> searchCourses(String query) async {
    try {
      if (query.isEmpty) {
        return getAllCourses();
      }

      print('\n🔍 Searching courses for: "$query"');

      final response = await _supabase
          .from('courses')
          .select()
          .eq('status', 'published') // Only show published courses
          .or('title.ilike.%$query%,instructor.ilike.%$query%')
          .order('created_at', ascending: false);

      print('✅ Found ${response.length} matching courses');

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
      print('❌ Error searching courses: $e');
      throw Exception('Failed to search courses: $e');
    }
  }

  /// Filter courses by category
  Future<List<Course>> getCoursesByCategory(String category) async {
    try {
      if (category.toLowerCase() == 'all') {
        return getAllCourses();
      }

      print('\n🔍 Filtering courses by category: "$category"');

      final response = await _supabase
          .from('courses')
          .select()
          .eq('status', 'published') // Only show published courses
          .ilike('category', category)
          .order('created_at', ascending: false);

      print('✅ Found ${response.length} courses in category "$category"');

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
      print('❌ Error filtering courses by category: $e');
      throw Exception('Failed to filter courses by category: $e');
    }
  }
}
