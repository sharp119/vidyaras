import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/quiz.dart';
import '../../3_domain/models/quiz_question.dart';
import '../../3_domain/models/quiz_attempt_record.dart';
import '../../3_domain/models/user_answer.dart';
import '../../3_domain/models/content_data.dart';
import '../../3_domain/models/quiz_option.dart';
import '../../3_domain/repositories/quiz_repository.dart';

/// Implementation of QuizRepository using Supabase
class QuizRepositoryImpl implements QuizRepository {
  final SupabaseClient _supabase;

  QuizRepositoryImpl(this._supabase);

  @override
  Future<Either<Failure, List<Quiz>>> getPublishedQuizzes({
    required String userId,
    String? courseId,
  }) async {
    try {
      print('🔍 [QUIZ REPO] getPublishedQuizzes called');
      print('   📋 User ID: $userId');
      print('   📋 Course ID: ${courseId ?? "null (all courses)"}');

      // For now, show all published public quizzes
      // TODO: Add enrollment filtering when course enrollment is implemented
      final response = courseId != null
          ? await _supabase
              .from('quizzes')
              .select()
              .eq('is_published', true)
              .eq('course_id', courseId)
              .order('created_at', ascending: false)
          : await _supabase
              .from('quizzes')
              .select()
              .eq('is_published', true)
              .eq('is_public', true) // Only public quizzes for now
              .order('created_at', ascending: false);

      print('   📦 Raw DB Response: ${response.toString()}');
      print('   📊 Response type: ${response.runtimeType}');
      print('   📊 Response length: ${(response as List).length}');

      final quizzes = (response as List)
          .map((json) => Quiz.fromJson(json as Map<String, dynamic>))
          .toList();

      print('   ✅ Fetched ${quizzes.length} published quizzes');
      for (var i = 0; i < quizzes.length; i++) {
        print('      [$i] Quiz: ${quizzes[i].title} (ID: ${quizzes[i].id})');
      }

      return right(quizzes);
    } catch (e, stackTrace) {
      print('   ❌ Error fetching published quizzes: $e');
      print('   🔴 Stack trace: $stackTrace');
      return left(const NetworkFailure(message: 'Failed to fetch quizzes'));
    }
  }

