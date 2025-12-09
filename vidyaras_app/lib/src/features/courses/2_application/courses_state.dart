import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vidyaras_app/src/shared/domain/failures/failure.dart';
import 'package:vidyaras_app/src/features/home/3_domain/models/course.dart';

part 'courses_state.freezed.dart';

@freezed
class CoursesState with _$CoursesState {
  const factory CoursesState({
    @Default([]) List<Course> courses,
    @Default([]) List<Course> filteredCourses,
    @Default(true) bool isLoading,
    @Default('') String searchQuery,
    @Default('All') String selectedCategory,
    Failure? failure,
  }) = _CoursesState;

  const CoursesState._();

  bool get hasError => failure != null;
}
