import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../3_domain/repositories/home_repository.dart';
import '../../3_domain/models/course_detail.dart';
import '../../4_data/repositories/home_repository_impl.dart';
import '../../4_data/datasources/home_remote_datasource.dart';
import '../../../auth/2_application/providers/auth_providers.dart';

part 'home_providers.g.dart';

/// Supabase client provider (shared)
@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) {
  return Supabase.instance.client;
}

/// Provider for HomeRemoteDataSource
@riverpod
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return HomeRemoteDataSource(supabase);
}

/// Provider for HomeRepository
@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final profileDataSource = ref.watch(profileDataSourceProvider);
  final homeRemoteDataSource = ref.watch(homeRemoteDataSourceProvider);
  return HomeRepositoryImpl(
    authRepository,
    profileDataSource,
    homeRemoteDataSource,
  );
}

/// Provider for fetching course detail by ID
@riverpod
Future<CourseDetail> courseDetail(CourseDetailRef ref, String courseId) async {
  final repository = ref.watch(homeRepositoryProvider);
  final result = await repository.getCourseDetail(courseId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (courseDetail) => courseDetail,
  );
}