  @override
  Future<Either<Failure, List<Quiz>>> getAvailableQuizzes({
    required String userId,
    String? courseId,
  }) async {
    try {
      print('🔍 [QUIZ REPO] getAvailableQuizzes called');
      print('   📋 User ID: $userId');
      print('   📋 Course ID: ${courseId ?? "null (all courses)"}');

      // Get all published public quizzes
      final quizzesResponse = await _supabase
          .from('quizzes')
          .select()
          .eq('is_published', true)
          .eq('is_public', true)
          .order('created_at', ascending: false);

      print('   📦 All Quizzes Response: ${(quizzesResponse as List).length} quizzes');

      // Get all quiz IDs that user has completed
      final attemptsResponse = await _supabase
          .from('quiz_attempts')
          .select('quiz_id')
          .eq('user_id', userId)
          .eq('is_completed', true);

      print('   📦 Completed Attempts Response: ${(attemptsResponse as List).length} attempts');

      final completedQuizIds = (attemptsResponse as List)
          .map((attempt) => attempt['quiz_id'] as String)
          .toSet();

      print('   🎯 Completed Quiz IDs: ${completedQuizIds.toList()}');

      // Filter out quizzes that user has already completed
      final availableQuizzes = (quizzesResponse as List)
          .map((json) => Quiz.fromJson(json as Map<String, dynamic>))
          .where((quiz) => !completedQuizIds.contains(quiz.id))
          .toList();

      print('   ✅ Available Quizzes (not attempted): ${availableQuizzes.length}');
      for (var i = 0; i < availableQuizzes.length; i++) {
        print('      [$i] Quiz: ${availableQuizzes[i].title} (ID: ${availableQuizzes[i].id})');
      }

      return right(availableQuizzes);
    } catch (e, stackTrace) {
      print('   ❌ Error fetching available quizzes: $e');
      print('   🔴 Stack trace: $stackTrace');
      return left(
        NetworkFailure(message: 'Failed to fetch available quizzes: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<Quiz>>> getCompletedQuizzes({
    required String userId,
    String? courseId,
  }) async {
    try {
      print('🔍 [QUIZ REPO] getCompletedQuizzes called');
      print('   📋 User ID: $userId');
      print('   📋 Course ID: ${courseId ?? "null (all courses)"}');

      // Get all quiz IDs that user has completed
      final attemptsResponse = await _supabase
          .from('quiz_attempts')
          .select('quiz_id')
          .eq('user_id', userId)
          .eq('is_completed', true);

      print('   📦 Completed Attempts Response: ${(attemptsResponse as List).length} attempts');

      final completedQuizIds = (attemptsResponse as List)
          .map((attempt) => attempt['quiz_id'] as String)
          .toSet();

      print('   🎯 Completed Quiz IDs: ${completedQuizIds.toList()}');

      if (completedQuizIds.isEmpty) {
        print('   ℹ️ User has not completed any quizzes yet');
        return right([]);
      }

      // Fetch quiz details for completed quizzes
      final quizzesResponse = await _supabase
          .from('quizzes')
          .select()
          .inFilter('id', completedQuizIds.toList())
          .order('created_at', ascending: false);

      print('   📦 Quizzes Response: ${(quizzesResponse as List).length} quizzes');

      final completedQuizzes = (quizzesResponse as List)
          .map((json) => Quiz.fromJson(json as Map<String, dynamic>))
          .toList();

      print('   ✅ Completed Quizzes: ${completedQuizzes.length}');
      for (var i = 0; i < completedQuizzes.length; i++) {
        print('      [$i] Quiz: ${completedQuizzes[i].title} (ID: ${completedQuizzes[i].id})');
      }

      return right(completedQuizzes);
    } catch (e, stackTrace) {
      print('   ❌ Error fetching completed quizzes: $e');
      print('   🔴 Stack trace: $stackTrace');
      return left(
        NetworkFailure(message: 'Failed to fetch completed quizzes: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Quiz>> getQuizById(String quizId) async {
    try {
      final response = await _supabase
          .from('quizzes')
          .select()
          .eq('id', quizId)
          .single();

      final quiz = Quiz.fromJson(response);
      return right(quiz);
    } catch (e) {
      return left(const NetworkFailure(message: 'Failed to fetch quiz'));
    }
  }

  @override
  Future<Either<Failure, List<QuizQuestion>>> getQuizQuestions(
    String quizId,
  ) async {
    try {
      final response = await _supabase
          .from('questions')
          .select()
          .eq('quiz_id', quizId)
          .order('question_number', ascending: true);

      final questions = (response as List).map((json) {
        final data = json as Map<String, dynamic>;

        // Parse question_data JSONB
        final questionData = ContentData.fromJson(
          data['question_data'] as Map<String, dynamic>,
        );

        // Parse options JSONB array
        final optionsJson = data['options'] as List;
        final options = optionsJson
            .map((opt) => QuizOption.fromJson(opt as Map<String, dynamic>))
            .toList();

        // Parse explanation if present
        ContentData? explanation;
        if (data['explanation'] != null) {
          explanation = ContentData.fromJson(
            data['explanation'] as Map<String, dynamic>,
          );
        }

        return QuizQuestion(
          id: data['id'] as String,
          quizId: data['quiz_id'] as String,
          questionNumber: data['question_number'] as int,
          questionData: questionData,
          options: options,
          correctOptionId: data['correct_option_id'] as int,
          explanation: explanation,
          marks: data['marks'] as int? ?? 1,
          createdAt: data['created_at'] != null
              ? DateTime.parse(data['created_at'] as String)
              : null,
          updatedAt: data['updated_at'] != null
              ? DateTime.parse(data['updated_at'] as String)
              : null,
        );
      }).toList();

      return right(questions);
    } catch (e) {
      return left(
        const NetworkFailure(message: 'Failed to fetch quiz questions'),
      );
    }
  }

  @override
  Future<Either<Failure, QuizAttemptRecord>> createQuizAttempt({
    required String userId,
    required String quizId,
    required int totalMarks,
  }) async {
    try {
      print('📝 Creating quiz attempt for user: $userId, quiz: $quizId');

      final response = await _supabase.from('quiz_attempts').insert({
        'user_id': userId,
        'quiz_id': quizId,
        'total_marks': totalMarks,
        'score': 0,
        'is_completed': false,
      }).select().single();

      final attempt = QuizAttemptRecord.fromJson(response);
      print('✅ Quiz attempt created successfully: ${attempt.id}');
      return right(attempt);
    } catch (e) {
      print('❌ Failed to create quiz attempt: $e');
      return left(
        NetworkFailure(message: 'Failed to create quiz attempt: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, UserAnswer>> submitAnswer({
    required String attemptId,
    required String questionId,
    required int selectedOptionId,
    required bool isCorrect,
    required int marksAwarded,
  }) async {
    try {
      final response = await _supabase.from('user_answers').insert({
        'attempt_id': attemptId,
        'question_id': questionId,
        'selected_option_id': selectedOptionId,
        'is_correct': isCorrect,
        'marks_awarded': marksAwarded,
      }).select().single();

      final answer = UserAnswer.fromJson(response);
      return right(answer);
    } catch (e) {
      return left(
        const NetworkFailure(message: 'Failed to submit answer'),
      );
    }
  }

  @override
  Future<Either<Failure, QuizAttemptRecord>> completeQuizAttempt({
    required String attemptId,
    required int score,
    required int timeTakenSeconds,
  }) async {
    try {
      final response = await _supabase.from('quiz_attempts').update({
        'score': score,
        'time_taken_seconds': timeTakenSeconds,
        'completed_at': DateTime.now().toIso8601String(),
        'is_completed': true,
      }).eq('id', attemptId).select().single();

      final attempt = QuizAttemptRecord.fromJson(response);
      return right(attempt);
    } catch (e) {
      return left(
        const NetworkFailure(message: 'Failed to complete quiz attempt'),
      );
    }
  }

  @override
  Future<Either<Failure, List<QuizAttemptRecord>>> getUserQuizAttempts({
    required String userId,
    String? quizId,
  }) async {
    try {
      print('🔍 [QUIZ REPO] getUserQuizAttempts called');
      print('   📋 User ID: $userId');
      print('   📋 Quiz ID: ${quizId ?? "null (all quizzes)"}');

      final response = quizId != null
          ? await _supabase
              .from('quiz_attempts')
              .select()
              .eq('user_id', userId)
              .eq('quiz_id', quizId)
              .order('created_at', ascending: false)
          : await _supabase
              .from('quiz_attempts')
              .select()
              .eq('user_id', userId)
              .order('created_at', ascending: false);

      print('   📦 Attempts Response: ${(response as List).length} attempts');

      final attempts = (response as List)
          .map((json) => QuizAttemptRecord.fromJson(json as Map<String, dynamic>))
          .toList();

      print('   ✅ Quiz Attempts for user: ${attempts.length}');
      for (var i = 0; i < attempts.length; i++) {
        print('      [$i] Quiz ID: ${attempts[i].quizId}, Score: ${attempts[i].score}, Completed: ${attempts[i].isCompleted}');
      }

      return right(attempts);
    } catch (e, stackTrace) {
      print('   ❌ Failed to fetch quiz attempts: $e');
      print('   🔴 Stack trace: $stackTrace');
      return left(
        NetworkFailure(message: 'Failed to fetch quiz attempts: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, List<UserAnswer>>> getUserAnswers(
    String attemptId,
  ) async {
    try {
      final response = await _supabase
          .from('user_answers')
          .select()
          .eq('attempt_id', attemptId)
          .order('answered_at', ascending: true);

      final answers = (response as List)
          .map((json) => UserAnswer.fromJson(json as Map<String, dynamic>))
          .toList();

      return right(answers);
    } catch (e) {
      return left(
        const NetworkFailure(message: 'Failed to fetch user answers'),
      );
    }
  }
}
