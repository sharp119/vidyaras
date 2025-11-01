import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:vidyaras_app/src/shared/domain/failures/failure.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/course_progress_detail.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/repositories/my_courses_repository.dart';

class MyCoursesRepositoryImpl implements MyCoursesRepository {
  MyCoursesRepositoryImpl(this._supabase);

  final SupabaseClient _supabase;

  @override
  Future<Either<Failure, List<EnrolledCourse>>> getEnrolledCourses({
    required String userId,
  }) async {
    try {
      final enrollmentResponse = await _supabase
          .from('enrollments')
          .select()
          .eq('user_id', userId)
          .order('enrolled_at', ascending: false);

      final enrollments = (enrollmentResponse as List<dynamic>)
          .cast<Map<String, dynamic>>();

      if (enrollments.isEmpty) {
        return right(const <EnrolledCourse>[]);
      }

      final courseIds = enrollments
          .map((e) => e['course_id'] as String?)
          .whereType<String>()
          .toSet()
          .toList();

      if (courseIds.isEmpty) {
        return right(const <EnrolledCourse>[]);
      }

      final coursesById = await _fetchCourses(courseIds);
      final lecturesByCourse = await _fetchLecturesGrouped(courseIds);
      final lectureIds = lecturesByCourse.values
          .expand((lectures) => lectures.map((lecture) => lecture['id'] as String))
          .toSet()
          .toList();

      final lectureCompletions = await _fetchLectureCompletions(
        userId: userId,
        lectureIds: lectureIds,
      );

      final requiredQuizIds = lecturesByCourse.values
          .expand((courseLectures) =>
              courseLectures.map((lecture) => lecture['required_quiz_id'] as String?))
          .whereType<String>()
          .toSet()
          .toList();

      final quizzesById = await _fetchQuizzes(requiredQuizIds);
      final quizAttemptsByQuizId = await _fetchQuizAttempts(
        userId: userId,
        quizIds: requiredQuizIds,
      );

      final enrolledCourses = <EnrolledCourse>[];
      for (final enrollment in enrollments) {
        final courseId = enrollment['course_id'] as String?;
        if (courseId == null) continue;

        final courseRecord = coursesById[courseId];
        if (courseRecord == null) continue;

        final courseLectures = lecturesByCourse[courseId] ?? const <Map<String, dynamic>>[];

        final enrolledCourse = _buildEnrolledCourse(
          enrollment: enrollment,
          courseRecord: courseRecord,
          courseLectures: courseLectures,
          lectureCompletions: lectureCompletions,
          quizzesById: quizzesById,
          quizAttemptsByQuizId: quizAttemptsByQuizId,
        );

        enrolledCourses.add(enrolledCourse);
      }

      return right(enrolledCourses);
    } catch (error, stackTrace) {
      return left(
        NetworkFailure(
          message: 'Failed to load enrolled courses: $error',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, CourseProgressDetail>> getCourseProgressDetail({
    required String userId,
    required String courseId,
  }) async {
    try {
      final enrollmentResponse = await _supabase
          .from('enrollments')
          .select()
          .eq('user_id', userId)
          .eq('course_id', courseId)
          .maybeSingle();

      final enrollment = enrollmentResponse as Map<String, dynamic>?;
      if (enrollment == null) {
        return left(
          const DataFailure(message: 'Enrollment not found for this course'),
        );
      }

      final courseRecord = await _supabase
          .from('courses')
          .select()
          .eq('id', courseId)
          .maybeSingle() as Map<String, dynamic>?;

      if (courseRecord == null) {
        return left(
          const DataFailure(message: 'Course not found'),
        );
      }

      final lecturesResponse = await _supabase
          .from('lectures')
          .select()
          .eq('course_id', courseId)
          .order('order_index', ascending: true);

      final courseLectures = (lecturesResponse as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final lectureIds = courseLectures
          .map((lecture) => lecture['id'] as String?)
          .whereType<String>()
          .toList();

      final lectureCompletions = await _fetchLectureCompletions(
        userId: userId,
        lectureIds: lectureIds,
      );

      final requiredQuizIds = courseLectures
          .map((lecture) => lecture['required_quiz_id'] as String?)
          .whereType<String>()
          .toSet()
          .toList();

      final quizzesById = await _fetchQuizzes(requiredQuizIds);
      final quizAttemptsByQuizId = await _fetchQuizAttempts(
        userId: userId,
        quizIds: requiredQuizIds,
      );

      final liveClasses = await _fetchLiveClasses(courseId);
      final materials = await _fetchMaterials(courseId);

      final summary = _buildEnrolledCourse(
        enrollment: enrollment,
        courseRecord: courseRecord,
        courseLectures: courseLectures,
        lectureCompletions: lectureCompletions,
        quizzesById: quizzesById,
        quizAttemptsByQuizId: quizAttemptsByQuizId,
      );

      final sections = _buildSections(
        lectures: courseLectures,
        lectureCompletions: lectureCompletions,
        quizzesById: quizzesById,
        quizAttemptsByQuizId: quizAttemptsByQuizId,
        liveClasses: liveClasses,
        materials: materials,
      );

      final upcomingLiveClass = _pickUpcomingLiveClass(liveClasses);
      final generalMaterials = materials
          .where((material) => material['section_id'] == null)
          .map(_mapMaterial)
          .toList();

      final detail = CourseProgressDetail(
        summary: summary,
        sections: sections,
        generalMaterials: generalMaterials,
        upcomingLiveClass: upcomingLiveClass,
      );

      return right(detail);
    } catch (error, stackTrace) {
      return left(
        NetworkFailure(
          message: 'Failed to load course detail: $error',
        ),
      );
    }
  }

  Future<Map<String, Map<String, dynamic>>> _fetchCourses(
    List<String> courseIds,
  ) async {
    final response = await _supabase
        .from('courses')
        .select()
        .inFilter('id', courseIds);

    final courses = (response as List<dynamic>).cast<Map<String, dynamic>>();

    return {for (final c in courses) c['id'] as String: c};
  }

  Future<Map<String, List<Map<String, dynamic>>>> _fetchLecturesGrouped(
    List<String> courseIds,
  ) async {
    if (courseIds.isEmpty) return const {};

    final response = await _supabase
        .from('lectures')
        .select()
        .inFilter('course_id', courseIds)
        .order('order_index', ascending: true);

    final lectures = (response as List<dynamic>).cast<Map<String, dynamic>>();

    final grouped = groupBy<Map<String, dynamic>, String>(
      lectures,
      (lecture) => lecture['course_id'] as String,
    );

    return grouped.map((key, value) => MapEntry(
          key,
          value
            ..sort((a, b) {
              final orderA = (a['order_index'] as num?)?.toInt() ?? 0;
              final orderB = (b['order_index'] as num?)?.toInt() ?? 0;
              return orderA.compareTo(orderB);
            }),
        ));
  }

  Future<Map<String, Map<String, dynamic>>> _fetchLectureCompletions({
    required String userId,
    required List<String> lectureIds,
  }) async {
    if (lectureIds.isEmpty) return const {};

    final response = await _supabase
        .from('lecture_completions')
        .select()
        .eq('user_id', userId)
        .inFilter('lecture_id', lectureIds);

    final completions = (response as List<dynamic>).cast<Map<String, dynamic>>();

    final result = <String, Map<String, dynamic>>{};
    for (final completion in completions) {
      final lectureId = completion['lecture_id'] as String?;
      if (lectureId != null) {
        result[lectureId] = completion;
      }
    }
    return result;
  }

  Future<Map<String, Map<String, dynamic>>> _fetchQuizzes(
    List<String> quizIds,
  ) async {
    if (quizIds.isEmpty) return const {};

    final response = await _supabase
        .from('quizzes')
        .select()
        .inFilter('id', quizIds);

    final quizzes = (response as List<dynamic>).cast<Map<String, dynamic>>();
    return {for (final quiz in quizzes) quiz['id'] as String: quiz};
  }

  Future<Map<String, Map<String, dynamic>>> _fetchQuizAttempts({
    required String userId,
    required List<String> quizIds,
  }) async {
    if (quizIds.isEmpty) return const {};

    final response = await _supabase
        .from('quiz_attempts')
        .select()
        .eq('user_id', userId)
        .inFilter('quiz_id', quizIds)
        .order('started_at', ascending: false);

    final attempts = (response as List<dynamic>).cast<Map<String, dynamic>>();

    // Keep the latest attempt per quiz
    final latestAttempts = <String, Map<String, dynamic>>{};
    for (final attempt in attempts) {
      final quizId = attempt['quiz_id'] as String?;
      if (quizId == null) continue;
      latestAttempts.putIfAbsent(quizId, () => attempt);
    }
    return latestAttempts;
  }

  Future<List<Map<String, dynamic>>> _fetchLiveClasses(String courseId) async {
    final response = await _supabase
        .from('live_classes')
        .select()
        .eq('course_id', courseId)
        .order('scheduled_at', ascending: true);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> _fetchMaterials(String courseId) async {
    final response = await _supabase
        .from('course_materials')
        .select()
        .eq('course_id', courseId)
        .order('created_at', ascending: true);

    return (response as List<dynamic>).cast<Map<String, dynamic>>();
  }

  EnrolledCourse _buildEnrolledCourse({
    required Map<String, dynamic> enrollment,
    required Map<String, dynamic> courseRecord,
    required List<Map<String, dynamic>> courseLectures,
    required Map<String, Map<String, dynamic>> lectureCompletions,
    required Map<String, Map<String, dynamic>> quizzesById,
    required Map<String, Map<String, dynamic>> quizAttemptsByQuizId,
  }) {
    final completedLectureIds = lectureCompletions.keys.toSet();
    final totalLectures = courseLectures.length;
    final completedLectures = courseLectures
        .where((lecture) => completedLectureIds.contains(lecture['id']))
        .length;

    final progressPercent =
        totalLectures == 0 ? 0.0 : completedLectures / totalLectures;

    final enrollmentId = enrollment['id'] as String;
    final lastAccessedAtRaw = enrollment['last_accessed_at'];
    DateTime? lastAccessedAt;
    if (lastAccessedAtRaw is String) {
      lastAccessedAt = DateTime.tryParse(lastAccessedAtRaw);
    } else if (lastAccessedAtRaw is DateTime) {
      lastAccessedAt = lastAccessedAtRaw;
    }

    final nextLectureSummary = _findNextLectureSummary(
      lectures: courseLectures,
      completedLectureIds: completedLectureIds,
      quizzesById: quizzesById,
      quizAttemptsByQuizId: quizAttemptsByQuizId,
    );

    final isCompleted =
        totalLectures > 0 && completedLectures >= totalLectures;

    return EnrolledCourse(
      enrollmentId: enrollmentId,
      courseId: courseRecord['id'] as String,
      title: courseRecord['title'] as String? ?? 'Course',
      instructor: courseRecord['instructor'] as String? ?? 'Instructor',
      thumbnailUrl: courseRecord['thumbnail_url'] as String?,
      duration: courseRecord['duration'] as String?,
      isLive: courseRecord['is_live'] == true,
      totalLectures: totalLectures,
      completedLectures: completedLectures,
      progressPercent: progressPercent.clamp(0, 1),
      nextLecture: nextLectureSummary,
      lastAccessedAt: lastAccessedAt,
      isCompleted: isCompleted,
    );
  }

  LectureProgressSummary? _findNextLectureSummary({
    required List<Map<String, dynamic>> lectures,
    required Set<String> completedLectureIds,
    required Map<String, Map<String, dynamic>> quizzesById,
    required Map<String, Map<String, dynamic>> quizAttemptsByQuizId,
  }) {
    bool previousCompleted = true;

    for (final lecture in lectures) {
      final lectureId = lecture['id'] as String?;
      if (lectureId == null) continue;

      final isCompleted = completedLectureIds.contains(lectureId);

      if (isCompleted) {
        continue;
      }

      final requiredQuizId = lecture['required_quiz_id'] as String?;
      final quizRequirement = requiredQuizId != null
          ? _mapQuizRequirement(quizzesById[requiredQuizId])
          : null;

      bool isLocked = false;
      if (!previousCompleted) {
        isLocked = true;
      } else if (requiredQuizId != null) {
        isLocked = !_hasPassedRequiredQuiz(
          requiredQuizId: requiredQuizId,
          quizzesById: quizzesById,
          quizAttemptsByQuizId: quizAttemptsByQuizId,
        );
      }

      return LectureProgressSummary(
        lectureId: lectureId,
        title: lecture['title'] as String? ?? 'Lecture',
        sectionTitle: lecture['section_title'] as String? ?? '',
        isLocked: isLocked,
        requiredQuiz: quizRequirement,
      );
    }

    return null;
  }

  List<CourseSection> _buildSections({
    required List<Map<String, dynamic>> lectures,
    required Map<String, Map<String, dynamic>> lectureCompletions,
    required Map<String, Map<String, dynamic>> quizzesById,
    required Map<String, Map<String, dynamic>> quizAttemptsByQuizId,
    required List<Map<String, dynamic>> liveClasses,
    required List<Map<String, dynamic>> materials,
  }) {
    final completedLectureIds = lectureCompletions.keys.toSet();

    final sortedLectures = [...lectures]
      ..sort((a, b) {
        final orderA = (a['order_index'] as num?)?.toInt() ?? 0;
        final orderB = (b['order_index'] as num?)?.toInt() ?? 0;
        return orderA.compareTo(orderB);
      });

    final lectureStates = <String, _LectureState>{};
    bool previousCompletedGlobal = true;

    for (final lecture in sortedLectures) {
      final lectureId = lecture['id'] as String?;
      if (lectureId == null) continue;

      final isCompleted = completedLectureIds.contains(lectureId);
      final requiredQuizId = lecture['required_quiz_id'] as String?;
      final quizRequirement = requiredQuizId != null
          ? _mapQuizRequirement(quizzesById[requiredQuizId])
          : null;

      bool isLocked = false;
      if (!previousCompletedGlobal) {
        isLocked = true;
      } else if (requiredQuizId != null) {
        isLocked = !_hasPassedRequiredQuiz(
          requiredQuizId: requiredQuizId,
          quizzesById: quizzesById,
          quizAttemptsByQuizId: quizAttemptsByQuizId,
        );
      }

      LectureAccessStatus status;
      if (isCompleted) {
        status = LectureAccessStatus.completed;
      } else if (isLocked) {
        status = LectureAccessStatus.locked;
      } else {
        status = LectureAccessStatus.available;
      }

      final completedAt = isCompleted
          ? _parseDateTime(lectureCompletions[lectureId]?['completed_at'])
          : null;

      lectureStates[lectureId] = _LectureState(
        status: status,
        quizRequirement: quizRequirement,
        completedAt: completedAt,
      );

      if (!isCompleted && (isLocked || status == LectureAccessStatus.available)) {
        previousCompletedGlobal = false;
      }
    }

    final materialsBySection = groupBy<Map<String, dynamic>, String?>(
      materials,
      (material) => material['section_id'] as String?,
    );

    final liveClassByLectureId = {
      for (final cls in liveClasses)
        if (cls['lecture_id'] != null) cls['lecture_id'] as String: cls
    };

    final groupedBySection = groupBy<Map<String, dynamic>, String>(
      lectures,
      (lecture) => lecture['section_id'] as String? ?? 'default',
    );

    final sections = <CourseSection>[];
    for (final entry in groupedBySection.entries) {
      final sectionId = entry.key;
      final lecturesInSection = entry.value
        ..sort((a, b) {
          final orderA = (a['order_index'] as num?)?.toInt() ?? 0;
          final orderB = (b['order_index'] as num?)?.toInt() ?? 0;
          return orderA.compareTo(orderB);
        });

      final courseLectures = <CourseLecture>[];

      for (final lecture in lecturesInSection) {
        final lectureId = lecture['id'] as String?;
        if (lectureId == null) continue;

        final state = lectureStates[lectureId];
        final accessStatus = state?.status ?? LectureAccessStatus.locked;
        final isCompleted = accessStatus == LectureAccessStatus.completed;

        LiveClassWindow? liveClass;
        final liveClassRecord = liveClassByLectureId[lectureId];
        if (liveClassRecord != null) {
          liveClass = _mapLiveClass(liveClassRecord);
        }

        final lectureMaterials = (materialsBySection[sectionId] ?? const [])
            .map(_mapMaterial)
            .toList();

        final courseLecture = CourseLecture(
          id: lectureId,
          title: lecture['title'] as String? ?? 'Lecture',
          sectionId: sectionId,
          sectionTitle: lecture['section_title'] as String? ?? '',
          orderIndex: (lecture['order_index'] as num?)?.toInt() ?? 0,
          description: lecture['description'] as String?,
          durationMinutes: (lecture['duration_minutes'] as num?)?.toInt(),
          videoUrl: lecture['video_url'] as String?,
          materials: lectureMaterials,
          accessStatus: accessStatus,
          requiredQuiz: state?.quizRequirement,
          isCompleted: isCompleted,
          completedAt: state?.completedAt,
          liveClass: liveClass,
        );

        courseLectures.add(courseLecture);
      }

      final sectionTitle =
          lecturesInSection.first['section_title'] as String? ?? 'Section';

      sections.add(
        CourseSection(
          id: sectionId,
          title: sectionTitle,
          orderIndex: (lecturesInSection.first['order_index'] as num?)?.toInt() ?? 0,
          lectures: courseLectures,
        ),
      );
    }

    sections.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));
    return sections;
  }

  LiveClassWindow? _pickUpcomingLiveClass(List<Map<String, dynamic>> liveClasses) {
    if (liveClasses.isEmpty) return null;

    final now = DateTime.now();
    Map<String, dynamic>? bestMatch;

    for (final liveClass in liveClasses) {
      final scheduledAt = _parseDateTime(liveClass['scheduled_at']);
      if (scheduledAt == null) continue;

      if (scheduledAt.isAfter(now)) {
        if (bestMatch == null ||
            scheduledAt.isBefore(_parseDateTime(bestMatch['scheduled_at'])!)) {
          bestMatch = liveClass;
        }
      } else {
        final duration = (liveClass['duration_minutes'] as num?)?.toInt() ?? 120;
        final endTime = scheduledAt.add(Duration(minutes: duration));
        final bestEndTime = bestMatch == null
            ? null
            : _parseDateTime(bestMatch['scheduled_at'])!
                .add(Duration(minutes: (bestMatch['duration_minutes'] as num?)?.toInt() ?? 120));

        if (now.isAfter(scheduledAt) && now.isBefore(endTime)) {
          bestMatch = liveClass;
        } else if (bestMatch == null && endTime.isAfter(now)) {
          bestMatch = liveClass;
        } else if (bestMatch != null && bestEndTime != null && now.isAfter(bestEndTime)) {
          // Prefer future/live sessions if current best already finished
          bestMatch = liveClass;
        }
      }
    }

    return bestMatch == null ? null : _mapLiveClass(bestMatch);
  }

  bool _hasPassedRequiredQuiz({
    required String requiredQuizId,
    required Map<String, Map<String, dynamic>> quizzesById,
    required Map<String, Map<String, dynamic>> quizAttemptsByQuizId,
  }) {
    final quizRecord = quizzesById[requiredQuizId];
    if (quizRecord == null) {
      return false;
    }

    final attempt = quizAttemptsByQuizId[requiredQuizId];
    if (attempt == null) {
      return false;
    }

    final isCompleted = attempt['is_completed'] == true;
    if (!isCompleted) return false;

    final passingScore = (quizRecord['passing_score'] as num?)?.toInt() ?? 70;
    final percentage = (attempt['percentage'] as num?)?.toDouble() ??
        _calculatePercentage(
          score: attempt['score'],
          totalMarks: attempt['total_marks'],
        );

    return percentage >= passingScore;
  }

  QuizRequirement? _mapQuizRequirement(Map<String, dynamic>? quizRecord) {
    if (quizRecord == null) return null;

    return QuizRequirement(
      quizId: quizRecord['id'] as String,
      title: quizRecord['title'] as String? ?? 'Course Quiz',
      passingScore: (quizRecord['passing_score'] as num?)?.toInt() ?? 70,
    );
  }

  LiveClassWindow _mapLiveClass(Map<String, dynamic> liveClass) {
    return LiveClassWindow(
      id: liveClass['id'] as String,
      scheduledAt: _parseDateTime(liveClass['scheduled_at']) ?? DateTime.now(),
      durationMinutes: (liveClass['duration_minutes'] as num?)?.toInt() ?? 120,
      zoomLink: liveClass['zoom_link'] as String? ?? '',
      meetingId: liveClass['meeting_id'] as String?,
      title: liveClass['title'] as String?,
      description: liveClass['description'] as String?,
      lectureId: liveClass['lecture_id'] as String?,
    );
  }

  CourseMaterial _mapMaterial(Map<String, dynamic> material) {
    return CourseMaterial(
      id: material['id'] as String,
      title: material['title'] as String? ?? 'Resource',
      type: material['type'] as String? ?? 'pdf',
      fileUrl: material['file_url'] as String? ?? '',
      sectionId: material['section_id'] as String?,
    );
  }

  double _calculatePercentage({
    dynamic score,
    dynamic totalMarks,
  }) {
    final scoreValue = (score as num?)?.toDouble();
    final total = (totalMarks as num?)?.toDouble();

    if (scoreValue == null || total == null || total == 0) {
      return 0;
    }

    return (scoreValue / total) * 100;
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

class _LectureState {
  const _LectureState({
    required this.status,
    this.quizRequirement,
    this.completedAt,
  });

  final LectureAccessStatus status;
  final QuizRequirement? quizRequirement;
  final DateTime? completedAt;
}
