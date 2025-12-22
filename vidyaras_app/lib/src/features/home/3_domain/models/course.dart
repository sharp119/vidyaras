import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

/// Course domain model
/// Represents a course in the VidyaRas application
/// Aligned with the courses table in Supabase
@freezed
class Course with _$Course {
  const factory Course({
    required String id,
    required String title,
    required String instructor,
    String? thumbnailUrl,
    String? description,
    @Default(0.0) double rating,
    @Default(0) int reviewCount,
    @Default(0) int enrolledCount,
    String? price,
    double? originalPrice,
    String? duration,
    @Default(false) bool isFree,
    @Default(false) bool isLive,
    @Default(false) bool hasFreeTrial,
    @Default(false) bool isRecorded,
    @Default(false) bool hasCertificate,
    @Default(false) bool hasQuizzes,
    @Default(false) bool hasMaterials,
    String? category,
    @Default('Bilingual (Hindi + English)') String language,
    @Default('published') String status, // draft, published, archived
    int? accessDays,
    double? progress, // 0.0 to 1.0 for enrolled courses
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
