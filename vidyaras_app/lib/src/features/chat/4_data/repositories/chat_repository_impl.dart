import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/chat_message.dart';
import '../../3_domain/models/chat_room.dart';
import '../../3_domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _remoteDataSource;

  ChatRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<ChatRoom>>> getChatRooms({
    required String userId,
  }) async {
    try {
      final rooms = await _remoteDataSource.getChatRooms(userId: userId);
      return right(rooms);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessages({
    required String roomId,
    int limit = 50,
    DateTime? before,
  }) async {
    try {
      final messages = await _remoteDataSource.getMessages(
        roomId: roomId,
        limit: limit,
        before: before,
      );
      return right(messages);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String roomId,
    required String userId,
    required String content,
    String type = 'text',
  }) async {
    try {
      print(
        'Sending message: roomId=$roomId, userId=$userId, content=$content',
      );

      await _remoteDataSource.sendMessage(
        roomId: roomId,
        userId: userId,
        content: content,
        type: type,
      );
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<List<ChatMessage>> getMessagesStream({
    required String roomId,
    required String currentUserId,
  }) {
    return _remoteDataSource.getMessagesStream(
      roomId: roomId,
      currentUserId: currentUserId,
    );
  }
}
