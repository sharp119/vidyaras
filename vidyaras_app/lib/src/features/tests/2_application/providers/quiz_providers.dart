import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

/// Provider to fetch all published quizzes
@riverpod
Future<List<Quiz>> publishedQuizzes(PublishedQuizzesRef ref) async {
  final repository = ref.watch(quizRepositoryProvider);
  final result = await repository.getPublishedQuizzes();

  return result.fold(
    (failure) => throw Exception(failure.message),
    (quizzes) => quizzes,
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
