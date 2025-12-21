import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../3_domain/repositories/courses_repository.dart';
import 'courses_state.dart';
import '../../4_data/providers/data_providers.dart';

// Controller Provider
final coursesControllerProvider =
    StateNotifierProvider.autoDispose<CoursesController, CoursesState>((ref) {
      final repository = ref.watch(coursesRepositoryProvider);
      return CoursesController(repository);
    });

class CoursesController extends StateNotifier<CoursesState> {
  final CoursesRepository _repository;

  CoursesController(this._repository) : super(const CoursesState()) {
    loadCourses();
  }

  Future<void> loadCourses() async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await _repository.getCourses();

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, failure: failure);
      },
      (courses) {
        // Update courses and set loading to false
        state = state.copyWith(
          isLoading: false,
          courses: courses,
          filteredCourses: courses,
        );

        // Reapply filters if any are active
        if (state.selectedCategory != 'All' || state.searchQuery.isNotEmpty) {
          _applyFilters();
        }
      },
    );
  }

  void searchCourses(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.courses;

    // Apply Category Filter
    if (state.selectedCategory != 'All') {
      filtered = filtered.where((course) {
        return course.categories?.contains(state.selectedCategory) ?? false;
      }).toList();
    }

    // Apply Search Filter
    if (state.searchQuery.isNotEmpty) {
      final query = state.searchQuery.toLowerCase();
      filtered = filtered.where((course) {
        final title = course.title.toLowerCase();
        final instructor = course.instructor.toLowerCase();
        return title.contains(query) || instructor.contains(query);
      }).toList();
    }

    state = state.copyWith(filteredCourses: filtered);
  }
}
