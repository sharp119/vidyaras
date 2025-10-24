import 'package:freezed_annotation/freezed_annotation.dart';
import 'course.dart';
import 'section_info.dart';
import 'batch_info.dart';
import 'pricing_option.dart';
import 'course_review.dart';

part 'course_detail.freezed.dart';
part 'course_detail.g.dart';

/// Represents detailed information about a course
/// Extends basic Course model with curriculum, pricing, reviews, etc.
@freezed
class CourseDetail with _$CourseDetail {
  const factory CourseDetail({
    required Course basicInfo,
    required String description,
    required List<String> whatYouLearn,
    required List<String> courseIncludes,
    required List<String> prerequisites,
    required List<SectionInfo> curriculum,
    required PricingOption pricing,
    required List<CourseReview> reviews,
    BatchInfo? liveBatch, // Only for live courses
    int? accessDays, // Only for recorded courses (e.g., 90 days)
    DateTime? accessExpiryDate, // For enrolled students
    String? language, // "Hindi", "English", "Bilingual"
    @Default(false) bool hasCertificate,
    @Default(false) bool hasQuizzes,
    @Default(false) bool hasMaterials,
  }) = _CourseDetail;

  factory CourseDetail.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailFromJson(json);
}
