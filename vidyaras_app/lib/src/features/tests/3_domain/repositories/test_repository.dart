import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../models/test_data.dart';
import '../models/question.dart';

/// Repository interface for test-related operations
abstract class TestRepository {
  /// Fetches all test data including stats, performance, available and completed tests
  Future<Either<Failure, TestData>> getTestData();

  /// Starts a test and returns navigation data
  Future<Either<Failure, String>> startTest(String testId);

  /// Retakes a completed test
  Future<Either<Failure, String>> retakeTest(String testId);

  /// Fetches the questions for a specific quiz
  Future<Either<Failure, List<Question>>> getQuizQuestions(String testId);

  /// Fetches the latest quiz attempt with user answers for a completed test
  /// Returns a map with 'result' and 'userAnswers' (question index -> selected option index)
  Future<Either<Failure, Map<String, dynamic>>> getQuizAttemptDetails(String quizId);
}
