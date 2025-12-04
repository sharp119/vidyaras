import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../models/chat_message.dart';
import '../models/chat_room.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatRoom>>> getChatRooms({
    required String userId,
  });

  Future<Either<Failure, List<ChatMessage>>> getMessages({
    required String roomId,
    int limit = 50,
    DateTime? before,
  });

  Future<Either<Failure, void>> sendMessage({
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
