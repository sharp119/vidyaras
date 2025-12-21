import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../shared/providers/supabase_provider.dart';
import '../../3_domain/repositories/test_repository.dart';
import '../../3_domain/repositories/quiz_repository.dart';
import '../repositories/test_repository_impl.dart';
import '../repositories/quiz_repository_impl.dart';

part 'data_providers.g.dart';

/// TestRepository provider - wires concrete repository implementation
@riverpod
TestRepository testRepository(TestRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return TestRepositoryImpl(supabase);
}

/// QuizRepository provider - wires concrete repository implementation
@riverpod
QuizRepository quizRepository(QuizRepositoryRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return QuizRepositoryImpl(supabase);
}
