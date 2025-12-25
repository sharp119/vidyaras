import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/models/enrolled_course.dart';
import '../../3_domain/models/lecture.dart';
import '../../3_domain/models/live_class.dart';
import '../../3_domain/models/course_material.dart';
import '../../3_domain/models/lecture_completion.dart';
import '../../3_domain/models/section_info.dart';
import '../../3_domain/models/lesson_content.dart';

/// Remote data source for My Learning feature
/// Handles all Supabase database operations
abstract class MyLearningRemoteDataSource {
  /// Fetch all enrolled courses for a user
  Future<List<EnrolledCourse>> getEnrolledCourses({required String userId});

  /// Fetch course details with all content
  Future<EnrolledCourse> getCourseDetails({
    required String userId,
    required String courseId,
  });

  /// Fetch lectures for a course
  Future<List<Lecture>> getCourseLectures({
    required String userId,
    required String courseId,
  });

  /// Fetch live classes for a course
  Future<List<LiveClass>> getCourseLiveClasses({required String courseId});

  /// Fetch upcoming live classes for enrolled courses
  Future<List<LiveClass>> getUpcomingLiveClasses({required String userId});

  /// Fetch course materials
  Future<List<CourseMaterial>> getCourseMaterials({required String courseId});

  /// Mark lecture as completed
  Future<LectureCompletion> markLectureComplete({
    required String userId,
    required String lectureId,
    int? watchedSeconds,
  });

  /// Get course progress statistics
  Future<Map<String, dynamic>> getCourseProgress({
    required String userId,
    required String courseId,
  });

  /// Update last accessed time
  Future<void> updateLastAccessed({
    required String userId,
    required String courseId,
  });

  /// Fetch modules for a course
  Future<List<SectionInfo>> getCourseModules({required String courseId});
}

/// Implementation using Supabase
class MyLearningRemoteDataSourceImpl implements MyLearningRemoteDataSource {
  final SupabaseClient _supabase;

  MyLearningRemoteDataSourceImpl(this._supabase);

  @override
  Future<List<EnrolledCourse>> getEnrolledCourses({
    required String userId,
  }) async {
    try {
      // Get all enrollments with course details
      final response = await _supabase
          .from('enrollments')
          .select('''
            id,
            enrolled_at,
            status,
            last_accessed_at,
            courses (
              id,
              title,
              instructor,
              thumbnail_url,
              description,
              rating,
              review_count,
              enrolled_count,
              price,
              duration,
              is_live,
              is_recorded,
              created_at
            )
          ''')
          .eq('user_id', userId)
          .order('enrolled_at', ascending: false);

      final List<EnrolledCourse> courses = [];

      for (final enrollment in response) {
        final courseData = enrollment['courses'] as Map<String, dynamic>;
        final courseId = courseData['id'] as String;

        // Get progress for this course
        final progressData = await getCourseProgress(
          userId: userId,
          courseId: courseId,
        );

        courses.add(
          EnrolledCourse(
            id: courseId,
            title: courseData['title'] as String,
            instructor: courseData['instructor'] as String,
            thumbnailUrl: courseData['thumbnail_url'] as String?,
            description: courseData['description'] as String?,
            rating: (courseData['rating'] as num?)?.toDouble() ?? 0.0,
            reviewCount: courseData['review_count'] as int? ?? 0,
            enrolledCount: courseData['enrolled_count'] as int? ?? 0,
            price: courseData['price'] != null
                ? (courseData['price'] is String
                      ? courseData['price'] as String
                      : courseData['price'].toString())
                : null,
            duration: courseData['duration'] != null
                ? (courseData['duration'] is String
                      ? courseData['duration'] as String
                      : courseData['duration'].toString())
                : null,
            isLive: courseData['is_live'] as bool? ?? false,
            isRecorded: courseData['is_recorded'] as bool? ?? false,
            enrollmentId: enrollment['id'] as String,
            enrolledAt: enrollment['enrolled_at'] != null
                ? DateTime.parse(enrollment['enrolled_at'] as String)
                : null,
            enrollmentStatus: enrollment['status'] as String? ?? 'active',
            lastAccessedAt: enrollment['last_accessed_at'] != null
                ? DateTime.parse(enrollment['last_accessed_at'] as String)
                : null,
            progress:
                (progressData['progress_percentage'] as num).toDouble() / 100,
            totalLectures: progressData['total_lectures'] as int,
            completedLectures: progressData['completed_lectures'] as int,
            totalDurationMinutes: progressData['total_duration_minutes'] as int,
            createdAt: courseData['created_at'] != null
                ? DateTime.parse(courseData['created_at'] as String)
                : null,
          ),
        );
      }

      return courses;
    } catch (e) {
      print('❌ Error fetching enrolled courses: $e');
      rethrow;
    }
  }

