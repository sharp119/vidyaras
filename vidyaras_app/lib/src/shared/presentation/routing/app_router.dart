import 'package:go_router/go_router.dart';
import '../../../features/auth/1_presentation/screens/splash_screen.dart';
import '../../../features/onboarding/1_presentation/screens/intro_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_interests_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_goals_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_experience_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_language_screen.dart';
import '../../../features/auth/1_presentation/screens/phone_auth_screen.dart';
import '../../../features/auth/1_presentation/screens/otp_verification_screen.dart';
import '../../../features/auth/1_presentation/screens/registration_screen.dart';
import '../../../features/tests/1_presentation/screens/quiz_screen.dart';
import '../../../features/tests/1_presentation/screens/quiz_results_screen.dart';
import '../../../features/tests/1_presentation/screens/answer_review_screen.dart';
import '../../../features/tests/1_presentation/screens/quiz_attempt_history_screen.dart';
import '../../../features/tests/3_domain/models/quiz_result.dart';
import '../screens/main_shell.dart';

/// Application routing configuration using GoRouter
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash Screen - Entry point with auth check
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // Intro Screen - For unauthenticated users
    GoRoute(
      path: '/intro',
      name: 'intro',
      builder: (context, state) => const IntroScreen(),
    ),

    // Authentication Flow
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const PhoneAuthScreen(),
    ),
    GoRoute(
      path: '/auth/verify-otp',
      name: 'verify-otp',
      builder: (context, state) {
        final data = state.extra as Map<String, String>;
        return OTPVerificationScreen(
          phoneNumber: data['phoneNumber']!,
          requestId: data['requestId']!,
        );
      },
    ),
    GoRoute(
      path: '/auth/register',
      name: 'register',
      builder: (context, state) {
        final phoneNumber = state.extra as String;
        return RegistrationScreen(phoneNumber: phoneNumber);
      },
    ),

    // Onboarding Personalization Flow
    GoRoute(
      path: '/onboarding/interests',
      name: 'onboarding-interests',
      builder: (context, state) => const OnboardingInterestsScreen(),
    ),
    GoRoute(
      path: '/onboarding/goals',
      name: 'onboarding-goals',
      builder: (context, state) => const OnboardingGoalsScreen(),
    ),
    GoRoute(
      path: '/onboarding/experience',
      name: 'onboarding-experience',
      builder: (context, state) => const OnboardingExperienceScreen(),
    ),
    GoRoute(
      path: '/onboarding/language',
      name: 'onboarding-language',
      builder: (context, state) => const OnboardingLanguageScreen(),
    ),

    // Main App Shell (Home, Courses, Community, Tests, Profile)
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const MainShell(initialIndex: 0),
    ),
    GoRoute(
      path: '/main',
      name: 'main',
      builder: (context, state) {
        final index = state.extra as int? ?? 0;
        return MainShell(initialIndex: index);
      },
    ),

    // Test Routes
    GoRoute(
      path: '/test/:testId',
      name: 'test-questions',
      builder: (context, state) {
        final testId = state.pathParameters['testId']!;
        final testTitle = state.extra as String? ?? 'Quiz';
        return QuizScreen(testId: testId, testTitle: testTitle);
      },
    ),
    GoRoute(
      path: '/test/:testId/results',
      name: 'test-results',
      builder: (context, state) {
        final testId = state.pathParameters['testId']!;
        final extra = state.extra;

        // Handle both Map<String, dynamic> (from completed test view)
        // and individual result/userAnswers (from quiz completion)
        if (extra is Map<String, dynamic>) {
          // Check if this is attemptData from repository
          if (extra.containsKey('result') && extra['result'] is QuizResult) {
            return QuizResultsScreen(
              testId: testId,
              attemptData: extra,
            );
          } else {
            // Legacy format with separate result and userAnswers
            return QuizResultsScreen(
              testId: testId,
              result: extra['result'],
              userAnswers: extra['userAnswers'],
            );
          }
        }

        // No data provided
        return QuizResultsScreen(testId: testId);
      },
    ),
    GoRoute(
      path: '/test/:testId/review', // New route for answer review
      name: 'test-review',
      builder: (context, state) {
        final testId = state.pathParameters['testId']!;
        final userAnswers = state.extra as Map<int, int>?;
        return AnswerReviewScreen(testId: testId, userAnswers: userAnswers);
      },
    ),
    GoRoute(
      path: '/test/:testId/history', // Route for quiz attempt history
      name: 'test-history',
      builder: (context, state) {
        final testId = state.pathParameters['testId']!;
        final testTitle = state.extra as String? ?? 'Quiz';
        return QuizAttemptHistoryScreen(
          quizId: testId,
          quizTitle: testTitle,
        );
      },
    ),

    // TODO: Add additional routes as features are implemented
    // Example routes to be added:
    // - /course/:id - Course detail screen
    // - /course/:id/lesson/:lessonId - Course lesson screen
    // - /settings - Settings screen
  ],
);
