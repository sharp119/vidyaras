import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/models/chat_message.dart';
import '../../3_domain/models/chat_room.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatRoom>> getChatRooms({required String userId});
  Future<List<ChatMessage>> getMessages({
    required String roomId,
    int limit = 50,
    DateTime? before,
  });
  Future<void> sendMessage({
    required String roomId,
    required String userId,
    required String content,
    String type = 'text',
  });
  Stream<List<ChatMessage>> getMessagesStream({
    required String roomId,
    required String currentUserId,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SupabaseClient _supabase;

  ChatRemoteDataSourceImpl(this._supabase);

  @override
  Future<List<ChatRoom>> getChatRooms({required String userId}) async {
    try {
      // Fetch chat rooms. RLS policies will ensure we only get:
      // 1. Global chat
      // 2. Course chats for enrolled courses
      final response = await _supabase
          .from('chat_rooms')
          .select('''
        *,
        courses (
          thumbnail_url
        )
      ''')
          .order('created_at', ascending: false);

      final data = response as List<dynamic>;

      return data.map((json) {
        final courseData = json['courses'] as Map<String, dynamic>?;
        final courseImage = courseData?['thumbnail_url'] as String?;

        // For global chat, we might want a specific image or handle it in UI
        // The UI already handles null courseImage by showing an icon

        return ChatRoom(
          id: json['id'] as String,
          courseId: json['course_id'] ?? 'global',
          name: json['name'] as String,
          type: json['type'] as String,
          lastMessage: null, // TODO: Fetch last message if needed
          lastMessageAt: json['created_at'] != null
              ? DateTime.parse(json['created_at'] as String)
              : null,
          unreadCount: 0, // TODO: Implement unread count
          courseImage: courseImage,
        );
      }).toList();
    } catch (e) {
      print('❌ Error fetching chat rooms: $e');
      rethrow;
    }
  }

  @override
  Future<List<ChatMessage>> getMessages({
    required String roomId,
    int limit = 50,
    DateTime? before,
  }) async {
    try {
      var query = _supabase
          .from('chat_messages')
          .select('''
            *,
            users (
              name
            )
          ''')
          .eq('room_id', roomId);

      if (before != null) {
        query = query.lt('created_at', before.toIso8601String());
      }

      final response = await query
          .order('created_at', ascending: false)
          .limit(limit);
      final data = response as List<dynamic>;

      return data.map((json) => _mapToChatMessage(json)).toList();
    } catch (e) {
      print('❌ Error fetching messages: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendMessage({
    required String roomId,
    required String userId,
    required String content,
    String type = 'text',
  }) async {
    try {
      await _supabase.from('chat_messages').insert({
        'room_id': roomId,
        'user_id': userId,
        'content': content,
        'message_type': type,
      });
    } catch (e) {
      print('❌ Error sending message: $e');
      rethrow;
    }
  }

  @override
  Stream<List<ChatMessage>> getMessagesStream({
    required String roomId,
    required String currentUserId,
  }) {
    print('📡 Setting up realtime stream for room: $roomId');

    return _supabase
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomId)
        .order(
          'created_at',
          ascending: false,
        ) // Newest first for reverse ListView
        .map((maps) {
          print('📨 Stream received ${maps.length} messages');
          return maps.map((json) {
            return ChatMessage(
              id: json['id'] as String,
              roomId: json['room_id'] as String,
              userId: json['user_id'] as String,
              content: json['content'] as String,
              createdAt: DateTime.parse(json['created_at'] as String),
              userName: '...', // Placeholder
              isMe: json['user_id'] == currentUserId,
            );
          }).toList();
        });
  }

  ChatMessage _mapToChatMessage(Map<String, dynamic> json) {
    final userData = json['users'] as Map<String, dynamic>?;
    final userName = userData?['name'] as String? ?? 'Unknown';
    final currentUserId = _supabase.auth.currentUser?.id;

    return ChatMessage(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      userName: userName,
      isMe: json['user_id'] == currentUserId,
    );
  }
}
