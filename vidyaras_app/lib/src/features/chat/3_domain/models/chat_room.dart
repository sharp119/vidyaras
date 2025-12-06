import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.freezed.dart';
part 'chat_room.g.dart';

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String courseId,
    required String name,
    @Default('course') String type, // 'global' or 'course'
    String? lastMessage,
    DateTime? lastMessageAt,
    @Default(0) int unreadCount,
    String? courseImage, // For UI
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
