import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/cards/stats_card.dart';
import '../../../../shared/presentation/components/navigation/unified_header.dart';
import '../../2_application/notifiers/test_notifier.dart';
import '../widgets/available_test_card.dart';
import '../widgets/completed_test_card.dart'; // Make sure this is imported
import '../widgets/locked_tab_placeholder.dart';
import '../../3_domain/models/test_data.dart';

/// Test Series screen showing tests, stats, and performance
class TestSeriesScreen extends ConsumerWidget {
  const TestSeriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(testNotifierProvider);

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
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
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
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textSecondary,
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
                SliverToBoxAdapter(child: _buildHeader(data, offset)),
                SliverToBoxAdapter(child: SizedBox(height: 50 + offset)),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TestSeriesTabBarDelegate(tabBar),
                ),
              ],
              body: Builder(
                builder: (tabContext) {
                  return TabBarView(
                    children: [
                      _buildExploreTab(context, ref, data),
                      _buildHistoryTab(
                        tabContext,
                        ref,
                        data,
                      ), // Pass tabContext
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

  Widget _buildHeader(TestData data, double offset) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        UnifiedHeader(
          title: 'Practice and track your progress',
          actionIcon: Icons.assessment_outlined,
          actionRoute: '/performance',
        ),
        Positioned(
          left: 20,
          right: 20,
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
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Tests',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${data.availableTests.length} new',
                      style: const TextStyle(
                        fontSize: 13,
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
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: AvailableTestCard(
                  title: test.title,
                  description:
                      test.titleHindi, // Maps to description in the card
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.sentiment_satisfied_alt,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No available tests yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // --- MODIFIED METHOD ---
  Widget _buildHistoryTab(BuildContext context, WidgetRef ref, TestData data) {
    // TODO: Replace this with actual enrollment check when enrollment system is implemented
    // For now, all users are considered NOT enrolled
    const bool hasEnrollment = false;

    // If user is not enrolled, show locked placeholder
    if (!hasEnrollment) {
      return LockedTabPlaceholder(
        availableTests: data.availableTests,
        onExplorePressed: () {
          // Navigate to Courses screen (MainShell index 1)
          context.go('/main', extra: 1);
        },
      );
    }

    // Below code will execute when enrollment system is implemented
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
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text(
                'Completed Tests',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          if (hasCompletedTests)
            ...data.completedTests.map((test) {
              // 1. Create the QuizResult object from your existing 'test' data
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
                icon: '🏆', // Placeholder icon
                timeSpent:
                    test.durationMinutes, // Using allotted time as placeholder
                completedAt: DateTime.now(), // Placeholder date
                passed: score >= 60, // Assuming 60% is a pass
              );

              // 2. Invoke the new card with the 'result' object and callbacks
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.history,
                      size: 48,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No completed tests yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _TestSeriesTabBarDelegate extends SliverPersistentHeaderDelegate {
  _TestSeriesTabBarDelegate(this.tabBar);

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
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6), // shadcn grey-100
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(padding: const EdgeInsets.all(4.0), child: tabBar),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TestSeriesTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