  @override
  Future<EnrolledCourse> getCourseDetails({
    required String userId,
    required String courseId,
  }) async {
    try {
      // Fetch course basic info and enrollment
      final enrollmentResponse = await _supabase
          .from('enrollments')
          .select('''
            id,
            enrolled_at,
            status,
            last_accessed_at,
            courses (
              id,
              title,
              instructor,
              thumbnail_url,
              description,
              rating,
              review_count,
              enrolled_count,
              price,
              duration,
              is_live,
              is_recorded,
              created_at
            )
          ''')
          .eq('user_id', userId)
          .eq('course_id', courseId)
          .single();

      final courseData = enrollmentResponse['courses'] as Map<String, dynamic>;

      // Fetch all related data in parallel
      final results = await Future.wait([
        getCourseLectures(userId: userId, courseId: courseId),
        getCourseLiveClasses(courseId: courseId),
        getCourseMaterials(courseId: courseId),
        getCourseProgress(userId: userId, courseId: courseId),
        getCourseModules(courseId: courseId),
      ]);

      final lectures = results[0] as List<Lecture>;
      final liveClasses = results[1] as List<LiveClass>;
      final materials = results[2] as List<CourseMaterial>;
      final progressData = results[3] as Map<String, dynamic>;
      final modules = results[4] as List<SectionInfo>;

      // Build sections from lectures and modules
      final sections = _buildSections(lectures, modules);

      return EnrolledCourse(
        id: courseId,
        title: courseData['title'] as String,
        instructor: courseData['instructor'] as String,
        thumbnailUrl: courseData['thumbnail_url'] as String?,
        description: courseData['description'] as String?,
        rating: (courseData['rating'] as num?)?.toDouble() ?? 0.0,
        reviewCount: courseData['review_count'] as int? ?? 0,
        enrolledCount: courseData['enrolled_count'] as int? ?? 0,
        price: courseData['price'] != null
            ? (courseData['price'] is String
                  ? courseData['price'] as String
                  : courseData['price'].toString())
            : null,
        duration: courseData['duration'] != null
            ? (courseData['duration'] is String
                  ? courseData['duration'] as String
                  : courseData['duration'].toString())
            : null,
        isLive: courseData['is_live'] as bool? ?? false,
        isRecorded: courseData['is_recorded'] as bool? ?? false,
        enrollmentId: enrollmentResponse['id'] as String,
        enrolledAt: enrollmentResponse['enrolled_at'] != null
            ? DateTime.parse(enrollmentResponse['enrolled_at'] as String)
            : null,
        enrollmentStatus: enrollmentResponse['status'] as String? ?? 'active',
        lastAccessedAt: enrollmentResponse['last_accessed_at'] != null
            ? DateTime.parse(enrollmentResponse['last_accessed_at'] as String)
            : null,
        progress: (progressData['progress_percentage'] as num).toDouble() / 100,
        totalLectures: progressData['total_lectures'] as int,
        completedLectures: progressData['completed_lectures'] as int,
        totalDurationMinutes: progressData['total_duration_minutes'] as int,
        sections: sections,
        lectures: lectures,
        liveClasses: liveClasses,
        materials: materials,
        createdAt: courseData['created_at'] != null
            ? DateTime.parse(courseData['created_at'] as String)
            : null,
      );
    } catch (e) {
      print('❌ Error fetching course details: $e');
      rethrow;
    }
  }

