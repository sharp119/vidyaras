import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../main.dart'; // For supabase client
import '../../3_domain/models/chat_message.dart';
import '../../3_domain/models/chat_room.dart';
import '../../3_domain/repositories/chat_repository.dart';
import '../../4_data/datasources/chat_remote_datasource.dart';
import '../../4_data/repositories/chat_repository_impl.dart';
import '../../../auth/2_application/providers/auth_providers.dart';

part 'chat_providers.g.dart';

@riverpod
ChatRemoteDataSource chatRemoteDataSource(ChatRemoteDataSourceRef ref) {
  return ChatRemoteDataSourceImpl(supabase);
}

@riverpod
ChatRepository chatRepository(ChatRepositoryRef ref) {
  final dataSource = ref.watch(chatRemoteDataSourceProvider);
  return ChatRepositoryImpl(dataSource);
}

@riverpod
Future<List<ChatRoom>> chatRooms(ChatRoomsRef ref) async {
  final repository = ref.watch(chatRepositoryProvider);
  final user = ref.watch(currentUserProvider).value;

  if (user == null) return [];

  final result = await repository.getChatRooms(userId: user.id);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (rooms) => rooms,
  );
}

@riverpod
Stream<List<ChatMessage>> chatMessages(
  ChatMessagesRef ref, {
  required String roomId,
}) {
  final repository = ref.watch(chatRepositoryProvider);
  final user = ref.watch(currentUserProvider).value;

  if (user == null) {
    return const Stream.empty();
  }

  return repository.getMessagesStream(roomId: roomId, currentUserId: user.id);
}

@riverpod
class ChatController extends _$ChatController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> sendMessage({
    required String roomId,
    required String content,
  }) async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(chatRepositoryProvider);
      final result = await repository.sendMessage(
        roomId: roomId,
        userId: user.id,
        content: content,
      );

      return result.fold(
        (failure) => throw Exception(failure.message),
        (_) => null,
      );
    });
  }
}
