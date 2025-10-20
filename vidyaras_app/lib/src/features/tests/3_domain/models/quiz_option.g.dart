// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizOptionImpl _$$QuizOptionImplFromJson(Map<String, dynamic> json) =>
    _$QuizOptionImpl(
      id: (json['id'] as num).toInt(),
      data: ContentData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$QuizOptionImplToJson(_$QuizOptionImpl instance) =>
    <String, dynamic>{'id': instance.id, 'data': instance.data};
