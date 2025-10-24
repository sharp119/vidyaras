import 'package:freezed_annotation/freezed_annotation.dart';

part 'batch_info.freezed.dart';
part 'batch_info.g.dart';

/// Represents batch information for live courses
@freezed
class BatchInfo with _$BatchInfo {
  const factory BatchInfo({
    required String id,
    required String name,
    required DateTime startDate,
    required String schedule, // "Mon, Wed, Fri"
    required String time, // "7:00 AM IST"
    required int capacity,
    required int enrolled,
  }) = _BatchInfo;

  factory BatchInfo.fromJson(Map<String, dynamic> json) =>
      _$BatchInfoFromJson(json);
}
