// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_courses_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myCoursesRepositoryHash() =>
    r'2c3663d2e8f1b6f9a7d0a1e223bbe44ba36e66c8';

/// See also [myCoursesRepository].
@ProviderFor(myCoursesRepository)
final myCoursesRepositoryProvider =
    AutoDisposeProvider<MyCoursesRepository>.internal(
      myCoursesRepository,
      name: r'myCoursesRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myCoursesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyCoursesRepositoryRef = AutoDisposeProviderRef<MyCoursesRepository>;
String _$myEnrolledCoursesHash() => r'c1af063cf582216549535c5d81f045ebfdca620f';

/// See also [myEnrolledCourses].
@ProviderFor(myEnrolledCourses)
final myEnrolledCoursesProvider =
    AutoDisposeFutureProvider<List<EnrolledCourse>>.internal(
      myEnrolledCourses,
      name: r'myEnrolledCoursesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myEnrolledCoursesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MyEnrolledCoursesRef =
    AutoDisposeFutureProviderRef<List<EnrolledCourse>>;
String _$courseProgressDetailHash() =>
    r'1f9f13a0443714280297c34354013abb8409a874';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [courseProgressDetail].
@ProviderFor(courseProgressDetail)
const courseProgressDetailProvider = CourseProgressDetailFamily();

/// See also [courseProgressDetail].
class CourseProgressDetailFamily
    extends Family<AsyncValue<CourseProgressDetail>> {
  /// See also [courseProgressDetail].
  const CourseProgressDetailFamily();

  /// See also [courseProgressDetail].
  CourseProgressDetailProvider call(String courseId) {
    return CourseProgressDetailProvider(courseId);
  }

  @override
  CourseProgressDetailProvider getProviderOverride(
    covariant CourseProgressDetailProvider provider,
  ) {
    return call(provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseProgressDetailProvider';
}

/// See also [courseProgressDetail].
class CourseProgressDetailProvider
    extends AutoDisposeFutureProvider<CourseProgressDetail> {
  /// See also [courseProgressDetail].
  CourseProgressDetailProvider(String courseId)
    : this._internal(
        (ref) => courseProgressDetail(ref as CourseProgressDetailRef, courseId),
        from: courseProgressDetailProvider,
        name: r'courseProgressDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseProgressDetailHash,
        dependencies: CourseProgressDetailFamily._dependencies,
        allTransitiveDependencies:
            CourseProgressDetailFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseProgressDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.courseId,
  }) : super.internal();

  final String courseId;

  @override
  Override overrideWith(
    FutureOr<CourseProgressDetail> Function(CourseProgressDetailRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseProgressDetailProvider._internal(
        (ref) => create(ref as CourseProgressDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CourseProgressDetail> createElement() {
    return _CourseProgressDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseProgressDetailProvider && other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CourseProgressDetailRef
    on AutoDisposeFutureProviderRef<CourseProgressDetail> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseProgressDetailProviderElement
    extends AutoDisposeFutureProviderElement<CourseProgressDetail>
    with CourseProgressDetailRef {
  _CourseProgressDetailProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseProgressDetailProvider).courseId;
}

String _$myCoursesFilterControllerHash() =>
    r'fdc435270356c2a02d2b1d7c82ab6c0b0b25d976';

/// See also [MyCoursesFilterController].
@ProviderFor(MyCoursesFilterController)
final myCoursesFilterControllerProvider =
    AutoDisposeNotifierProvider<
      MyCoursesFilterController,
      MyCoursesFilter
    >.internal(
      MyCoursesFilterController.new,
      name: r'myCoursesFilterControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$myCoursesFilterControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MyCoursesFilterController = AutoDisposeNotifier<MyCoursesFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
