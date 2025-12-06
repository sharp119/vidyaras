// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageImpl _$$ChatMessageImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageImpl(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      messageType: json['messageType'] as String? ?? 'text',
      createdAt: DateTime.parse(json['createdAt'] as String),
      userName: json['userName'] as String?,
      userAvatar: json['userAvatar'] as String?,
      isMe: json['isMe'] as bool? ?? false,
    );

Map<String, dynamic> _$$ChatMessageImplToJson(_$ChatMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'userId': instance.userId,
      'content': instance.content,
      'messageType': instance.messageType,
      'createdAt': instance.createdAt.toIso8601String(),
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'isMe': instance.isMe,
    };
