import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
import '../../../features/tests/1_presentation/screens/answer_review_screen.dart'; // Import the new screen
import '../screens/main_shell.dart';

/// Application routing configuration using GoRouter
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Intro/Onboarding Screen - Initial route
    GoRoute(
      path: '/',
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
        final phoneNumber = state.extra as String;
        return OTPVerificationScreen(phoneNumber: phoneNumber);
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

    // TODO: Add additional routes as features are implemented
    // Example routes to be added:
    // - /course/:id - Course detail screen
    // - /course/:id/lesson/:lessonId - Course lesson screen
    // - /settings - Settings screen
  ],
);
