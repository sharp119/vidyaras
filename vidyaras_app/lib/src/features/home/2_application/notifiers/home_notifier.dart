import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../state/home_state.dart';
import '../providers/home_providers.dart';

part 'home_notifier.g.dart';

/// Home notifier
/// Manages home screen state and data fetching
@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  HomeState build() {
    // Automatically load data when notifier is created
    loadHomeData();
    return const HomeState.initial();
  }

  /// Load home data
  Future<void> loadHomeData() async {
    state = const HomeState.loading();

    final repository = ref.read(homeRepositoryProvider);
    final result = await repository.getHomeData();

    result.fold(
      (failure) => state = HomeState.error(failure.message),
      (data) => state = HomeState.loaded(data),
    );
  }

  /// Refresh home data
  Future<void> refreshHomeData() async {
    final repository = ref.read(homeRepositoryProvider);
    final result = await repository.refreshHomeData();

    result.fold(
      (failure) => state = HomeState.error(failure.message),
      (data) => state = HomeState.loaded(data),
    );
  }
}
