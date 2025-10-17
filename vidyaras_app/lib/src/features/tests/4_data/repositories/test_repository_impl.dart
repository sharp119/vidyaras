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
  /// Master list of all tests in the system.
  static final List<Test> _allTests = [
    const Test(
      id: '1',
      title: 'Hindustani Music Theory - Level 1',
      titleHindi: 'हिन्दुस्तानी संगीत सिद्धांत - स्तर 1',
      category: 'Music',
      difficulty: 'beginner',
      questionCount: 5, // Updated to match questions
      durationMinutes: 10,
      bestScore: '85%',
      isCompleted: true,
    ),
    const Test(
      id: '2',
      title: 'Meditation Techniques Assessment',
      titleHindi: 'ध्यान तकनीक मूल्यांकन',
      category: 'Wellness',
      difficulty: 'beginner',
      questionCount: 5, // Updated to match questions
      durationMinutes: 10,
      bestScore: '92%',
      isCompleted: true,
    ),
    const Test(
      id: '3',
      title: 'Tabla Rhythm Patterns',
      titleHindi: 'तबला लय पैटर्न',
      category: 'Music',
      difficulty: 'intermediate',
      questionCount: 5,
      durationMinutes: 10,
      isCompleted: false,
    ),
    const Test(
      id: '4',
      title: 'Classical Raag Identification',
      titleHindi: 'शास्त्रीय राग पहचान',
      category: 'Music',
      difficulty: 'advanced',
      questionCount: 30,
      durationMinutes: 35,
      isCompleted: false,
    ),
    const Test(
      id: '5',
      title: 'Yoga Asanas & Benefits',
      titleHindi: 'योग आसन और लाभ',
      category: 'Wellness',
      difficulty: 'beginner',
      questionCount: 20,
      durationMinutes: 25,
      isCompleted: false,
    ),
  ];

  /// In-memory mock data for quiz questions, linked by testId.
  final Map<String, List<Question>> _mockQuizQuestions = {
    '1': const [
      // Questions for "Hindustani Music Theory - Level 1"
      Question(
        id: '1-1',
        questionText: 'What is a "Swar"?',
        options: ['Rhythm', 'Note', 'Melody', 'Instrument'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '1-2',
        questionText: 'How many "shuddha" (pure) swars are there in a saptak?',
        options: ['5', '7', '9', '12'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '1-3',
        questionText: 'Which swar is the base note "Sa"?',
        options: ['Shadja', 'Rishabh', 'Gandhar', 'Madhyam'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: '1-4',
        questionText: 'What is a "Thaat"?',
        options: [
          'A type of rhythm',
          'A parent scale',
          'A collection of ragas',
          'A performance style',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '1-5',
        questionText:
            'The raga "Bhairav" is typically sung at what time of day?',
        options: ['Morning', 'Afternoon', 'Evening', 'Night'],
        correctAnswerIndex: 0,
      ),
    ],
    '2': const [
      // Questions for "Meditation Techniques Assessment"
      Question(
        id: '2-1',
        questionText: 'What is the primary focus in mindfulness meditation?',
        options: [
          'Clearing the mind',
          'Breath and bodily sensations',
          'Visualizing success',
          'Repeating a mantra',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '2-2',
        questionText: 'Which of these is a common meditation posture?',
        options: [
          'Lying down flat',
          'Standing on one leg',
          'Cross-legged (Padmasana)',
          'Walking briskly',
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '2-3',
        questionText: 'The term "Vipassanā" means:',
        options: ['Concentration', 'Loving-kindness', 'Insight', 'Tranquility'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '2-4',
        questionText: 'What is a common benefit of regular meditation?',
        options: [
          'Increased stress',
          'Reduced focus',
          'Improved emotional regulation',
          'Faster heart rate',
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '2-5',
        questionText: 'A "mantra" in meditation is typically a:',
        options: [
          'Difficult question',
          'Repeated sound or word',
          'Physical posture',
          'Breathing exercise',
        ],
        correctAnswerIndex: 1,
      ),
    ],
    '3': const [
      // Questions for "Tabla Rhythm Patterns"
      Question(
        id: '3-1',
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
        id: '3-2',
        questionText: 'Which hand is used to play the Dayan?',
        options: ['Left hand', 'Right hand', 'Both hands', 'Either hand'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '3-3',
        questionText: 'What is the main component of the Tabla\'s surface?',
        options: ['Leather', 'Wood', 'Metal', 'Plastic'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: '3-4',
        questionText: 'What does "Teentaal" consist of?',
        options: ['12 beats', '16 beats', '14 beats', '10 beats'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '3-5',
        questionText:
            'Which taal (rhythm cycle) is most commonly used in Hindustani classical music?',
        options: ['Dadra', 'Rupak', 'Jhaptaal', 'Teentaal'],
        correctAnswerIndex: 3,
      ),
    ],
  };

  @override
  Future<Either<Failure, TestData>> getTestData() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final completedTests = _allTests
          .where((t) => t.isCompleted == true)
          .toList();
      final availableTests = _allTests
          .where((t) => t.isCompleted == false)
          .toList();
      final testData = TestData(
        stats: TestStats(
          totalTests: _allTests.length,
          completedTests: completedTests.length,
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
        availableTests: availableTests,
        completedTests: completedTests,
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
      return right('/test/$testId');
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> retakeTest(String testId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
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
        return left(
          ServerFailure(message: 'No questions found for test ID: $testId'),
        );
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
