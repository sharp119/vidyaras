import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/cards/stats_card.dart';
import '../../2_application/notifiers/test_notifier.dart';
import '../../2_application/providers/test_providers.dart';
import '../widgets/performance_overview.dart';
import '../widgets/available_test_card.dart';
import '../widgets/completed_test_card.dart';

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

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(testNotifierProvider.notifier).refreshTestData(),
            child: CustomScrollView(
              slivers: [
                // Header with Stats Card overlay
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Blue gradient header
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.8),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
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
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
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
                      // Stats Card positioned to overlap header bottom
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
                  ),
                ),

                // Spacing to account for the overlapping stats card
                SliverToBoxAdapter(child: SizedBox(height: 50 + offset)),

                // Recent Activity (Performance Overview)
                if (data.performanceOverview.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: PerformanceOverview(
                        performances: data.performanceOverview,
                        onTapPerformance: (performance) async {
                          // Navigate to results for this specific attempt
                          final repository = ref.read(testRepositoryProvider);
                          final result = await repository.getQuizAttemptDetails(
                            performance.testId,
                            attemptId: performance.attemptId,
                          );

                          result.fold(
                            (failure) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(failure.message)),
                                );
                              }
                            },
                            (attemptData) {
                              if (context.mounted) {
                                context.push(
                                  '/test/${performance.testId}/results',
                                  extra: attemptData,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],

                // Available Tests Section
                if (data.availableTests.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
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
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final test = data.availableTests[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AvailableTestCard(
                            title: test.title,
                            titleHindi: test.titleHindi,
                            category: test.category,
                            difficulty: test.difficulty,
                            questionCount: test.questionCount,
                            durationMinutes: test.durationMinutes,
                            onStartTest: () async {
                              final navigationUrl = await ref
                                  .read(testNotifierProvider.notifier)
                                  .startTest(test.id);
                              if (navigationUrl != null && context.mounted) {
                                context.push(
                                  '/test/${test.id}',
                                  extra: test.title,
                                );
                              }
                            },
                          ),
                        );
                      }, childCount: data.availableTests.length),
                    ),
                  ),
                ],

                // Completed Tests Section
                if (data.completedTests.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                      child: const Text(
                        'Completed Tests',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final test = data.completedTests[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CompletedTestCard(
                            title: test.title,
                            category: test.category,
                            difficulty: test.difficulty,
                            bestScore: test.bestScore ?? '0%',
                            attemptCount: test.attemptCount,
                            onViewHistory: test.attemptCount > 1
                                ? () {
                                    // Navigate to attempt history screen
                                    context.push(
                                      '/test/${test.id}/history',
                                      extra: test.title,
                                    );
                                  }
                                : null,
                            onRetake: () async {
                              final navigationUrl = await ref
                                  .read(testNotifierProvider.notifier)
                                  .retakeTest(test.id);
                              if (navigationUrl != null && context.mounted) {
                                context.push(
                                  '/test/${test.id}',
                                  extra: test.title,
                                );
                              }
                            },
                          ),
                        );
                      }, childCount: data.completedTests.length),
                    ),
                  ),
                ],

                // Bottom spacing for nav bar
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          );
        },
      ),
    );
  }
}
