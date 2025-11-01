import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:vidyaras_app/src/features/auth/2_application/providers/auth_providers.dart';
import 'package:vidyaras_app/src/features/auth/3_domain/models/user.dart' as domain;
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/course_progress_detail.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/models/enrolled_course.dart';
import 'package:vidyaras_app/src/features/my_courses/3_domain/repositories/my_courses_repository.dart';
import 'package:vidyaras_app/src/features/my_courses/4_data/repositories/my_courses_repository_impl.dart';
import 'package:vidyaras_app/src/features/my_courses/4_data/repositories/my_courses_repository_mock.dart';
import 'package:vidyaras_app/src/shared/domain/failures/failure.dart';

part 'my_courses_providers.g.dart';

enum MyCoursesFilter { all, inProgress, completed }

/// Temporary flag to surface mock data until real auth-driven data is wired.
const bool _useMockData = true;

@riverpod
MyCoursesRepository myCoursesRepository(MyCoursesRepositoryRef ref) {
  if (_useMockData) {
    return MyCoursesRepositoryMock();
  }
  final client = Supabase.instance.client;
  return MyCoursesRepositoryImpl(client);
}

@riverpod
class MyCoursesFilterController extends _$MyCoursesFilterController {
  @override
  MyCoursesFilter build() => MyCoursesFilter.all;

  void update(MyCoursesFilter filter) => state = filter;
}

@riverpod
Future<List<EnrolledCourse>> myEnrolledCourses(MyEnrolledCoursesRef ref) async {
  final repository = ref.watch(myCoursesRepositoryProvider);
  final userId = await _resolveUserId(ref, allowMock: _useMockData);

  final result = await repository.getEnrolledCourses(userId: userId);
  return result.match(
    (failure) => throw failure,
    (courses) => courses,
  );
}

@riverpod
Future<CourseProgressDetail> courseProgressDetail(
  CourseProgressDetailRef ref,
  String courseId,
) async {
  final repository = ref.watch(myCoursesRepositoryProvider);
  final userId = await _resolveUserId(ref, allowMock: _useMockData);

  final result = await repository.getCourseProgressDetail(
    userId: userId,
    courseId: courseId,
  );

  return result.match(
    (failure) => throw failure,
    (detail) => detail,
  );
}

Future<String> _resolveUserId(Ref ref, {required bool allowMock}) async {
  try {
    final user = await ref.watch(currentUserProvider.future);
    if (user != null) return user.id;
  } catch (_) {
    // Ignore auth fetch failures; fallback handled below.
  }

  if (allowMock) {
    return _mockUser.id;
  }

  throw const AuthFailure(message: 'User not logged in');
}

const domain.User _mockUser = domain.User(
  id: 'mock-user-123',
  phoneNumber: '+910000000000',
  name: 'Demo Learner',
);
