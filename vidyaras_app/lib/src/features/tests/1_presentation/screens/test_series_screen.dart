import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/cards/stats_card.dart';
import '../../2_application/notifiers/test_notifier.dart';
import '../../2_application/providers/test_providers.dart';
import '../widgets/available_test_card.dart';
import '../widgets/completed_test_card.dart';
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

          // --- MODIFICATION 1: Updated TabBar ---
          // This now includes icons and refined styling
          final tabBar = TabBar(
            labelColor: AppColors.textPrimary,
            unselectedLabelColor: AppColors.textSecondary,

            // 1. This is the white, rounded indicator
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

            // 2. Hide the default underline/divider
            dividerColor: Colors.transparent,

            // 3. Updated Tab styles
            labelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.explore_outlined, size: 18),
                    SizedBox(width: 6),
                    Text('Explore'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.history, size: 18),
                    SizedBox(width: 6),
                    Text('History'),
                  ],
                ),
              ),
            ],
          );
          // --- END OF MODIFICATION 1 ---

          return DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(child: _buildHeader(data, offset)),
                SliverToBoxAdapter(child: SizedBox(height: 50 + offset)),
                SliverPersistentHeader(
                  pinned: true,
                  // The delegate is updated below
                  delegate: _TestSeriesTabBarDelegate(tabBar),
                ),
              ],
              body: TabBarView(
                children: [
                  _buildExploreTab(context, ref, data),
                  _buildHistoryTab(context, ref, data),
                ],
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
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Test Series',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Practice and track your progress',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
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
                  titleHindi: test.titleHindi,
                  category: test.category,
                  difficulty: test.difficulty,
                  questionCount: test.questionCount,
                  durationMinutes: test.durationMinutes,
                  onStartTest: () async {
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

  Widget _buildHistoryTab(BuildContext context, WidgetRef ref, TestData data) {
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
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: CompletedTestCard(
                  title: test.title,
                  category: test.category,
                  difficulty: test.difficulty,
                  bestScore: test.bestScore ?? '0%',
                  attemptCount: test.attemptCount,
                  onViewHistory: test.attemptCount > 1
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

// --- MODIFICATION 2: Updated Delegate ---
// This now centers the tab bar and gives it a max-width
class _TestSeriesTabBarDelegate extends SliverPersistentHeaderDelegate {
  _TestSeriesTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  // 1. Total height (44px pill + 8px top/bottom padding)
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
    // 2. This container is full-width and provides the background
    return Container(
      color: AppColors.background,
      // 3. Center the pill
      alignment: Alignment.center,
      // 4. Add vertical padding
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        // 5. This is the grey pill background
        height: 44,
        // 6. Set max-width like max-w-md (448px) and horizontal margin
        constraints: const BoxConstraints(maxWidth: 448),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6), // shadcn grey-100
          borderRadius: BorderRadius.circular(12.0),
        ),
        // 7. Inner padding for the TabBar
        child: Padding(padding: const EdgeInsets.all(4.0), child: tabBar),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _TestSeriesTabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}

// --- END OF MODIFICATION 2 ---
