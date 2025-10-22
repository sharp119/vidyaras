import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../../../shared/presentation/components/buttons/secondary_button.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../2_application/providers/test_providers.dart';

/// Screen showing all attempts for a specific quiz
class QuizAttemptHistoryScreen extends ConsumerStatefulWidget {
  const QuizAttemptHistoryScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  final String quizId;
  final String quizTitle;

  @override
  ConsumerState<QuizAttemptHistoryScreen> createState() =>
      _QuizAttemptHistoryScreenState();
}

class _QuizAttemptHistoryScreenState
    extends ConsumerState<QuizAttemptHistoryScreen> {
  List<Map<String, dynamic>>? _attemptHistory;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAttemptHistory();
  }

  Future<void> _loadAttemptHistory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Get current user
    final currentUser = await ref.read(currentUserProvider.future);
    if (currentUser == null) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'User not logged in';
        });
      }
      return;
    }

    final repository = ref.read(testRepositoryProvider);
    final result = await repository.getQuizAttemptHistory(
      widget.quizId,
      userId: currentUser.id,
    );

    result.fold(
      (failure) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = failure.message;
          });
        }
      },
      (history) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _attemptHistory = history;
          });
        }
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${DateFormat('EEEE, HH:mm').format(date)}';
    } else {
      return DateFormat('MMM dd, yyyy - HH:mm').format(date);
    }
  }

  Color _getScoreColor(int score) {
    if (score >= 80) {
      return AppColors.success;
    } else if (score >= 60) {
      return AppColors.accent;
    } else if (score >= 40) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate best score
    int? bestScore;
    if (_attemptHistory != null && _attemptHistory!.isNotEmpty) {
      bestScore = _attemptHistory!
          .map((a) => a['score'] as int)
          .reduce((a, b) => a > b ? a : b);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.quizTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (bestScore != null)
                    Text(
                      'Best Score: $bestScore%',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                ],
              ),
              titlePadding: const EdgeInsets.only(left: 56, bottom: 16, right: 16),
            ),
          ),

          // Content
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_errorMessage != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadAttemptHistory,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (_attemptHistory == null || _attemptHistory!.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text(
                  'No attempts found',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final attempt = _attemptHistory![index];
                    final attemptNumber = _attemptHistory!.length - index;
                    final score = attempt['score'] as int;
                    final completedAt = attempt['completedAt'] as DateTime;
                    final timeTaken = attempt['timeTakenMinutes'] as int;
                    final attemptId = attempt['attemptId'] as String;
                    final isBestScore = score == bestScore;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _AttemptHistoryCard(
                        attemptNumber: attemptNumber,
                        score: score,
                        completedAt: completedAt,
                        timeTaken: timeTaken,
                        isBestScore: isBestScore,
                        scoreColor: _getScoreColor(score),
                        onViewDetails: () async {
                          // Get current user
                          final currentUser = await ref.read(currentUserProvider.future);
                          if (currentUser == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('User not logged in')),
                              );
                            }
                            return;
                          }

                          // Navigate to quiz results for this specific attempt
                          final repository = ref.read(testRepositoryProvider);
                          final result = await repository.getQuizAttemptDetails(
                            widget.quizId,
                            userId: currentUser.id,
                            attemptId: attemptId,
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
                                  '/test/${widget.quizId}/results',
                                  extra: {
                                    ...attemptData,
                                    'attemptNumber': attemptNumber,
                                    'attemptDate': _formatDate(completedAt),
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                  childCount: _attemptHistory!.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Card component for displaying a single attempt in the history
class _AttemptHistoryCard extends StatelessWidget {
  const _AttemptHistoryCard({
    required this.attemptNumber,
    required this.score,
    required this.completedAt,
    required this.timeTaken,
    required this.isBestScore,
    required this.scoreColor,
    required this.onViewDetails,
  });

  final int attemptNumber;
  final int score;
  final DateTime completedAt;
  final int timeTaken;
  final bool isBestScore;
  final Color scoreColor;
  final VoidCallback onViewDetails;

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${DateFormat('EEEE, HH:mm').format(date)}';
    } else {
      return DateFormat('MMM dd, yyyy - HH:mm').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isBestScore
              ? scoreColor.withOpacity(0.3)
              : AppColors.textTertiary.withOpacity(0.1),
          width: isBestScore ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with attempt number and best score badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Attempt #$attemptNumber',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              if (isBestScore)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: scoreColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 16,
                        color: scoreColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Best',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: scoreColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Score
          Row(
            children: [
              Icon(
                Icons.grade,
                size: 20,
                color: scoreColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Score:',
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$score%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: scoreColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Time taken
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                'Time Taken: $timeTaken min${timeTaken != 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Completed date
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                _formatDate(completedAt),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // View Details button
          SecondaryButton(
            label: 'View Details',
            onPressed: onViewDetails,
            icon: Icons.visibility_outlined,
          ),
        ],
      ),
    );
  }
}
