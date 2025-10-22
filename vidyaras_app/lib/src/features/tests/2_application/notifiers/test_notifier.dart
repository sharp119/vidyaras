import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
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
    print('🔵 [TEST NOTIFIER] loadTestData called');
    state = const TestState.loading();

    // Get current user
    final currentUser = await ref.read(currentUserProvider.future);
    print('   👤 Current User: ${currentUser?.id ?? "null"}');
    print('   📞 Current User Phone: ${currentUser?.phoneNumber ?? "null"}');

    if (currentUser == null) {
      print('   ❌ No user logged in');
      state = const TestState.error('User not logged in');
      return;
    }

    final repository = ref.read(testRepositoryProvider);
    print('   📞 Calling repository.getTestData with userId: ${currentUser.id}');
    final result = await repository.getTestData(userId: currentUser.id);

    result.fold(
      (failure) {
        print('   ❌ Repository returned failure: ${failure.message}');
        state = TestState.error(failure.message);
      },
      (data) {
        print('   ✅ Test data loaded successfully');
        state = TestState.loaded(data);
      },
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
