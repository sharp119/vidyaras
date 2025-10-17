import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/test_data.dart';
import '../../3_domain/models/test_stats.dart';
import '../../3_domain/models/test_performance.dart';
import '../../3_domain/models/test.dart';
import '../../3_domain/models/question.dart';
import '../../3_domain/repositories/test_repository.dart';

/// Mock implementation of TestRepository
/// TODO: Replace with actual API integration
class TestRepositoryImpl implements TestRepository {
  // In-memory mock data for quiz questions
  final Map<String, List<Question>> _mockQuizQuestions = {
    '3': const [
      Question(
        id: '1',
        questionText:
            'Which pair of instruments is most commonly used in Hindustani classical music?',
        options: [
          'Dayan and Bayan',
          'Tabla and Pakhawaj',
          'Mridangam and Ghatam',
          'Dhol and Dholak',
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        id: '2',
        questionText: 'Which hand is used to play the Dayan?',
        options: ['Left hand', 'Right hand', 'Both hands', 'Either hand'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '3',
        questionText: 'What is the main component of the Tabla\'s surface?',
        options: ['Leather', 'Wood', 'Metal', 'Plastic'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: '4',
        questionText: 'What does "Teentaal" consist of?',
        options: ['12 beats', '16 beats', '14 beats', '10 beats'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '5',
        questionText:
            'Which taal (rhythm cycle) is most commonly used in Hindustani classical music?',
        options: ['Dadra', 'Rupak', 'Jhaptaal', 'Teentaal'],
        correctAnswerIndex: 3,
      ),
    ],
    // Add more mock questions for other testIds if needed
  };

  @override
  Future<Either<Failure, TestData>> getTestData() async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data matching the quiz mockups
      final testData = TestData(
        stats: const TestStats(
          totalTests: 5,
          completedTests: 2,
          averageScore: '89%',
        ),
        performanceOverview: const [
          TestPerformance(
            testId: '1',
            testTitle: 'Hindustani Music Theory - Level 1',
            score: '85%',
          ),
          TestPerformance(
            testId: '2',
            testTitle: 'Meditation Techniques Assessment',
            score: '92%',
          ),
        ],
        availableTests: const [
          Test(
            id: '3',
            title: 'Tabla Rhythm Patterns',
            titleHindi: 'तबला लय पैटर्न',
            category: 'Music',
            difficulty: 'intermediate',
            questionCount: 20,
            durationMinutes: 25,
            isCompleted: false,
          ),
          Test(
            id: '4',
            title: 'Classical Raag Identification',
            titleHindi: 'शास्त्रीय राग पहचान',
            category: 'Music',
            difficulty: 'advanced',
            questionCount: 30,
            durationMinutes: 35,
            isCompleted: false,
          ),
          Test(
            id: '5',
            title: 'Yoga Asanas & Benefits',
            titleHindi: 'योग आसन और लाभ',
            category: 'Wellness',
            difficulty: 'beginner',
            questionCount: 20,
            durationMinutes: 25,
            isCompleted: false,
          ),
        ],
        completedTests: const [
          Test(
            id: '1',
            title: 'Hindustani Music Theory - Level 1',
            titleHindi: 'हिन्दुस्तानी संगीत सिद्धांत - स्तर 1',
            category: 'Music',
            difficulty: 'beginner',
            questionCount: 25,
            durationMinutes: 30,
            bestScore: '85%',
            isCompleted: true,
          ),
          Test(
            id: '2',
            title: 'Meditation Techniques Assessment',
            titleHindi: 'ध्यान तकनीक मूल्यांकन',
            category: 'Wellness',
            difficulty: 'beginner',
            questionCount: 20,
            durationMinutes: 25,
            bestScore: '92%',
            isCompleted: true,
          ),
        ],
      );

      return right(testData);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> startTest(String testId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Return the test session ID or navigation URL
      return right('/test/$testId');
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> retakeTest(String testId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Return the new test session ID or navigation URL
      return right('/test/$testId');
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuizQuestions(
    String testId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      final questions = _mockQuizQuestions[testId];
      if (questions != null) {
        return right(questions);
      } else {
        return left(ServerFailure(message: 'Quiz with id $testId not found'));
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
