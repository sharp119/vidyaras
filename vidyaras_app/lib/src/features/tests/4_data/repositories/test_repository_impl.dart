import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/test_data.dart';
import '../../3_domain/models/test_stats.dart';
import '../../3_domain/models/test_performance.dart';
import '../../3_domain/models/test.dart';
import '../../3_domain/models/question.dart';
import '../../3_domain/models/quiz_result.dart';
import '../../3_domain/repositories/test_repository.dart';

/// Real implementation of TestRepository using Supabase
class TestRepositoryImpl implements TestRepository {
  final SupabaseClient _supabase;

  TestRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, TestData>> getTestData() async {
    try {
      // Get user ID - use default guest user if not authenticated
      final userId = _supabase.auth.currentUser?.id ??
                     '060b2882-a066-42b5-bdd8-1c3a609a407f'; // Default guest user

      // Fetch all published quizzes
      final quizzesResponse = await _supabase
          .from('quizzes')
          .select()
          .eq('is_published', true)
          .order('created_at', ascending: false);

      final quizzes = quizzesResponse as List;

      // Fetch user's quiz attempts for stats
      final attemptsResponse = await _supabase
          .from('quiz_attempts')
          .select()
          .eq('user_id', userId)
          .eq('is_completed', true)
          .order('completed_at', ascending: false);

      final attempts = attemptsResponse as List;

      // Calculate stats
      final totalTests = quizzes.length;

      // Count unique completed tests (not total attempts)
      final uniqueCompletedQuizIds =
          attempts.map((a) => a['quiz_id'] as String).toSet();
      final completedTests = uniqueCompletedQuizIds.length;

      final double avgScore = attempts.isEmpty
          ? 0.0
          : attempts.fold<double>(
                  0.0, (sum, attempt) => sum + (attempt['percentage'] ?? 0.0)) /
              attempts.length;

      // Get attempted quiz IDs (unique quizzes that have been attempted at least once)
      final attemptedQuizIds =
          attempts.map((a) => a['quiz_id'] as String).toSet();

      // Separate available and completed tests
      final List<Test> availableTests = [];
      final List<Test> completedTestsList = [];
      final Set<String> addedCompletedTests = {}; // Track unique completed tests

      for (var quiz in quizzes) {
        final quizId = quiz['id'] as String;
        final isCompleted = attemptedQuizIds.contains(quizId);

        // Count questions for this quiz
        final questionCountResponse = await _supabase
            .from('questions')
            .select()
            .eq('quiz_id', quizId);

        final questionCount = (questionCountResponse as List).length;

        if (isCompleted) {
          // Only add each completed quiz once (even if attempted multiple times)
          if (!addedCompletedTests.contains(quizId)) {
            // Get best score for completed quizzes
            final quizAttempts = attempts
                .where((a) => a['quiz_id'] == quizId)
                .toList();

            final maxPercentage = quizAttempts.fold<double>(
                0.0,
                (max, a) {
                  final percentage = (a['percentage'] as double?) ?? 0.0;
                  return percentage > max ? percentage : max;
                });
            final bestScore = '${maxPercentage.toStringAsFixed(0)}%';

            final test = Test(
              id: quizId,
              title: quiz['title'] as String,
              titleHindi: quiz['description'] as String? ?? '',
              category: quiz['difficulty_level'] as String? ?? 'General',
              difficulty: quiz['difficulty_level'] as String? ?? 'beginner',
              questionCount: questionCount,
              durationMinutes: quiz['time_allotted_minutes'] as int? ?? 30,
              bestScore: bestScore,
              isCompleted: true,
            );

            completedTestsList.add(test);
            addedCompletedTests.add(quizId);
          }
        } else {
          // Available test (never attempted)
          final test = Test(
            id: quizId,
            title: quiz['title'] as String,
            titleHindi: quiz['description'] as String? ?? '',
            category: quiz['difficulty_level'] as String? ?? 'General',
            difficulty: quiz['difficulty_level'] as String? ?? 'beginner',
            questionCount: questionCount,
            durationMinutes: quiz['time_allotted_minutes'] as int? ?? 30,
            bestScore: null,
            isCompleted: false,
          );

          availableTests.add(test);
        }
      }

      // Get performance overview (last 5 completed tests)
      final List<TestPerformance> performanceOverview = [];
      final recentAttempts = attempts.take(5);
      for (var attempt in recentAttempts) {
        final quizId = attempt['quiz_id'] as String;
        final quiz = quizzes.firstWhere(
          (q) => q['id'] == quizId,
          orElse: () => {'title': 'Unknown Quiz'},
        );
        performanceOverview.add(
          TestPerformance(
            testId: quizId,
            testTitle: quiz['title'] as String? ?? 'Unknown',
            score: '${(attempt['percentage'] ?? 0.0).toStringAsFixed(0)}%',
          ),
        );
      }

      final testData = TestData(
        stats: TestStats(
          totalTests: totalTests,
          completedTests: completedTests,
          averageScore: '${avgScore.toStringAsFixed(0)}%',
        ),
        performanceOverview: performanceOverview,
        availableTests: availableTests,
        completedTests: completedTestsList,
      );

      return right(testData);
    } catch (e) {
      return left(NetworkFailure(message: 'Failed to load test data: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> startTest(String testId) async {
    try {
      return right('/test/$testId');
    } catch (e) {
      return left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> retakeTest(String testId) async {
    try {
      return right('/test/$testId');
    } catch (e) {
      return left(NetworkFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuizQuestions(String testId) async {
    try {
      // Fetch questions from Supabase
      final questionsResponse = await _supabase
          .from('questions')
          .select()
          .eq('quiz_id', testId)
          .order('question_number', ascending: true);

      final questionsData = questionsResponse as List;

      final questions = questionsData.map((q) {
        final questionData = q['question_data'] as Map<String, dynamic>;
        final options = (q['options'] as List)
            .map((opt) {
              final optData = opt['data'] as Map<String, dynamic>;
              return optData['content'] as String;
            })
            .toList();

        return Question(
          id: q['id'] as String,
          questionText: questionData['content'] as String,
          options: options,
          correctAnswerIndex: q['correct_option_id'] as int,
        );
      }).toList();

      return right(questions);
    } catch (e) {
      return left(NetworkFailure(message: 'Failed to load questions: $e'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getQuizAttemptDetails(String quizId) async {
    try {
      // Get user ID
      final userId = _supabase.auth.currentUser?.id ??
                     '060b2882-a066-42b5-bdd8-1c3a609a407f';

      // Fetch the latest completed attempt for this quiz
      final attemptResponse = await _supabase
          .from('quiz_attempts')
          .select()
          .eq('quiz_id', quizId)
          .eq('user_id', userId)
          .eq('is_completed', true)
          .order('completed_at', ascending: false)
          .limit(1);

      final attempts = attemptResponse as List;
      if (attempts.isEmpty) {
        return left(NetworkFailure(message: 'No completed attempts found'));
      }

      final attempt = attempts.first;
      final attemptId = attempt['id'] as String;

      // Fetch quiz details for title
      final quizResponse = await _supabase
          .from('quizzes')
          .select()
          .eq('id', quizId)
          .single();

      // Fetch questions to build question ID to index mapping
      final questionsResponse = await _supabase
          .from('questions')
          .select()
          .eq('quiz_id', quizId)
          .order('question_number', ascending: true);

      final questions = questionsResponse as List;

      // Create mapping from question ID to question index (0-based)
      final Map<String, int> questionIdToIndex = {};
      for (int i = 0; i < questions.length; i++) {
        questionIdToIndex[questions[i]['id'] as String] = i;
      }

      // Fetch user answers for this attempt
      final answersResponse = await _supabase
          .from('user_answers')
          .select()
          .eq('attempt_id', attemptId)
          .order('id', ascending: true);

      final answers = answersResponse as List;

      // Build userAnswers map: question index -> selected option index
      final Map<int, int> userAnswers = {};
      for (var answer in answers) {
        final questionId = answer['question_id'] as String;
        final selectedOptionId = answer['selected_option_id'] as int;

        // Map question ID to index
        if (questionIdToIndex.containsKey(questionId)) {
          final questionIndex = questionIdToIndex[questionId]!;
          userAnswers[questionIndex] = selectedOptionId;
        }
      }

      // Get time taken from the time_taken_seconds field (more accurate than timestamp diff)
      final timeTakenSeconds = attempt['time_taken_seconds'] as int? ?? 0;
      final timeTakenMinutes = (timeTakenSeconds / 60).ceil(); // Round up to nearest minute

      // Calculate correct answers
      int correctAnswers = 0;
      for (var answer in answers) {
        if (answer['is_correct'] == true) {
          correctAnswers++;
        }
      }

      // Create QuizResult
      final completedAt = DateTime.parse(attempt['completed_at'] as String);
      final result = QuizResult(
        testId: quizId,
        testTitle: quizResponse['title'] as String,
        totalQuestions: questions.length,
        correctAnswers: correctAnswers,
        score: (attempt['percentage'] as double).round(),
        completedAt: completedAt,
        timeTakenMinutes: timeTakenMinutes,
      );

      return right({
        'result': result,
        'userAnswers': userAnswers,
      });
    } catch (e) {
      return left(NetworkFailure(message: 'Failed to load attempt details: $e'));
    }
  }

}
