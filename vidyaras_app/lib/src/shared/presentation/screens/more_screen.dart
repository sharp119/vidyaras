import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vidyaras_app/src/shared/presentation/screens/community_screen.dart';
import 'package:vidyaras_app/src/shared/presentation/theme/app_colors.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.surface,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          _SectionLabel('Community'),
          _MoreTile(
            icon: Icons.chat_bubble_outline,
            title: 'Student Community',
            subtitle: 'Discuss progress, ask questions, and connect',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CommunityScreen(),
              ),
            ),
          ),
          _MoreTile(
            icon: Icons.emoji_events_outlined,
            title: 'Leaderboard & Streaks',
            subtitle: 'See how you rank this week',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coming soon!')),
            ),
          ),
          const SizedBox(height: 12),
          _SectionLabel('Support'),
          _MoreTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'FAQs, guides, and onboarding tips',
            onTap: () => GoRouter.of(context).push('/intro'),
          ),
          _MoreTile(
            icon: Icons.support_agent_outlined,
            title: 'Contact Support',
            subtitle: 'Reach out for course or billing help',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email support@vidyaras.com')),
            ),
          ),
          const SizedBox(height: 12),
          _SectionLabel('Account'),
          _MoreTile(
            icon: Icons.person_outline,
            title: 'Profile & Preferences',
            subtitle: 'Update your name, interests, or language',
            onTap: () => context.goNamed('main', extra: 3),
          ),
          _MoreTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Notifications, downloads, and privacy',
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings coming soon')),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.primary.withOpacity(0.12),
        foregroundColor: AppColors.primary,
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
