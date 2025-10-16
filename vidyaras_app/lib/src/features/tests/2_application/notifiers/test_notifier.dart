import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/test_state.dart';
import '../providers/test_providers.dart';

part 'test_notifier.g.dart';

/// Notifier for managing test series state
@riverpod
class TestNotifier extends _$TestNotifier {
  @override
  TestState build() {
    // Auto-load data when the notifier is created
    loadTestData();
    return const TestState.initial();
  }

  /// Load test data from repository
  Future<void> loadTestData() async {
    state = const TestState.loading();

    final repository = ref.read(testRepositoryProvider);
    final result = await repository.getTestData();

    result.fold(
      (failure) => state = TestState.error(failure.message),
      (data) => state = TestState.loaded(data),
    );
  }

  /// Refresh test data
  Future<void> refreshTestData() async {
    await loadTestData();
  }

  /// Start a test
  Future<String?> startTest(String testId) async {
    final repository = ref.read(testRepositoryProvider);
    final result = await repository.startTest(testId);

    return result.fold(
      (failure) {
        // TODO: Show error to user
        return null;
      },
      (navigationUrl) => navigationUrl,
    );
  }

  /// Retake a completed test
  Future<String?> retakeTest(String testId) async {
    final repository = ref.read(testRepositoryProvider);
    final result = await repository.retakeTest(testId);

    return result.fold(
      (failure) {
        // TODO: Show error to user
        return null;
      },
      (navigationUrl) => navigationUrl,
    );
  }
}
