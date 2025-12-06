import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String roomId,
    required String userId,
    required String content,
    @Default('text') String messageType,
    required DateTime createdAt,
    String? userName, // For UI display
    String? userAvatar, // For UI display
    @Default(false) bool isMe, // Helper for UI
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
