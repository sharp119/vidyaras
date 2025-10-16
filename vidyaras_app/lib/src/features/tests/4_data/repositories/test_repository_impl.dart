import 'package:fpdart/fpdart.dart';
import '../../../../shared/domain/failures/failure.dart';
import '../../3_domain/models/test_data.dart';
import '../../3_domain/models/test_stats.dart';
import '../../3_domain/models/test_performance.dart';
import '../../3_domain/models/test.dart';
import '../../3_domain/repositories/test_repository.dart';

/// Mock implementation of TestRepository
/// TODO: Replace with actual API integration
class TestRepositoryImpl implements TestRepository {
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
      return right('/test/$testId/questions');
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> retakeTest(String testId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Return the new test session ID or navigation URL
      return right('/test/$testId/questions');
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
