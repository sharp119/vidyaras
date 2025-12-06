import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/models/chat_message.dart';
import '../../3_domain/models/chat_room.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatRoom>> getChatRooms({required String userId});
  Future<List<ChatMessage>> getMessages({
    required String roomId,
    int limit = 50,
    DateTime? before,
    String? currentUserId,
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
      // Fetch chat rooms where user is enrolled or global chat
      // Strategy: Get all rooms, then filter in Dart for enrolled courses

      // First, get user's enrolled course IDs
      final enrollmentsResponse = await _supabase
          .from('enrollments')
          .select('course_id')
          .eq('user_id', userId)
          .eq('status', 'active');

      final enrolledCourseIds = (enrollmentsResponse as List<dynamic>)
          .map((e) => e['course_id'] as String)
          .toSet();

      // Fetch all chat rooms
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

      // Filter to only include:
      // 1. Global chat (type = 'global')
      // 2. Course chats where user is enrolled
      return data
          .where((json) {
            final type = json['type'] as String;
            if (type == 'global') return true;

            final courseId = json['course_id'] as String?;
            return courseId != null && enrolledCourseIds.contains(courseId);
          })
          .map((json) {
            final courseData = json['courses'] as Map<String, dynamic>?;
            final courseImage = courseData?['thumbnail_url'] as String?;

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
          })
          .toList();
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
    String? currentUserId,
  }) async {
    try {
      var query = _supabase
          .from('chat_messages')
          .select('''
            *,
            profiles (
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

      return data.map((json) => _mapToChatMessage(json, currentUserId)).toList();
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
        .asyncMap((maps) async {
          print('📨 Stream received ${maps.length} messages');

          // Get unique user IDs from messages
          final userIds = maps.map((m) => m['user_id'] as String).toSet().toList();

          // Fetch user data for all users in this batch
          final usersData = await _supabase
              .from('profiles')
              .select('id, name')
              .inFilter('id', userIds);

          // Create a map of userId -> userName for quick lookup
          final userNameMap = <String, String>{};
          for (final user in usersData as List<dynamic>) {
            userNameMap[user['id'] as String] = user['name'] as String? ?? 'Unknown';
          }

          // Map messages with user names
          return maps.map((json) {
            final userId = json['user_id'] as String;
            return ChatMessage(
              id: json['id'] as String,
              roomId: json['room_id'] as String,
              userId: userId,
              content: json['content'] as String,
              createdAt: DateTime.parse(json['created_at'] as String),
              userName: userNameMap[userId] ?? 'Unknown',
              isMe: userId == currentUserId,
            );
          }).toList();
        });
  }

  ChatMessage _mapToChatMessage(Map<String, dynamic> json, [String? currentUserId]) {
    final userData = json['profiles'] as Map<String, dynamic>?;
    final userName = userData?['name'] as String? ?? 'Unknown';

    return ChatMessage(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      userName: userName,
      isMe: currentUserId != null && json['user_id'] == currentUserId,
    );
  }
}