  @override
  Future<List<Lecture>> getCourseLectures({
    required String userId,
    required String courseId,
  }) async {
    try {
      final response = await _supabase
          .from('lessons')
          .select('*, lesson_contents(*)')
          .eq('course_id', courseId)
          .order('order_index');

      final lectures = <Lecture>[];

      for (final lectureData in response) {
        // Check if user has completed this lecture
        final completionResponse = await _supabase
            .from('lecture_completions')
            .select()
            .eq('user_id', userId)
            .eq('lecture_id', lectureData['id'])
            .maybeSingle();

        final isCompleted = completionResponse != null;
        final completedAt =
            completionResponse != null &&
                completionResponse['completed_at'] != null
            ? DateTime.parse(completionResponse['completed_at'] as String)
            : null;
        final watchedSeconds = completionResponse?['watched_seconds'] as int?;

        // Parse lesson contents
        final contentsData =
            (lectureData['lesson_contents'] as List<dynamic>?) ?? [];
        final contents =
            contentsData
                .map(
                  (data) => LessonContent(
                    id: data['id'] as String,
                    lessonId: data['lesson_id'] as String,
                    type: data['type'] as String,
                    title: data['title'] as String,
                    url: data['url'] as String?,
                    duration: data['duration'] as int?,
                    orderIndex: data['order_index'] as int?,
                    createdAt: data['created_at'] != null
                        ? DateTime.parse(data['created_at'] as String)
                        : null,
                    updatedAt: data['updated_at'] != null
                        ? DateTime.parse(data['updated_at'] as String)
                        : null,
                  ),
                )
                .toList()
              ..sort(
                (a, b) => (a.orderIndex ?? 0).compareTo(b.orderIndex ?? 0),
              );

        // Check if lecture is locked due to quiz requirement
        bool isLocked = false;
        if (lectureData['required_quiz_id'] != null) {
          // Check if user has passed the required quiz
          // For now, we'll check if the previous lecture is completed
          // TODO: Implement actual quiz completion check
          isLocked = !isCompleted;
        }

        lectures.add(
          Lecture(
            id: lectureData['id'] as String,
            courseId: lectureData['course_id'] as String,
            moduleId:
                lectureData['module_id'] as String? ??
                '', // Handle potential nulls during migration
            title: lectureData['title'] as String,
            description: lectureData['description'] as String?,
            orderIndex: lectureData['order_index'] as int,
            type: lectureData['type'] as String? ?? 'video',
            durationMinutes: lectureData['duration_minutes'] as int?,
            videoUrl: lectureData['video_url'] as String?,
            requiredQuizId: lectureData['required_quiz_id'] as String?,
            isCompleted: isCompleted,
            isLocked: isLocked,
            completedAt: completedAt,
            watchedSeconds: watchedSeconds,
            createdAt: lectureData['created_at'] != null
                ? DateTime.parse(lectureData['created_at'] as String)
                : null,
            contents: contents,
          ),
        );
      }

      return lectures;
    } catch (e) {
      print('❌ Error fetching course lectures: $e');
      rethrow;
    }
  }

  @override
  Future<List<LiveClass>> getCourseLiveClasses({
    required String courseId,
  }) async {
    try {
      final response = await _supabase
          .from('live_classes')
          .select()
          .eq('course_id', courseId)
          .order('scheduled_at');

      return response
          .map(
            (data) => LiveClass(
              id: data['id'] as String,
              courseId: data['course_id'] as String,
              lectureId: data['lecture_id'] as String?,
              title: data['title'] as String,
              description: data['description'] as String?,
              scheduledAt: DateTime.parse(data['scheduled_at'] as String),
              durationMinutes: data['duration_minutes'] as int? ?? 120,
              zoomLink: data['zoom_link'] as String,
              meetingId: data['meeting_id'] as String?,
              passcode: data['passcode'] as String?,
              recordingUrl: data['recording_url'] as String?,
              status: data['status'] as String? ?? 'upcoming',
              createdAt: data['created_at'] != null
                  ? DateTime.parse(data['created_at'] as String)
                  : null,
            ),
          )
          .toList();
    } catch (e) {
      print('❌ Error fetching live classes: $e');
      rethrow;
    }
  }

  @override
  Future<List<LiveClass>> getUpcomingLiveClasses({
    required String userId,
  }) async {
    try {
      // Get all enrolled course IDs
      final enrollments = await _supabase
          .from('enrollments')
          .select('course_id')
          .eq('user_id', userId)
          .eq('status', 'active');

      final courseIds = enrollments
          .map((e) => e['course_id'] as String)
          .toList();

      if (courseIds.isEmpty) return [];

      // Get upcoming live classes for these courses
      final response = await _supabase
          .from('live_classes')
          .select()
          .inFilter('course_id', courseIds)
          .inFilter('status', ['upcoming', 'live'])
          .order('scheduled_at');

      return response
          .map(
            (data) => LiveClass(
              id: data['id'] as String,
              courseId: data['course_id'] as String,
              lectureId: data['lecture_id'] as String?,
              title: data['title'] as String,
              description: data['description'] as String?,
              scheduledAt: DateTime.parse(data['scheduled_at'] as String),
              durationMinutes: data['duration_minutes'] as int? ?? 120,
              zoomLink: data['zoom_link'] as String,
              meetingId: data['meeting_id'] as String?,
              passcode: data['passcode'] as String?,
              recordingUrl: data['recording_url'] as String?,
              status: data['status'] as String? ?? 'upcoming',
              createdAt: data['created_at'] != null
                  ? DateTime.parse(data['created_at'] as String)
                  : null,
            ),
          )
          .toList();
    } catch (e) {
      print('❌ Error fetching upcoming live classes: $e');
      rethrow;
    }
  }

  @override
  Future<List<CourseMaterial>> getCourseMaterials({
    required String courseId,
  }) async {
    try {
      final response = await _supabase
          .from('course_materials')
          .select()
          .eq('course_id', courseId)
          .order('created_at');

      return response
          .map(
            (data) => CourseMaterial(
              id: data['id'] as String,
              courseId: data['course_id'] as String,
              title: data['title'] as String,
              type: data['type'] as String? ?? 'pdf',
              fileUrl: data['file_url'] as String,
              fileSizeMb: (data['file_size_mb'] as num?)?.toDouble(),
              sectionId: data['section_id'] as String?, // Use correct SQL field
              createdAt: data['created_at'] != null
                  ? DateTime.parse(data['created_at'] as String)
                  : null,
            ),
          )
          .toList();
    } catch (e) {
      print('❌ Error fetching course materials: $e');
      rethrow;
    }
  }

