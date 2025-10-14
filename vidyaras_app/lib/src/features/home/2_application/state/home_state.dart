import 'package:freezed_annotation/freezed_annotation.dart';
import '../../3_domain/models/home_data.dart';

part 'home_state.freezed.dart';

/// Home screen state
@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded(HomeData data) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
