import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../shared/presentation/theme/app_colors.dart';
import '../../2_application/providers/test_providers.dart';
import '../../3_domain/models/question.dart';
import '../widgets/answer_review_card.dart';

/// Screen for reviewing the answers of a completed quiz.
class AnswerReviewScreen extends ConsumerWidget {
  const AnswerReviewScreen({super.key, required this.testId, this.userAnswers});

  final String testId;
  final Map<int, int>? userAnswers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionsFuture = ref
        .watch(testRepositoryProvider)
        .getQuizQuestions(testId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Review Answers')),
      body: FutureBuilder<Either<dynamic, List<Question>>>(
        future: questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text('Could not load questions.'));
          }

          return snapshot.data!.fold(
            (failure) => Center(child: Text('Error: ${failure.message}')),
            (questions) {
              return ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return AnswerReviewCard(
                    question: question,
                    questionNumber: index + 1,
                    totalQuestions: questions.length,
                    userAnswerIndex: userAnswers?[index],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
