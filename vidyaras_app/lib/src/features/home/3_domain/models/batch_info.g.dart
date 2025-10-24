// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BatchInfoImpl _$$BatchInfoImplFromJson(Map<String, dynamic> json) =>
    _$BatchInfoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      schedule: json['schedule'] as String,
      time: json['time'] as String,
      capacity: (json['capacity'] as num).toInt(),
      enrolled: (json['enrolled'] as num).toInt(),
    );

Map<String, dynamic> _$$BatchInfoImplToJson(_$BatchInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate.toIso8601String(),
      'schedule': instance.schedule,
      'time': instance.time,
      'capacity': instance.capacity,
      'enrolled': instance.enrolled,
    };
