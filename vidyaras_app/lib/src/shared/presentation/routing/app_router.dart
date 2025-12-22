import 'package:go_router/go_router.dart';
import '../../../features/splash/splash_screen.dart';
import '../../../features/auth/1_presentation/screens/google_login_screen.dart';
import '../../../features/auth/1_presentation/screens/phone_binding_screen.dart';
import '../../../features/onboarding/1_presentation/screens/intro_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_interests_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_goals_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_experience_screen.dart';
import '../../../features/onboarding/1_presentation/screens/onboarding_language_screen.dart';

import '../../../features/home/1_presentation/screens/course_detail_screen.dart';
import '../../../features/tests/1_presentation/screens/quiz_screen.dart';
import '../../../features/tests/1_presentation/screens/quiz_results_screen.dart';
import '../../../features/tests/1_presentation/screens/answer_review_screen.dart';
import '../../../features/tests/1_presentation/screens/quiz_attempt_history_screen.dart';
import '../../../features/tests/1_presentation/screens/performance_screen.dart';
import '../../../features/tests/3_domain/models/quiz_result.dart';
import '../../../features/my_learning/1_presentation/screens/my_learning_hub_screen.dart';
import '../../../features/my_learning/1_presentation/screens/course_content_screen.dart';
import '../../../features/chat/1_presentation/screens/chat_room_screen.dart';
import '../../../features/chat/3_domain/models/chat_room.dart';
import '../../../features/courses/1_presentation/screens/all_courses_screen.dart';
import '../screens/main_shell.dart';
import '../screens/edit_profile_screen.dart';

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

    // Google OAuth Authentication Flow (NEW)
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const GoogleLoginScreen(),
    ),

    // Phone Binding Screen - Mandatory after Google sign-in (NEW)
    GoRoute(
      path: '/phone-binding',
      name: 'phone-binding',
      builder: (context, state) => const PhoneBindingScreen(),
    ),

    // Legacy Authentication Flow (DEPRECATED - kept for reference)
    // GoRoute(
    //   path: '/auth',
    //   name: 'auth',
    //   builder: (context, state) => const PhoneAuthScreen(),
    // ),
    // GoRoute(
    //   path: '/auth/verify-otp',
    //   name: 'verify-otp',
    //   builder: (context, state) {
    //     final data = state.extra as Map<String, String>;₹
    //     return OTPVerificationScreen(
    //       phoneNumber: data['phoneNumber']!,
    //       requestId: data['requestId']!,
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: '/auth/register',
    //   name: 'register',
    //   builder: (context, state) {
    //     final phoneNumber = state.extra as String;
    //     return RegistrationScreen(phoneNumber: phoneNumber);
    //   },
    // ),

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
            return QuizResultsScreen(testId: testId, attemptData: extra);
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
        return QuizAttemptHistoryScreen(quizId: testId, quizTitle: testTitle);
      },
    ),

    // Performance Screen
    GoRoute(
      path: '/performance',
      name: 'performance',
      builder: (context, state) => const PerformanceScreen(),
    ),

    // Course Detail Screen
    GoRoute(
      path: '/course/:courseId',
      name: 'course-detail',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        return CourseDetailScreen(courseId: courseId);
      },
    ),

    // All Courses Screen - Browse all available courses
    GoRoute(
      path: '/courses',
      name: 'all-courses',
      builder: (context, state) {
        final category = state.uri.queryParameters['category'];
        return AllCoursesScreen(initialCategory: category);
      },
    ),

    // My Learning Hub - Shows all enrolled courses
    GoRoute(
      path: '/my-learning',
      name: 'my-learning',
      builder: (context, state) => const MyLearningHubScreen(),
    ),

    // Course Content Screen - Shows lectures, live classes, materials
    GoRoute(
      path: '/my-learning/course/:courseId',
      name: 'enrolled-course-content',
      builder: (context, state) {
        final courseId = state.pathParameters['courseId']!;
        return CourseContentScreen(courseId: courseId);
      },
    ),

    // Chat Routes
    GoRoute(
      path: '/chat/:roomId',
      name: 'chat-room',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;
        final room = state.extra as ChatRoom?;
        return ChatRoomScreen(roomId: roomId, room: room);
      },
    ),

    // Profile Edit Screen
    GoRoute(
      path: '/profile/edit',
      name: 'edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),

    // TODO: Add additional routes as features are implemented
    // Example routes to be added:
    // - /course/:id/lesson/:lessonId - Course lesson screen
    // - /settings - Settings screen
  ],
);
