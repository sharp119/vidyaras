import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../components/cards/stats_card.dart';
import '../widgets/adaptive_header.dart';
import '../../../features/tests/2_application/notifiers/test_notifier.dart';
import '../../../features/tests/1_presentation/widgets/available_test_card.dart';
import '../../../features/tests/1_presentation/widgets/completed_test_card.dart';
import '../../../features/tests/1_presentation/widgets/locked_tab_placeholder.dart';
import '../../../features/tests/3_domain/models/test_data.dart';

/// Tests screen showing tests, stats, and performance
/// Design System: Theme-based typography, proper spacing
class TestsScreen extends ConsumerWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(testNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: testState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: () =>
                    ref.read(testNotifierProvider.notifier).loadTestData(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        loaded: (data) {
          final screenHeight = MediaQuery.of(context).size.height;
          final offset = screenHeight * 0.13;

          final tabBar = TabBar(
            labelColor: theme.colorScheme.onSurface,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.explore_outlined, size: 18),
                    SizedBox(width: 6),
                    Text('Explore'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book_outlined, size: 18),
                    SizedBox(width: 6),
                    Text('My Tests'),
                  ],
                ),
              ),
            ],
          );

          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(child: _buildHeader(context, data, offset)),
                SliverToBoxAdapter(child: SizedBox(height: 50 + offset)),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TestsTabBarDelegate(tabBar),
                ),
              ],
              body: Builder(
                builder: (tabContext) {
                  return TabBarView(
                    children: [
                      _buildExploreTab(context, ref, data),
                      _buildHistoryTab(tabContext, ref, data),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TestData data, double offset) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AdaptiveHeader(
          title: const Text(
            'Practice and track\nyour progress',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.2,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push('/performance');
              },
              icon: const Icon(
                Icons.assessment_outlined,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6366F1), // Indigo
              Color(0xFF8B5CF6), // Purple
            ],
          ),
        ),
        Positioned(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: -25 - offset,
          child: StatsCard(
            stats: [
              StatCardItem(
                icon: Icons.description_outlined,
                value: data.stats.totalTests,
                label: 'Total Tests',
                iconColor: AppColors.primary,
              ),
              StatCardItem(
                icon: Icons.check_circle_outline,
                value: data.stats.completedTests,
                label: 'Completed',
                iconColor: AppColors.success,
              ),
              StatCardItem(
                icon: Icons.emoji_events_outlined,
                value: data.stats.averageScore,
                label: 'Avg Score',
                iconColor: AppColors.accent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExploreTab(BuildContext context, WidgetRef ref, TestData data) {
    final theme = Theme.of(context);
    final notifier = ref.read(testNotifierProvider.notifier);
    final hasTests = data.availableTests.isNotEmpty;

    return RefreshIndicator(
      onRefresh: notifier.refreshTestData,
      child: ListView(
        primary: false,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (hasTests)
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.mdLg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Tests',
                    style: theme.textTheme.headlineMedium,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.mdSm,
                      vertical: AppSpacing.xs + 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.card),
                    ),
                    child: Text(
                      '${data.availableTests.length} new',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (hasTests)
            ...data.availableTests.map((test) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: AvailableTestCard(
                  title: test.title,
                  description: test.titleHindi,
                  category: test.category,
                  difficulty: test.difficulty,
                  questionCount: test.questionCount,
                  durationMinutes: test.durationMinutes,
                  onTap: () async {
                    final navigationUrl = await notifier.startTest(test.id);
                    if (navigationUrl != null && context.mounted) {
                      context.push('/test/${test.id}', extra: test.title);
                    }
                  },
                ),
              );
            }),
          if (!hasTests)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.mdSm),
                    Text(
                      'No available tests yet',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildHistoryTab(BuildContext context, WidgetRef ref, TestData data) {
    final theme = Theme.of(context);
    const bool hasEnrollment = false;

    if (!hasEnrollment) {
      return LockedTabPlaceholder(
        availableTests: data.availableTests,
        onExplorePressed: () {
          context.go('/main', extra: 1);
        },
      );
    }

    final notifier = ref.read(testNotifierProvider.notifier);
    final hasCompletedTests = data.completedTests.isNotEmpty;

    return RefreshIndicator(
      onRefresh: notifier.refreshTestData,
      child: ListView(
        primary: false,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          if (hasCompletedTests)
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.mdLg,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Text(
                'Completed Tests',
                style: theme.textTheme.headlineMedium,
              ),
            ),
          if (hasCompletedTests)
            ...data.completedTests.map((test) {
              final int score =
                  int.tryParse(test.bestScore?.replaceAll('%', '') ?? '0') ?? 0;
              final quizResult = QuizResult(
                id: test.id,
                title: test.title,
                category: test.category,
                difficulty: test.difficulty,
                score: score,
                totalQuestions: test.questionCount,
                correctAnswers: ((score / 100) * test.questionCount).round(),
                icon: '🏆',
                timeSpent: test.durationMinutes,
                completedAt: DateTime.now(),
                passed: score >= 60,
              );

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.md,
                ),
                child: CompletedTestCard(
                  result: quizResult,
                  onViewDetails: test.attemptCount > 1
                      ? () {
                          context.push(
                            '/test/${test.id}/history',
                            extra: test.title,
                          );
                        }
                      : null,
                  onRetake: () async {
                    final navigationUrl = await notifier.retakeTest(test.id);
                    if (navigationUrl != null && context.mounted) {
                      context.push('/test/${test.id}', extra: test.title);
                    }
                  },
                ),
              );
            }),
          if (!hasCompletedTests)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: AppSpacing.mdSm),
                    Text(
                      'No completed tests yet',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _TestsTabBarDelegate extends SliverPersistentHeaderDelegate {
  _TestsTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => 60.0;

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 44,
        constraints: const BoxConstraints(maxWidth: 448),
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: tabBar,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TestsTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
