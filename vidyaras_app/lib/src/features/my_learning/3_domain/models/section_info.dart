import 'package:freezed_annotation/freezed_annotation.dart';

part 'section_info.freezed.dart';
part 'section_info.g.dart';

/// Represents a section/module within a course
/// Used to organize lectures into logical groups
@freezed
class SectionInfo with _$SectionInfo {
  const factory SectionInfo({
    required String id,
    required String title,
    String? hindiTitle,
    @Default(0) int orderIndex,
    @Default(0) int totalDurationMinutes,
    @Default(0) int lectureCount,
    @Default(0) int completedCount,
  }) = _SectionInfo;

  factory SectionInfo.fromJson(Map<String, dynamic> json) =>
      _$SectionInfoFromJson(json);
}