  @override
  Future<LectureCompletion> markLectureComplete({
    required String userId,
    required String lectureId,
    int? watchedSeconds,
  }) async {
    try {
      final response = await _supabase
          .from('lecture_completions')
          .insert({
            'user_id': userId,
            'lecture_id': lectureId,
            'watched_seconds': watchedSeconds,
            'completed_at': DateTime.now().toIso8601String(),
          })
          .select()
          .single();

      return LectureCompletion(
        id: response['id'] as String,
        userId: response['user_id'] as String,
        lectureId: response['lecture_id'] as String,
        completedAt: DateTime.parse(response['completed_at'] as String),
        watchedSeconds: response['watched_seconds'] as int?,
        createdAt: response['created_at'] != null
            ? DateTime.parse(response['created_at'] as String)
            : null,
      );
    } catch (e) {
      print('❌ Error marking lecture complete: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getCourseProgress({
    required String userId,
    required String courseId,
  }) async {
    try {
      // Get total lectures for the course
      final totalLecturesResponse = await _supabase
          .from('lessons')
          .select('id, duration_minutes')
          .eq('course_id', courseId);

      final totalLectures = totalLecturesResponse.length;
      final totalDuration = totalLecturesResponse.fold<int>(
        0,
        (sum, lecture) => sum + ((lecture['duration_minutes'] as int?) ?? 0),
      );

      // Get completed lectures for this user
      final completedResponse = await _supabase
          .from('lecture_completions')
          .select('lecture_id, watched_seconds')
          .eq('user_id', userId)
          .inFilter(
            'lecture_id',
            totalLecturesResponse.map((l) => l['id'] as String).toList(),
          );

      final completedLectures = completedResponse.length;
      final completedDuration = completedResponse.fold<int>(
        0,
        (sum, completion) =>
            sum + ((completion['watched_seconds'] as int?) ?? 0) ~/ 60,
      );

      final progressPercentage = totalLectures > 0
          ? (completedLectures / totalLectures) * 100
          : 0.0;

      return {
        'course_id': courseId,
        'user_id': userId,
        'total_lectures': totalLectures,
        'completed_lectures': completedLectures,
        'progress_percentage': progressPercentage,
        'total_duration_minutes': totalDuration,
        'completed_duration_minutes': completedDuration,
      };
    } catch (e) {
      print('❌ Error getting course progress: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateLastAccessed({
    required String userId,
    required String courseId,
  }) async {
    try {
      await _supabase
          .from('enrollments')
          .update({'last_accessed_at': DateTime.now().toIso8601String()})
          .eq('user_id', userId)
          .eq('course_id', courseId);
    } catch (e) {
      print('❌ Error updating last accessed: $e');
      rethrow;
    }
  }

  @override
  Future<List<SectionInfo>> getCourseModules({required String courseId}) async {
    try {
      final response = await _supabase
          .from('modules')
          .select()
          .eq('course_id', courseId)
          .order('order_index');

      return response
          .asMap()
          .entries
          .map(
            (entry) => SectionInfo(
              id: entry.value['id'] as String,
              title: entry.value['title'] as String,
              orderIndex: entry.value['order_index'] as int? ?? entry.key,
              totalDurationMinutes: 0, // Calculated later
              lectureCount: 0, // Calculated later
              completedCount: 0, // Calculated later
            ),
          )
          .toList();
    } catch (e) {
      print('❌ Error fetching course modules: $e');
      rethrow;
    }
  }

  /// Helper method to build section info from lectures and modules
  List<SectionInfo> _buildSections(
    List<Lecture> lectures,
    List<SectionInfo> modules,
  ) {
    final Map<String, List<Lecture>> lecturesByModule = {};

    // Group lectures by module ID
    for (final lecture in lectures) {
      if (!lecturesByModule.containsKey(lecture.moduleId)) {
        lecturesByModule[lecture.moduleId] = [];
      }
      lecturesByModule[lecture.moduleId]!.add(lecture);
    }

    // Return modules in order, with updated stats
    return modules.map((module) {
      final moduleLectures = lecturesByModule[module.id] ?? [];
      final totalDuration = moduleLectures.fold<int>(
        0,
        (sum, l) => sum + (l.durationMinutes ?? 0),
      );
      final completedCount = moduleLectures.where((l) => l.isCompleted).length;

      return module.copyWith(
        totalDurationMinutes: totalDuration,
        lectureCount: moduleLectures.length,
        completedCount: completedCount,
      );
    }).toList();
  }
}
