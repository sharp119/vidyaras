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
          .order('created_at', ascending: false);

      print('✅ Successfully loaded ${response.length} courses from Supabase');

      return (response as List).map((courseData) {
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
          price:
              (courseData['is_premium'] == false ||
                  courseData['price'] == null ||
                  courseData['price'] == '0' ||
                  courseData['price'] == '0.00')
              ? null
              : '₹${courseData['price']}',
          duration: courseData['duration'] as String?,
          isFree:
              courseData['is_premium'] == false ||
              courseData['price'] == null ||
              courseData['price'] == '0' ||
              courseData['price'] == '0.00',
          isLive: courseData['is_live'] as bool? ?? false,
          isRecorded: courseData['is_recorded'] as bool? ?? false,
          hasFreeTrial: courseData['has_free_trial'] as bool? ?? false,
          categories: courseData['category'] != null
              ? [courseData['category'] as String]
              : [],
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
          .or('title.ilike.%$query%,instructor.ilike.%$query%')
          .order('created_at', ascending: false);

      print('✅ Found ${response.length} matching courses');

      return (response as List).map((courseData) {
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
          price: courseData['price'] != null ? '₹${courseData['price']}' : null,
          duration: courseData['duration'] as String?,
          isFree: courseData['is_premium'] == false,
          isLive: courseData['is_live'] as bool? ?? false,
          isRecorded: courseData['is_recorded'] as bool? ?? false,
          hasFreeTrial: courseData['has_free_trial'] as bool? ?? false,
          categories: courseData['category'] != null
              ? [courseData['category'] as String]
              : [],
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
          .ilike('category', category)
          .order('created_at', ascending: false);

      print('✅ Found ${response.length} courses in category "$category"');

      return (response as List).map((courseData) {
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
          price: courseData['price'] != null ? '₹${courseData['price']}' : null,
          duration: courseData['duration'] as String?,
          isFree: courseData['is_premium'] == false,
          isLive: courseData['is_live'] as bool? ?? false,
          isRecorded: courseData['is_recorded'] as bool? ?? false,
          hasFreeTrial: courseData['has_free_trial'] as bool? ?? false,
          categories: courseData['category'] != null
              ? [courseData['category'] as String]
              : [],
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
