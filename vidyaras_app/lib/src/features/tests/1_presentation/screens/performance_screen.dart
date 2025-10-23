import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/notifiers/test_notifier.dart';
import '../../2_application/providers/test_providers.dart';
import '../../3_domain/models/test_data.dart';
import '../widgets/completed_test_card.dart';

/// Performance screen showing detailed analytics and completed tests
class PerformanceScreen extends ConsumerWidget {
  const PerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testState = ref.watch(testNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: testState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(child: Text(message)),
        loaded: (data) => _buildPerformanceContent(context, ref, data),
      ),
    );
  }

  Widget _buildPerformanceContent(
    BuildContext context,
    WidgetRef ref,
    TestData data,
  ) {
    return CustomScrollView(
      slivers: [
        // App Bar
        _buildAppBar(context),

        // Performance Stats Cards
        SliverToBoxAdapter(
          child: _buildPerformanceStats(data),
        ),

        // Performance Chart
        SliverToBoxAdapter(
          child: _buildPerformanceChart(data),
        ),

        // Subject-wise Performance
        if (data.completedTests.isNotEmpty)
          SliverToBoxAdapter(
            child: _buildSubjectPerformance(data),
          ),

        // Completed Tests Section Header
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${data.completedTests.length} tests',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Completed Tests List
        if (data.completedTests.isEmpty)
          const SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assessment_outlined,
                    size: 64,
                    color: AppColors.textTertiary,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No completed tests yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Start taking quizzes to see your performance',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final test = data.completedTests[index];
                  final score = int.tryParse(
                        test.bestScore?.replaceAll('%', '') ?? '0',
                      ) ??
                      0;
                  final quizResult = QuizResult(
                    id: test.id,
                    title: test.title,
                    category: test.category,
                    icon: '🏆',
                    score: score,
                    totalQuestions: test.questionCount,
                    correctAnswers:
                        ((score / 100) * test.questionCount).round(),
                    timeSpent: test.durationMinutes,
                    completedAt: DateTime.now(),
                    difficulty: test.difficulty,
                    passed: score >= 60,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
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
                        final notifier =
                            ref.read(testNotifierProvider.notifier);
                        final navigationUrl =
                            await notifier.retakeTest(test.id);
                        if (navigationUrl != null && context.mounted) {
                          context.push('/test/${test.id}', extra: test.title);
                        }
                      },
                    ),
                  );
                },
                childCount: data.completedTests.length,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 56, bottom: 16),
        title: const Text(
          'My Performance',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Container(
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
        ),
      ),
    );
  }

  Widget _buildPerformanceStats(TestData data) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              icon: Icons.quiz_outlined,
              label: 'Tests Taken',
              value: data.stats.completedTests.toString(),
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.trending_up,
              label: 'Avg Score',
              value: data.stats.averageScore,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.emoji_events_outlined,
              label: 'Best Score',
              value: _getBestScore(data),
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart(TestData data) {
    if (data.performanceOverview.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance Trend',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.border,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 25,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 &&
                            index < data.performanceOverview.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'T${index + 1}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: data.performanceOverview.reversed
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      final score = double.tryParse(
                            entry.value.score.replaceAll('%', ''),
                          ) ??
                          0;
                      return FlSpot(entry.key.toDouble(), score);
                    }).toList(),
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: AppColors.primary,
                          strokeWidth: 2,
                          strokeColor: AppColors.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectPerformance(TestData data) {
    // Group tests by category
    final categoryScores = <String, List<int>>{};
    for (final test in data.completedTests) {
      final score =
          int.tryParse(test.bestScore?.replaceAll('%', '') ?? '0') ?? 0;
      categoryScores.putIfAbsent(test.category, () => []).add(score);
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Subject Performance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...categoryScores.entries.map((entry) {
            final avgScore = entry.value.reduce((a, b) => a + b) /
                entry.value.length;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildSubjectProgressBar(
                entry.key,
                avgScore.round(),
                entry.value.length,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSubjectProgressBar(String subject, int score, int testCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                subject,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '$score% · $testCount test${testCount > 1 ? 's' : ''}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: score / 100,
            minHeight: 8,
            backgroundColor: AppColors.progressBackground,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getScoreColor(score),
            ),
          ),
        ),
      ],
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return AppColors.success;
    if (score >= 60) return AppColors.warning;
    return AppColors.error;
  }

  String _getBestScore(TestData data) {
    if (data.completedTests.isEmpty) return '0%';
    final scores = data.completedTests
        .map((test) =>
            int.tryParse(test.bestScore?.replaceAll('%', '') ?? '0') ?? 0)
        .toList();
    return '${scores.reduce((a, b) => a > b ? a : b)}%';
  }
}
