import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../3_domain/models/lecture_completion.dart';
import '../providers/my_learning_providers.dart';

part 'lecture_completion_service.g.dart';

/// Service for handling lecture completion actions
@riverpod
class LectureCompletionService extends _$LectureCompletionService {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  /// Mark a lecture as completed
  Future<LectureCompletion> markComplete({
    required String lectureId,
    int? watchedSeconds,
  }) async {
    state = const AsyncValue.loading();

    // Hardcoded user ID for now
    const userId = '49dd34c0-7f0d-4b6f-9b1f-d201e97640f5';

    final repository = ref.read(myLearningRepositoryProvider);
    final result = await repository.markLectureComplete(
      userId: userId,
      lectureId: lectureId,
      watchedSeconds: watchedSeconds,
    );

    return result.fold(
      (failure) {
        state = AsyncValue.error(
          Exception(failure.message),
          StackTrace.current,
        );
        throw Exception(failure.message);
      },
      (completion) {
        state = const AsyncValue.data(null);
        // Invalidate relevant providers to refresh data
        ref.invalidate(enrolledCoursesProvider);
        return completion;
      },
    );
  }

  /// Update last accessed time for a course
  Future<void> updateLastAccessed({
    required String courseId,
  }) async {
    const userId = '49dd34c0-7f0d-4b6f-9b1f-d201e97640f5';

    final repository = ref.read(myLearningRepositoryProvider);
    await repository.updateLastAccessed(
      userId: userId,
      courseId: courseId,
    );
  }
}
