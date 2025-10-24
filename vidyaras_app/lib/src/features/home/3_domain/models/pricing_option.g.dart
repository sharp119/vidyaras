// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PricingOptionImpl _$$PricingOptionImplFromJson(Map<String, dynamic> json) =>
    _$PricingOptionImpl(
      fullPrice: (json['fullPrice'] as num).toInt(),
      emiMonthlyPrice: (json['emiMonthlyPrice'] as num?)?.toInt(),
      emiTenure: (json['emiTenure'] as num?)?.toInt(),
      isFree: json['isFree'] as bool? ?? false,
    );

Map<String, dynamic> _$$PricingOptionImplToJson(_$PricingOptionImpl instance) =>
    <String, dynamic>{
      'fullPrice': instance.fullPrice,
      'emiMonthlyPrice': instance.emiMonthlyPrice,
      'emiTenure': instance.emiTenure,
      'isFree': instance.isFree,
    };
