import 'package:freezed_annotation/freezed_annotation.dart';
import '../../3_domain/models/test_data.dart';

part 'test_state.freezed.dart';

/// State for the test series screen
@freezed
class TestState with _$TestState {
  const factory TestState.initial() = _Initial;
  const factory TestState.loading() = _Loading;
  const factory TestState.loaded(TestData data) = _Loaded;
  const factory TestState.error(String message) = _Error;
}
