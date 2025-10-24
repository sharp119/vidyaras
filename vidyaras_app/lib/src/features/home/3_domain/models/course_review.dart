import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_review.freezed.dart';
part 'course_review.g.dart';

/// Represents a user review for a course
@freezed
class CourseReview with _$CourseReview {
  const factory CourseReview({
    required String id,
    required String userName,
    String? userAvatar,
    required double rating,
    required String reviewText,
    required DateTime createdAt,
  }) = _CourseReview;

  factory CourseReview.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewFromJson(json);
}
