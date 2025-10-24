// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pricing_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PricingOption _$PricingOptionFromJson(Map<String, dynamic> json) {
  return _PricingOption.fromJson(json);
}

/// @nodoc
mixin _$PricingOption {
  int get fullPrice => throw _privateConstructorUsedError;
  int? get emiMonthlyPrice => throw _privateConstructorUsedError;
  int? get emiTenure => throw _privateConstructorUsedError; // in months
  bool get isFree => throw _privateConstructorUsedError;

  /// Serializes this PricingOption to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PricingOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PricingOptionCopyWith<PricingOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PricingOptionCopyWith<$Res> {
  factory $PricingOptionCopyWith(
    PricingOption value,
    $Res Function(PricingOption) then,
  ) = _$PricingOptionCopyWithImpl<$Res, PricingOption>;
  @useResult
  $Res call({int fullPrice, int? emiMonthlyPrice, int? emiTenure, bool isFree});
}

/// @nodoc
class _$PricingOptionCopyWithImpl<$Res, $Val extends PricingOption>
    implements $PricingOptionCopyWith<$Res> {
  _$PricingOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PricingOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullPrice = null,
    Object? emiMonthlyPrice = freezed,
    Object? emiTenure = freezed,
    Object? isFree = null,
  }) {
    return _then(
      _value.copyWith(
            fullPrice: null == fullPrice
                ? _value.fullPrice
                : fullPrice // ignore: cast_nullable_to_non_nullable
                      as int,
            emiMonthlyPrice: freezed == emiMonthlyPrice
                ? _value.emiMonthlyPrice
                : emiMonthlyPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            emiTenure: freezed == emiTenure
                ? _value.emiTenure
                : emiTenure // ignore: cast_nullable_to_non_nullable
                      as int?,
            isFree: null == isFree
                ? _value.isFree
                : isFree // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PricingOptionImplCopyWith<$Res>
    implements $PricingOptionCopyWith<$Res> {
  factory _$$PricingOptionImplCopyWith(
    _$PricingOptionImpl value,
    $Res Function(_$PricingOptionImpl) then,
  ) = __$$PricingOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fullPrice, int? emiMonthlyPrice, int? emiTenure, bool isFree});
}

/// @nodoc
class __$$PricingOptionImplCopyWithImpl<$Res>
    extends _$PricingOptionCopyWithImpl<$Res, _$PricingOptionImpl>
    implements _$$PricingOptionImplCopyWith<$Res> {
  __$$PricingOptionImplCopyWithImpl(
    _$PricingOptionImpl _value,
    $Res Function(_$PricingOptionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PricingOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullPrice = null,
    Object? emiMonthlyPrice = freezed,
    Object? emiTenure = freezed,
    Object? isFree = null,
  }) {
    return _then(
      _$PricingOptionImpl(
        fullPrice: null == fullPrice
            ? _value.fullPrice
            : fullPrice // ignore: cast_nullable_to_non_nullable
                  as int,
        emiMonthlyPrice: freezed == emiMonthlyPrice
            ? _value.emiMonthlyPrice
            : emiMonthlyPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        emiTenure: freezed == emiTenure
            ? _value.emiTenure
            : emiTenure // ignore: cast_nullable_to_non_nullable
                  as int?,
        isFree: null == isFree
            ? _value.isFree
            : isFree // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PricingOptionImpl implements _PricingOption {
  const _$PricingOptionImpl({
    required this.fullPrice,
    this.emiMonthlyPrice,
    this.emiTenure,
    this.isFree = false,
  });

  factory _$PricingOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PricingOptionImplFromJson(json);

  @override
  final int fullPrice;
  @override
  final int? emiMonthlyPrice;
  @override
  final int? emiTenure;
  // in months
  @override
  @JsonKey()
  final bool isFree;

  @override
  String toString() {
    return 'PricingOption(fullPrice: $fullPrice, emiMonthlyPrice: $emiMonthlyPrice, emiTenure: $emiTenure, isFree: $isFree)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PricingOptionImpl &&
            (identical(other.fullPrice, fullPrice) ||
                other.fullPrice == fullPrice) &&
            (identical(other.emiMonthlyPrice, emiMonthlyPrice) ||
                other.emiMonthlyPrice == emiMonthlyPrice) &&
            (identical(other.emiTenure, emiTenure) ||
                other.emiTenure == emiTenure) &&
            (identical(other.isFree, isFree) || other.isFree == isFree));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fullPrice, emiMonthlyPrice, emiTenure, isFree);

  /// Create a copy of PricingOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PricingOptionImplCopyWith<_$PricingOptionImpl> get copyWith =>
      __$$PricingOptionImplCopyWithImpl<_$PricingOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PricingOptionImplToJson(this);
  }
}

abstract class _PricingOption implements PricingOption {
  const factory _PricingOption({
    required final int fullPrice,
    final int? emiMonthlyPrice,
    final int? emiTenure,
    final bool isFree,
  }) = _$PricingOptionImpl;

  factory _PricingOption.fromJson(Map<String, dynamic> json) =
      _$PricingOptionImpl.fromJson;

  @override
  int get fullPrice;
  @override
  int? get emiMonthlyPrice;
  @override
  int? get emiTenure; // in months
  @override
  bool get isFree;

  /// Create a copy of PricingOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PricingOptionImplCopyWith<_$PricingOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
