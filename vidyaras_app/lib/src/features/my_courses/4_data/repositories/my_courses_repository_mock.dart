import 'package:fpdart/fpdart.dart';

import 'package:vidyaras_app/src/features/my_courses/3_domain/models/course_progress_detail.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/repositories/my_courses_repository.dart';
import 'package:vidyaras_app/src/shared/domain/failures/failure.dart';

class MyCoursesRepositoryMock implements MyCoursesRepository {
  MyCoursesRepositoryMock();

  static final Map<String, EnrolledCourse> _courseSummaries = {
    _vocalsCourseId: EnrolledCourse(
      enrollmentId: 'enroll-001',
      courseId: _vocalsCourseId,
      title: 'Classical Hindustani Vocal - Beginner',
      instructor: 'Pandit Ravi Kumar',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=600',
      duration: '8 weeks',
      isLive: true,
      totalLectures: 12,
      completedLectures: 5,
      progressPercent: 0.42,
      nextLecture: LectureProgressSummary(
        lectureId: 'vocals-06',
        title: 'Voice Texture Practice',
        sectionTitle: 'Section 2 · Exploring Gamakas',
        isLocked: false,
      ),
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 2)),
      isCompleted: false,
    ),
    _mindfulnessCourseId: EnrolledCourse(
      enrollmentId: 'enroll-002',
      courseId: _mindfulnessCourseId,
      title: 'Meditation & Mindfulness',
      instructor: 'Dr. Anjali Mehta',
      thumbnailUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=600',
      duration: '4 weeks',
      isLive: false,
      totalLectures: 10,
      completedLectures: 10,
      progressPercent: 1.0,
      nextLecture: null,
      lastAccessedAt: DateTime.now().subtract(const Duration(days: 8)),
      isCompleted: true,
    ),
  };

  static final Map<String, CourseProgressDetail> _courseDetails = {
    _vocalsCourseId: CourseProgressDetail(
      summary: _courseSummaries[_vocalsCourseId]!,
      sections: [
        CourseSection(
          id: 'sec-1',
          title: 'Section 1 · Laying the Foundation',
          orderIndex: 1,
          lectures: [
            CourseLecture(
              id: 'vocals-01',
              title: 'Swara Basics & Sa Re Ga',
              sectionId: 'sec-1',
              sectionTitle: 'Section 1 · Laying the Foundation',
              orderIndex: 1,
              description: 'Understanding the Sa Re Ga Ma notes and shruti.',
              durationMinutes: 28,
              videoUrl: 'https://example.com/videos/vocals-01.mp4',
              materials: const [
                CourseMaterial(
                  id: 'mat-01',
                  title: 'Sargam Notes (PDF)',
                  type: 'pdf',
                  fileUrl: 'https://example.com/materials/sargam.pdf',
                ),
              ],
              accessStatus: LectureAccessStatus.completed,
              isCompleted: true,
              completedAt: DateTime.now().subtract(const Duration(days: 12)),
            ),
            CourseLecture(
              id: 'vocals-02',
              title: 'Breath Control Techniques',
              sectionId: 'sec-1',
              sectionTitle: 'Section 1 · Laying the Foundation',
              orderIndex: 2,
              description: 'Exercises to improve lung capacity and control.',
              durationMinutes: 32,
              videoUrl: 'https://example.com/videos/vocals-02.mp4',
              materials: const [
                CourseMaterial(
                  id: 'mat-02',
                  title: 'Breathwork Guide',
                  type: 'pdf',
                  fileUrl: 'https://example.com/materials/breathwork.pdf',
                ),
              ],
              accessStatus: LectureAccessStatus.completed,
              isCompleted: true,
              completedAt: DateTime.now().subtract(const Duration(days: 10)),
            ),
            CourseLecture(
              id: 'vocals-03',
              title: 'Alankars for Daily Practice',
              sectionId: 'sec-1',
              sectionTitle: 'Section 1 · Laying the Foundation',
              orderIndex: 3,
              description: 'Step-by-step alankar drills with tanpura.',
              durationMinutes: 30,
              videoUrl: 'https://example.com/videos/vocals-03.mp4',
              materials: const [
                CourseMaterial(
                  id: 'mat-03',
                  title: 'Alankar Audio Pack',
                  type: 'audio',
                  fileUrl: 'https://example.com/materials/alankar.zip',
                ),
              ],
              accessStatus: LectureAccessStatus.available,
              isCompleted: false,
            ),
          ],
        ),
        CourseSection(
          id: 'sec-2',
          title: 'Section 2 · Exploring Gamakas',
          orderIndex: 2,
          lectures: [
            CourseLecture(
              id: 'vocals-04',
              title: 'Gamaka Variations',
              sectionId: 'sec-2',
              sectionTitle: 'Section 2 · Exploring Gamakas',
              orderIndex: 4,
              description: 'Applying gamakas across common ragas.',
              durationMinutes: 34,
              videoUrl: 'https://example.com/videos/vocals-04.mp4',
              accessStatus: LectureAccessStatus.available,
              isCompleted: false,
            ),
            CourseLecture(
              id: 'vocals-05',
              title: 'Listening & Imitation Drills',
              sectionId: 'sec-2',
              sectionTitle: 'Section 2 · Exploring Gamakas',
              orderIndex: 5,
              description:
                  'Guided imitation practice with alaaps and taans.',
              durationMinutes: 29,
              videoUrl: 'https://example.com/videos/vocals-05.mp4',
              accessStatus: LectureAccessStatus.available,
              isCompleted: false,
            ),
            CourseLecture(
              id: 'vocals-06',
              title: 'Voice Texture Practice',
              sectionId: 'sec-2',
              sectionTitle: 'Section 2 · Exploring Gamakas',
              orderIndex: 6,
              description:
                  'Developing warm, resonant tone and smooth transitions.',
              durationMinutes: 31,
              videoUrl: 'https://example.com/videos/vocals-06.mp4',
              accessStatus: LectureAccessStatus.available,
              isCompleted: false,
            ),
            CourseLecture(
              id: 'vocals-07',
              title: 'Gamaka Quiz & Reflection',
              sectionId: 'sec-2',
              sectionTitle: 'Section 2 · Exploring Gamakas',
              orderIndex: 7,
              description: 'Assess understanding before moving forward.',
              durationMinutes: 15,
              accessStatus: LectureAccessStatus.locked,
              requiredQuiz: QuizRequirement(
                quizId: 'quiz-voice-01',
                title: 'Voice Culture Check',
                passingScore: 70,
              ),
              isCompleted: false,
            ),
          ],
        ),
      ],
      generalMaterials: const [
        CourseMaterial(
          id: 'mat-10',
          title: 'Practice Tracker Template',
          type: 'sheet',
          fileUrl: 'https://example.com/materials/practice-tracker.xlsx',
        ),
      ],
      upcomingLiveClass: LiveClassWindow(
        id: 'live-001',
        scheduledAt: DateTime.now().add(const Duration(days: 1, hours: 2)),
        durationMinutes: 90,
        zoomLink: 'https://zoom.us/j/123456789',
        meetingId: '123-456-789',
        title: 'Weekly Riyaz Circle',
        description: 'Live Q&A and guided practice session.',
        lectureId: 'vocals-04',
      ),
    ),
    _mindfulnessCourseId: CourseProgressDetail(
      summary: _courseSummaries[_mindfulnessCourseId]!,
      sections: [
        CourseSection(
          id: 'mind-1',
          title: 'Week 1 · Foundations',
          orderIndex: 1,
          lectures: [
            CourseLecture(
              id: 'mind-01',
              title: 'Why Mindfulness Matters',
              sectionId: 'mind-1',
              sectionTitle: 'Week 1 · Foundations',
              orderIndex: 1,
              description: 'Understanding stress and the brain.',
              durationMinutes: 18,
              videoUrl: 'https://example.com/videos/mind-01.mp4',
              accessStatus: LectureAccessStatus.completed,
              isCompleted: true,
              completedAt: DateTime.now().subtract(const Duration(days: 21)),
            ),
            CourseLecture(
              id: 'mind-02',
              title: 'Body Scan Basics',
              sectionId: 'mind-1',
              sectionTitle: 'Week 1 · Foundations',
              orderIndex: 2,
              durationMinutes: 22,
              videoUrl: 'https://example.com/videos/mind-02.mp4',
              materials: const [
                CourseMaterial(
                  id: 'mind-mat-01',
                  title: 'Guided Body Scan (Audio)',
                  type: 'audio',
                  fileUrl: 'https://example.com/materials/body-scan.mp3',
                ),
              ],
              accessStatus: LectureAccessStatus.completed,
              isCompleted: true,
              completedAt: DateTime.now().subtract(const Duration(days: 21)),
            ),
          ],
        ),
        CourseSection(
          id: 'mind-2',
          title: 'Week 2 · Deepening Awareness',
          orderIndex: 2,
          lectures: [
            CourseLecture(
              id: 'mind-05',
              title: 'Mindful Movement',
              sectionId: 'mind-2',
              sectionTitle: 'Week 2 · Deepening Awareness',
              orderIndex: 5,
              durationMinutes: 24,
              videoUrl: 'https://example.com/videos/mind-05.mp4',
              accessStatus: LectureAccessStatus.completed,
              isCompleted: true,
              completedAt: DateTime.now().subtract(const Duration(days: 19)),
            ),
            CourseLecture(
              id: 'mind-06',
              title: 'Loving-Kindness Meditation',
              sectionId: 'mind-2',
              sectionTitle: 'Week 2 · Deepening Awareness',
              orderIndex: 6,
              durationMinutes: 26,
              videoUrl: 'https://example.com/videos/mind-06.mp4',
              accessStatus: LectureAccessStatus.completed,
              isCompleted: true,
              completedAt: DateTime.now().subtract(const Duration(days: 18)),
            ),
          ],
        ),
      ],
      generalMaterials: const [
        CourseMaterial(
          id: 'mind-mat-10',
          title: 'Mindfulness Journal Prompts',
          type: 'pdf',
          fileUrl: 'https://example.com/materials/mindfulness-journal.pdf',
        ),
      ],
    ),
  };

  @override
  Future<Either<Failure, List<EnrolledCourse>>> getEnrolledCourses({
    required String userId,
  }) async {
    // Ignore userId for mock data; always return the sample list.
    return right(_courseSummaries.values.toList(growable: false));
  }

  @override
  Future<Either<Failure, CourseProgressDetail>> getCourseProgressDetail({
    required String userId,
    required String courseId,
  }) async {
    final detail = _courseDetails[courseId];
    if (detail == null) {
      return left(
        DataFailure(message: 'No mock detail found for course $courseId'),
      );
    }
    return right(detail);
  }

  static const String _vocalsCourseId = 'course-hindustani-vocals';
  static const String _mindfulnessCourseId = 'course-mindfulness';
}
