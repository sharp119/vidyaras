import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/2_application/providers/auth_providers.dart';
import '../../3_domain/models/quiz.dart';
import '../../3_domain/models/quiz_question.dart';
import '../../3_domain/repositories/quiz_repository.dart';
import '../../4_data/repositories/quiz_repository_impl.dart';

part 'quiz_providers.g.dart';

/// Provider for Supabase client
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Provider for QuizRepository
@riverpod
QuizRepository quizRepository(QuizRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return QuizRepositoryImpl(supabase);
}

/// Provider to fetch all published quizzes for the current user
@riverpod
Future<List<Quiz>> publishedQuizzes(PublishedQuizzesRef ref) async {
  print('🔵 [PROVIDER] publishedQuizzesProvider called');

  final repository = ref.watch(quizRepositoryProvider);
  final currentUser = await ref.watch(currentUserProvider.future);

  print('   👤 Current User: ${currentUser?.id ?? "null"}');
  print('   📞 Current User Phone: ${currentUser?.phoneNumber ?? "null"}');

  if (currentUser == null) {
    print('   ❌ User not logged in, throwing exception');
    throw Exception('User not logged in');
  }

  print('   📞 Calling repository.getPublishedQuizzes...');
  final result = await repository.getPublishedQuizzes(userId: currentUser.id);

  return result.fold(
    (failure) {
      print('   ❌ Repository returned failure: ${failure.message}');
      throw Exception(failure.message);
    },
    (quizzes) {
      print('   ✅ Provider returning ${quizzes.length} quizzes');
      return quizzes;
    },
  );
}

/// Provider to fetch available quizzes (not attempted) for the current user
@riverpod
Future<List<Quiz>> availableQuizzes(AvailableQuizzesRef ref) async {
  print('🔵 [PROVIDER] availableQuizzesProvider called');

  final repository = ref.watch(quizRepositoryProvider);
  final currentUser = await ref.watch(currentUserProvider.future);

  print('   👤 Current User: ${currentUser?.id ?? "null"}');
  print('   📞 Current User Phone: ${currentUser?.phoneNumber ?? "null"}');

  if (currentUser == null) {
    print('   ❌ User not logged in, throwing exception');
    throw Exception('User not logged in');
  }

  print('   📞 Calling repository.getAvailableQuizzes...');
  final result = await repository.getAvailableQuizzes(userId: currentUser.id);

  return result.fold(
    (failure) {
      print('   ❌ Repository returned failure: ${failure.message}');
      throw Exception(failure.message);
    },
    (quizzes) {
      print('   ✅ Provider returning ${quizzes.length} available quizzes');
      return quizzes;
    },
  );
}

/// Provider to fetch completed quizzes (quiz history) for the current user
@riverpod
Future<List<Quiz>> completedQuizzes(CompletedQuizzesRef ref) async {
  print('🔵 [PROVIDER] completedQuizzesProvider called');

  final repository = ref.watch(quizRepositoryProvider);
  final currentUser = await ref.watch(currentUserProvider.future);

  print('   👤 Current User: ${currentUser?.id ?? "null"}');
  print('   📞 Current User Phone: ${currentUser?.phoneNumber ?? "null"}');

  if (currentUser == null) {
    print('   ❌ User not logged in, throwing exception');
    throw Exception('User not logged in');
  }

  print('   📞 Calling repository.getCompletedQuizzes...');
  final result = await repository.getCompletedQuizzes(userId: currentUser.id);

  return result.fold(
    (failure) {
      print('   ❌ Repository returned failure: ${failure.message}');
      throw Exception(failure.message);
    },
    (quizzes) {
      print('   ✅ Provider returning ${quizzes.length} completed quizzes');
      return quizzes;
    },
  );
}

/// Provider to fetch a specific quiz by ID
@riverpod
Future<Quiz> quizById(QuizByIdRef ref, String quizId) async {
  final repository = ref.watch(quizRepositoryProvider);
  final result = await repository.getQuizById(quizId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (quiz) => quiz,
  );
}

/// Provider to fetch questions for a specific quiz
@riverpod
Future<List<QuizQuestion>> quizQuestions(
  QuizQuestionsRef ref,
  String quizId,
) async {
  final repository = ref.watch(quizRepositoryProvider);
  final result = await repository.getQuizQuestions(quizId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (questions) => questions,
  );
}
