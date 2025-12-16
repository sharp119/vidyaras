import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_gradients.dart';
import '../../2_application/providers/chat_providers.dart';
import '../../3_domain/models/chat_room.dart';

/// Chat List Screen - Shows Global Chat + course chat rooms
class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatRoomsAsync = ref.watch(chatRoomsProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: chatRoomsAsync.when(
        data: (rooms) {
          final globalRoom = rooms.firstWhere(
            (r) => r.type == 'global',
            orElse: () => ChatRoom(
              id: 'global',
              courseId: 'global',
              name: 'VidyaRas Community',
              type: 'global',
              courseImage: null,
            ),
          );

          final courseRooms = rooms.where((r) => r.type == 'course').toList();

          return CustomScrollView(
            slivers: [
              // Colored Header
              SliverToBoxAdapter(
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(gradient: AppGradients.orange),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Community',
                          style: theme.textTheme.displayMedium?.copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Connect and learn together',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Global Chat Tile (now matches list style)
                    _GlobalChatTile(room: globalRoom),

                    // Course Groups Header
                    if (courseRooms.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Text(
                            'Course Groups',
                            style: theme.textTheme.headlineSmall,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${courseRooms.length}',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Course Chat List
                      ...courseRooms.map(
                        (room) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _ChatRoomTile(room: room),
                        ),
                      ),
                    ] else ...[
                      const SizedBox(height: 32),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Enroll in courses to join their groups',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          );
        },
        loading: () => Scaffold(
          backgroundColor: colorScheme.surface,
          body: const Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => Scaffold(
          backgroundColor: colorScheme.surface,
          body: Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

class _GlobalChatTile extends StatelessWidget {
  const _GlobalChatTile({required this.room});

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        context.push('/chat/${room.id}', extra: room);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: AppGradients.orangeFeature,
              ),
              child: Icon(Icons.public, color: colorScheme.onPrimary, size: 26),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Chat with all VidyaRas learners',
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: colorScheme.outline,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatRoomTile extends StatelessWidget {
  const _ChatRoomTile({required this.room});

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        context.push('/chat/${room.id}', extra: room);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: AppGradients.primary,
                image: room.courseImage != null
                    ? DecorationImage(
                        image: NetworkImage(room.courseImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: room.courseImage == null
                  ? Icon(
                      Icons.groups_rounded,
                      color: colorScheme.onPrimary,
                      size: 26,
                    )
                  : null,
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    room.lastMessage ?? 'No messages yet',
                    style: theme.textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Badge or Arrow
            if (room.unreadCount > 0)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    room.unreadCount.toString(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.outline,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
