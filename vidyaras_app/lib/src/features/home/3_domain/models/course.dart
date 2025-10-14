import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// Course domain model
/// Represents a course in the VidyaRas application
@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String title,
    required String instructor,
    String? thumbnailUrl,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int enrolledCount,
    String? price,
    String? duration,
    @Default(false) bool isFree,
    @Default(false) bool isLive,
    @Default(false) bool hasFreeTrial,
    @Default(false) bool isRecorded,
    double? progress, // 0.0 to 1.0 for enrolled courses
    List<String>? categories,
    DateTime? createdAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
