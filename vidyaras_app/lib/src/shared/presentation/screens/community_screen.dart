import 'package:flutter/material.dart';

/// Community screen placeholder
/// TODO: Implement full community screen with chat
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: const Text('Community')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: colorScheme.outline,
            ),
            const SizedBox(height: 24),
            Text('Community', style: theme.textTheme.displaySmall),
            const SizedBox(height: 8),
            Text('Coming soon', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
