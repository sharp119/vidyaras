import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../models/quiz.dart';
import '../models/quiz_question.dart';
import '../models/quiz_attempt_record.dart';
import '../models/user_answer.dart';

/// Repository interface for quiz-related operations with Supabase
abstract class QuizRepository {
  /// Fetches all published quizzes (optionally filtered by course)
  Future<Either<Failure, List<Quiz>>> getPublishedQuizzes({String? courseId});

  /// Fetches a specific quiz by ID
  Future<Either<Failure, Quiz>> getQuizById(String quizId);

  /// Fetches all questions for a specific quiz
  Future<Either<Failure, List<QuizQuestion>>> getQuizQuestions(String quizId);

  /// Creates a new quiz attempt when user starts a quiz
  Future<Either<Failure, QuizAttemptRecord>> createQuizAttempt({
    required String quizId,
    required int totalMarks,
  });

  /// Submits an answer for a question
  Future<Either<Failure, UserAnswer>> submitAnswer({
    required String attemptId,
    required String questionId,
    required int selectedOptionId,
    required bool isCorrect,
    required int marksAwarded,
  });

  /// Completes a quiz attempt and calculates final score
  Future<Either<Failure, QuizAttemptRecord>> completeQuizAttempt({
    required String attemptId,
    required int score,
    required int timeTakenSeconds,
  });

  /// Fetches user's quiz attempts (history)
  Future<Either<Failure, List<QuizAttemptRecord>>> getUserQuizAttempts({
    String? quizId,
  });

  /// Fetches user's answers for a specific attempt (for review)
  Future<Either<Failure, List<UserAnswer>>> getUserAnswers(String attemptId);
}
