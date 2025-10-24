import 'package:freezed_annotation/freezed_annotation.dart';

part 'pricing_option.freezed.dart';
part 'pricing_option.g.dart';

/// Represents pricing information for a course
@freezed
class PricingOption with _$PricingOption {
  const factory PricingOption({
    required int fullPrice,
    int? emiMonthlyPrice,
    int? emiTenure, // in months
    @Default(false) bool isFree,
  }) = _PricingOption;

  factory PricingOption.fromJson(Map<String, dynamic> json) =>
      _$PricingOptionFromJson(json);
}
