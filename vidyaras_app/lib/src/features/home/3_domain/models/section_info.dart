import 'package:freezed_annotation/freezed_annotation.dart';
import 'lesson_item.dart';

part 'section_info.freezed.dart';
part 'section_info.g.dart';

/// Represents a section/module in the course curriculum
/// Groups related lessons together
@freezed
class SectionInfo with _$SectionInfo {
  const factory SectionInfo({
    required String id,
    required String title,
    required List<LessonItem> lessons,
    int? totalDurationMinutes,
  }) = _SectionInfo;

  factory SectionInfo.fromJson(Map<String, dynamic> json) =>
      _$SectionInfoFromJson(json);
}
