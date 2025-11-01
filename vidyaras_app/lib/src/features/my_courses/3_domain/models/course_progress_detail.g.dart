// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseProgressDetailImpl _$$CourseProgressDetailImplFromJson(
  Map<String, dynamic> json,
) => _$CourseProgressDetailImpl(
  summary: EnrolledCourse.fromJson(json['summary'] as Map<String, dynamic>),
  sections: (json['sections'] as List<dynamic>)
      .map((e) => CourseSection.fromJson(e as Map<String, dynamic>))
      .toList(),
  generalMaterials:
      (json['generalMaterials'] as List<dynamic>?)
          ?.map((e) => CourseMaterial.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  upcomingLiveClass: json['upcomingLiveClass'] == null
      ? null
      : LiveClassWindow.fromJson(
          json['upcomingLiveClass'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$CourseProgressDetailImplToJson(
  _$CourseProgressDetailImpl instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'sections': instance.sections,
  'generalMaterials': instance.generalMaterials,
  'upcomingLiveClass': instance.upcomingLiveClass,
};

_$CourseSectionImpl _$$CourseSectionImplFromJson(Map<String, dynamic> json) =>
    _$CourseSectionImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
      lectures:
          (json['lectures'] as List<dynamic>?)
              ?.map((e) => CourseLecture.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CourseSectionImplToJson(_$CourseSectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'orderIndex': instance.orderIndex,
      'lectures': instance.lectures,
    };

_$CourseLectureImpl _$$CourseLectureImplFromJson(Map<String, dynamic> json) =>
    _$CourseLectureImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      sectionId: json['sectionId'] as String,
      sectionTitle: json['sectionTitle'] as String,
      orderIndex: (json['orderIndex'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
      videoUrl: json['videoUrl'] as String?,
      materials:
          (json['materials'] as List<dynamic>?)
              ?.map((e) => CourseMaterial.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      accessStatus:
          $enumDecodeNullable(
            _$LectureAccessStatusEnumMap,
            json['accessStatus'],
            unknownValue: LectureAccessStatus.available,
          ) ??
          LectureAccessStatus.available,
      requiredQuiz: json['requiredQuiz'] == null
          ? null
          : QuizRequirement.fromJson(
              json['requiredQuiz'] as Map<String, dynamic>,
            ),
      isCompleted: json['isCompleted'] as bool?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      liveClass: json['liveClass'] == null
          ? null
          : LiveClassWindow.fromJson(json['liveClass'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CourseLectureImplToJson(_$CourseLectureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sectionId': instance.sectionId,
      'sectionTitle': instance.sectionTitle,
      'orderIndex': instance.orderIndex,
      'description': instance.description,
      'durationMinutes': instance.durationMinutes,
      'videoUrl': instance.videoUrl,
      'materials': instance.materials,
      'accessStatus': _$LectureAccessStatusEnumMap[instance.accessStatus]!,
      'requiredQuiz': instance.requiredQuiz,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'liveClass': instance.liveClass,
    };

const _$LectureAccessStatusEnumMap = {
  LectureAccessStatus.locked: 'locked',
  LectureAccessStatus.available: 'available',
  LectureAccessStatus.inProgress: 'inProgress',
  LectureAccessStatus.completed: 'completed',
};

_$CourseMaterialImpl _$$CourseMaterialImplFromJson(Map<String, dynamic> json) =>
    _$CourseMaterialImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      fileUrl: json['fileUrl'] as String,
      sectionId: json['sectionId'] as String?,
    );

Map<String, dynamic> _$$CourseMaterialImplToJson(
  _$CourseMaterialImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'type': instance.type,
  'fileUrl': instance.fileUrl,
  'sectionId': instance.sectionId,
};

_$LiveClassWindowImpl _$$LiveClassWindowImplFromJson(
  Map<String, dynamic> json,
) => _$LiveClassWindowImpl(
  id: json['id'] as String,
  scheduledAt: DateTime.parse(json['scheduledAt'] as String),
  durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 120,
  zoomLink: json['zoomLink'] as String,
  meetingId: json['meetingId'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  lectureId: json['lectureId'] as String?,
);

Map<String, dynamic> _$$LiveClassWindowImplToJson(
  _$LiveClassWindowImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'scheduledAt': instance.scheduledAt.toIso8601String(),
  'durationMinutes': instance.durationMinutes,
  'zoomLink': instance.zoomLink,
  'meetingId': instance.meetingId,
  'title': instance.title,
  'description': instance.description,
  'lectureId': instance.lectureId,
};
