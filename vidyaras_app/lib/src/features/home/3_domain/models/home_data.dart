import 'package:freezed_annotation/freezed_annotation.dart';
import 'course.dart';
import 'user_profile.dart';

part 'home_data.freezed.dart';
part 'home_data.g.dart';

/// Home screen data model
/// Aggregates all data needed for the home screen
@freezed
class HomeData with _$HomeData {
  const factory HomeData({
    required UserProfile userProfile,
    @Default([]) List<Course> myCourses,
    @Default([]) List<Course> recommendedCourses,
    @Default([]) List<Course> freeCourses,
  }) = _HomeData;

  factory HomeData.fromJson(Map<String, dynamic> json) =>
      _$HomeDataFromJson(json);
}
