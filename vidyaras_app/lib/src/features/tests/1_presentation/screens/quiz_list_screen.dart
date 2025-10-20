import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/quiz_providers.dart';
import '../../3_domain/models/quiz.dart';

/// Screen displaying all available quizzes from Supabase
class QuizListScreen extends ConsumerWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzesAsync = ref.watch(publishedQuizzesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Quizzes'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: quizzesAsync.when(
        data: (quizzes) {
          if (quizzes.isEmpty) {
            return const Center(
              child: Text('No quizzes available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              return _QuizCard(quiz: quiz);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading quizzes',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card widget for displaying a single quiz
class _QuizCard extends StatelessWidget {
  final Quiz quiz;

  const _QuizCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to quiz detail or start quiz
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => QuizDetailScreen(quizId: quiz.id),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and difficulty badge
              Row(
                children: [
                  Expanded(
                    child: Text(
                      quiz.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (quiz.difficultyLevel != null)
                    _DifficultyBadge(level: quiz.difficultyLevel!),
                ],
              ),
              const SizedBox(height: 8),

              // Description
              if (quiz.description != null && quiz.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    quiz.description!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),

              // Quiz details
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _QuizDetailItem(
                    icon: Icons.timer_outlined,
                    text: '${quiz.timeAllottedMinutes} mins',
                  ),
                  _QuizDetailItem(
                    icon: Icons.star_outline,
                    text: '${quiz.fullMarks} marks',
                  ),
                  if (!quiz.isPublic)
                    _QuizDetailItem(
                      icon: Icons.lock_outline,
                      text: 'Premium',
                      color: AppColors.accent,
                    ),
                  if (quiz.isPublic)
                    _QuizDetailItem(
                      icon: Icons.public,
                      text: 'Free',
                      color: Colors.green,
                    ),
                ],
              ),

              const SizedBox(height: 12),

              // Start button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizDetailScreen(quizId: quiz.id),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Start Quiz'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Difficulty badge widget
class _DifficultyBadge extends StatelessWidget {
  final String level;

  const _DifficultyBadge({required this.level});

  Color get _color {
    switch (level.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _color),
      ),
      child: Text(
        level.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: _color,
        ),
      ),
    );
  }
}

/// Quiz detail item widget
class _QuizDetailItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const _QuizDetailItem({
    required this.icon,
    required this.text,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final itemColor = color ?? Colors.grey[700];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: itemColor),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: itemColor,
          ),
        ),
      ],
    );
  }
}

/// Quiz detail screen (placeholder - you'll implement this)
class QuizDetailScreen extends ConsumerWidget {
  final String quizId;

  const QuizDetailScreen({super.key, required this.quizId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizAsync = ref.watch(quizByIdProvider(quizId));
    final questionsAsync = ref.watch(quizQuestionsProvider(quizId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: quizAsync.when(
        data: (quiz) => questionsAsync.when(
          data: (questions) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (quiz.description != null)
                  Text(
                    quiz.description!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                const SizedBox(height: 24),

                // Quiz info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(
                        label: 'Total Questions',
                        value: '${questions.length}',
                      ),
                      _InfoRow(
                        label: 'Total Marks',
                        value: '${quiz.fullMarks}',
                      ),
                      _InfoRow(
                        label: 'Time Limit',
                        value: '${quiz.timeAllottedMinutes} minutes',
                      ),
                      _InfoRow(
                        label: 'Difficulty',
                        value: quiz.difficultyLevel ?? 'Not specified',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Start quiz button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to quiz screen and start attempt
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Quiz will start here! Integrate with QuizAttemptNotifier'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Start Quiz',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading questions: $error'),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading quiz: $error'),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
