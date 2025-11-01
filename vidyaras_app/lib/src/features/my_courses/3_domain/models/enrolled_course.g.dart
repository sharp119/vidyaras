// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrolled_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnrolledCourseImpl _$$EnrolledCourseImplFromJson(Map<String, dynamic> json) =>
    _$EnrolledCourseImpl(
      enrollmentId: json['enrollmentId'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      duration: json['duration'] as String?,
      isLive: json['isLive'] as bool? ?? false,
      totalLectures: (json['totalLectures'] as num?)?.toInt() ?? 0,
      completedLectures: (json['completedLectures'] as num?)?.toInt() ?? 0,
      progressPercent: (json['progressPercent'] as num?)?.toDouble() ?? 0.0,
      nextLecture: json['nextLecture'] == null
          ? null
          : LectureProgressSummary.fromJson(
              json['nextLecture'] as Map<String, dynamic>,
            ),
      lastAccessedAt: json['lastAccessedAt'] == null
          ? null
          : DateTime.parse(json['lastAccessedAt'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$EnrolledCourseImplToJson(
  _$EnrolledCourseImpl instance,
) => <String, dynamic>{
  'enrollmentId': instance.enrollmentId,
  'courseId': instance.courseId,
  'title': instance.title,
  'instructor': instance.instructor,
  'thumbnailUrl': instance.thumbnailUrl,
  'duration': instance.duration,
  'isLive': instance.isLive,
  'totalLectures': instance.totalLectures,
  'completedLectures': instance.completedLectures,
  'progressPercent': instance.progressPercent,
  'nextLecture': instance.nextLecture,
  'lastAccessedAt': instance.lastAccessedAt?.toIso8601String(),
  'isCompleted': instance.isCompleted,
};

_$LectureProgressSummaryImpl _$$LectureProgressSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$LectureProgressSummaryImpl(
  lectureId: json['lectureId'] as String,
  title: json['title'] as String,
  sectionTitle: json['sectionTitle'] as String,
  isLocked: json['isLocked'] as bool? ?? false,
  requiredQuiz: json['requiredQuiz'] == null
      ? null
      : QuizRequirement.fromJson(json['requiredQuiz'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LectureProgressSummaryImplToJson(
  _$LectureProgressSummaryImpl instance,
) => <String, dynamic>{
  'lectureId': instance.lectureId,
  'title': instance.title,
  'sectionTitle': instance.sectionTitle,
  'isLocked': instance.isLocked,
  'requiredQuiz': instance.requiredQuiz,
};

_$QuizRequirementImpl _$$QuizRequirementImplFromJson(
  Map<String, dynamic> json,
) => _$QuizRequirementImpl(
  quizId: json['quizId'] as String,
  title: json['title'] as String,
  passingScore: (json['passingScore'] as num?)?.toInt() ?? 70,
);

Map<String, dynamic> _$$QuizRequirementImplToJson(
  _$QuizRequirementImpl instance,
) => <String, dynamic>{
  'quizId': instance.quizId,
  'title': instance.title,
  'passingScore': instance.passingScore,
};
