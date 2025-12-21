// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_learning_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$enrolledCoursesHash() => r'7f3b2856d4ec71721e2abd77b1de2d8082862b2c';

/// Fetches all enrolled courses for the current user
///
/// Copied from [enrolledCourses].
@ProviderFor(enrolledCourses)
final enrolledCoursesProvider =
    AutoDisposeFutureProvider<List<EnrolledCourse>>.internal(
      enrolledCourses,
      name: r'enrolledCoursesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$enrolledCoursesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EnrolledCoursesRef = AutoDisposeFutureProviderRef<List<EnrolledCourse>>;
String _$courseDetailsHash() => r'd49d11a6805a63b45f8b1a03b3f91626ddff2ab9';

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

/// Fetches detailed course information including lectures and materials
///
/// Copied from [courseDetails].
@ProviderFor(courseDetails)
const courseDetailsProvider = CourseDetailsFamily();

/// Fetches detailed course information including lectures and materials
///
/// Copied from [courseDetails].
class CourseDetailsFamily extends Family<AsyncValue<EnrolledCourse>> {
  /// Fetches detailed course information including lectures and materials
  ///
  /// Copied from [courseDetails].
  const CourseDetailsFamily();

  /// Fetches detailed course information including lectures and materials
  ///
  /// Copied from [courseDetails].
  CourseDetailsProvider call({required String courseId}) {
    return CourseDetailsProvider(courseId: courseId);
  }

  @override
  CourseDetailsProvider getProviderOverride(
    covariant CourseDetailsProvider provider,
  ) {
    return call(courseId: provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseDetailsProvider';
}

/// Fetches detailed course information including lectures and materials
///
/// Copied from [courseDetails].
class CourseDetailsProvider extends AutoDisposeFutureProvider<EnrolledCourse> {
  /// Fetches detailed course information including lectures and materials
  ///
  /// Copied from [courseDetails].
  CourseDetailsProvider({required String courseId})
    : this._internal(
        (ref) => courseDetails(ref as CourseDetailsRef, courseId: courseId),
        from: courseDetailsProvider,
        name: r'courseDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseDetailsHash,
        dependencies: CourseDetailsFamily._dependencies,
        allTransitiveDependencies:
            CourseDetailsFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseDetailsProvider._internal(
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
    FutureOr<EnrolledCourse> Function(CourseDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseDetailsProvider._internal(
        (ref) => create(ref as CourseDetailsRef),
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
  AutoDisposeFutureProviderElement<EnrolledCourse> createElement() {
    return _CourseDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailsProvider && other.courseId == courseId;
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
mixin CourseDetailsRef on AutoDisposeFutureProviderRef<EnrolledCourse> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseDetailsProviderElement
    extends AutoDisposeFutureProviderElement<EnrolledCourse>
    with CourseDetailsRef {
  _CourseDetailsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseDetailsProvider).courseId;
}

String _$courseLecturesHash() => r'50eb5405d3610aeb460982105aad941b2bb874ec';

/// Fetches lectures for a specific course
///
/// Copied from [courseLectures].
@ProviderFor(courseLectures)
const courseLecturesProvider = CourseLecturesFamily();

/// Fetches lectures for a specific course
///
/// Copied from [courseLectures].
class CourseLecturesFamily extends Family<AsyncValue<List<Lecture>>> {
  /// Fetches lectures for a specific course
  ///
  /// Copied from [courseLectures].
  const CourseLecturesFamily();

  /// Fetches lectures for a specific course
  ///
  /// Copied from [courseLectures].
  CourseLecturesProvider call({required String courseId}) {
    return CourseLecturesProvider(courseId: courseId);
  }

  @override
  CourseLecturesProvider getProviderOverride(
    covariant CourseLecturesProvider provider,
  ) {
    return call(courseId: provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseLecturesProvider';
}

/// Fetches lectures for a specific course
///
/// Copied from [courseLectures].
class CourseLecturesProvider extends AutoDisposeFutureProvider<List<Lecture>> {
  /// Fetches lectures for a specific course
  ///
  /// Copied from [courseLectures].
  CourseLecturesProvider({required String courseId})
    : this._internal(
        (ref) => courseLectures(ref as CourseLecturesRef, courseId: courseId),
        from: courseLecturesProvider,
        name: r'courseLecturesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseLecturesHash,
        dependencies: CourseLecturesFamily._dependencies,
        allTransitiveDependencies:
            CourseLecturesFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseLecturesProvider._internal(
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
    FutureOr<List<Lecture>> Function(CourseLecturesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseLecturesProvider._internal(
        (ref) => create(ref as CourseLecturesRef),
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
  AutoDisposeFutureProviderElement<List<Lecture>> createElement() {
    return _CourseLecturesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseLecturesProvider && other.courseId == courseId;
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
mixin CourseLecturesRef on AutoDisposeFutureProviderRef<List<Lecture>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseLecturesProviderElement
    extends AutoDisposeFutureProviderElement<List<Lecture>>
    with CourseLecturesRef {
  _CourseLecturesProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseLecturesProvider).courseId;
}

String _$courseLiveClassesHash() => r'7f12cbb9188862fdeed8fe603b1a914cc6805bc6';

/// Fetches live classes for a specific course
///
/// Copied from [courseLiveClasses].
@ProviderFor(courseLiveClasses)
const courseLiveClassesProvider = CourseLiveClassesFamily();

/// Fetches live classes for a specific course
///
/// Copied from [courseLiveClasses].
class CourseLiveClassesFamily extends Family<AsyncValue<List<LiveClass>>> {
  /// Fetches live classes for a specific course
  ///
  /// Copied from [courseLiveClasses].
  const CourseLiveClassesFamily();

  /// Fetches live classes for a specific course
  ///
  /// Copied from [courseLiveClasses].
  CourseLiveClassesProvider call({required String courseId}) {
    return CourseLiveClassesProvider(courseId: courseId);
  }

  @override
  CourseLiveClassesProvider getProviderOverride(
    covariant CourseLiveClassesProvider provider,
  ) {
    return call(courseId: provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseLiveClassesProvider';
}

/// Fetches live classes for a specific course
///
/// Copied from [courseLiveClasses].
class CourseLiveClassesProvider
    extends AutoDisposeFutureProvider<List<LiveClass>> {
  /// Fetches live classes for a specific course
  ///
  /// Copied from [courseLiveClasses].
  CourseLiveClassesProvider({required String courseId})
    : this._internal(
        (ref) =>
            courseLiveClasses(ref as CourseLiveClassesRef, courseId: courseId),
        from: courseLiveClassesProvider,
        name: r'courseLiveClassesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseLiveClassesHash,
        dependencies: CourseLiveClassesFamily._dependencies,
        allTransitiveDependencies:
            CourseLiveClassesFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseLiveClassesProvider._internal(
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
    FutureOr<List<LiveClass>> Function(CourseLiveClassesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseLiveClassesProvider._internal(
        (ref) => create(ref as CourseLiveClassesRef),
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
  AutoDisposeFutureProviderElement<List<LiveClass>> createElement() {
    return _CourseLiveClassesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseLiveClassesProvider && other.courseId == courseId;
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
mixin CourseLiveClassesRef on AutoDisposeFutureProviderRef<List<LiveClass>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseLiveClassesProviderElement
    extends AutoDisposeFutureProviderElement<List<LiveClass>>
    with CourseLiveClassesRef {
  _CourseLiveClassesProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseLiveClassesProvider).courseId;
}

String _$upcomingLiveClassesHash() =>
    r'83d883e85c9066a250aef8aaad5c15720439d9d5';

/// Fetches upcoming live classes across all enrolled courses
///
/// Copied from [upcomingLiveClasses].
@ProviderFor(upcomingLiveClasses)
final upcomingLiveClassesProvider =
    AutoDisposeFutureProvider<List<LiveClass>>.internal(
      upcomingLiveClasses,
      name: r'upcomingLiveClassesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$upcomingLiveClassesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingLiveClassesRef = AutoDisposeFutureProviderRef<List<LiveClass>>;
String _$courseMaterialsHash() => r'22b91f4edbcde325dd7c0d2fc4bc8ba0adbee18e';

/// Fetches course materials
///
/// Copied from [courseMaterials].
@ProviderFor(courseMaterials)
const courseMaterialsProvider = CourseMaterialsFamily();

/// Fetches course materials
///
/// Copied from [courseMaterials].
class CourseMaterialsFamily extends Family<AsyncValue<List<CourseMaterial>>> {
  /// Fetches course materials
  ///
  /// Copied from [courseMaterials].
  const CourseMaterialsFamily();

  /// Fetches course materials
  ///
  /// Copied from [courseMaterials].
  CourseMaterialsProvider call({required String courseId}) {
    return CourseMaterialsProvider(courseId: courseId);
  }

  @override
  CourseMaterialsProvider getProviderOverride(
    covariant CourseMaterialsProvider provider,
  ) {
    return call(courseId: provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseMaterialsProvider';
}

/// Fetches course materials
///
/// Copied from [courseMaterials].
class CourseMaterialsProvider
    extends AutoDisposeFutureProvider<List<CourseMaterial>> {
  /// Fetches course materials
  ///
  /// Copied from [courseMaterials].
  CourseMaterialsProvider({required String courseId})
    : this._internal(
        (ref) => courseMaterials(ref as CourseMaterialsRef, courseId: courseId),
        from: courseMaterialsProvider,
        name: r'courseMaterialsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseMaterialsHash,
        dependencies: CourseMaterialsFamily._dependencies,
        allTransitiveDependencies:
            CourseMaterialsFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseMaterialsProvider._internal(
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
    FutureOr<List<CourseMaterial>> Function(CourseMaterialsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseMaterialsProvider._internal(
        (ref) => create(ref as CourseMaterialsRef),
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
  AutoDisposeFutureProviderElement<List<CourseMaterial>> createElement() {
    return _CourseMaterialsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseMaterialsProvider && other.courseId == courseId;
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
mixin CourseMaterialsRef on AutoDisposeFutureProviderRef<List<CourseMaterial>> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseMaterialsProviderElement
    extends AutoDisposeFutureProviderElement<List<CourseMaterial>>
    with CourseMaterialsRef {
  _CourseMaterialsProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseMaterialsProvider).courseId;
}

String _$courseProgressHash() => r'880377eb8b481ec4bf3d48291655f2593877911c';

/// Fetches course progress statistics
///
/// Copied from [courseProgress].
@ProviderFor(courseProgress)
const courseProgressProvider = CourseProgressFamily();

/// Fetches course progress statistics
///
/// Copied from [courseProgress].
class CourseProgressFamily extends Family<AsyncValue<CourseProgress>> {
  /// Fetches course progress statistics
  ///
  /// Copied from [courseProgress].
  const CourseProgressFamily();

  /// Fetches course progress statistics
  ///
  /// Copied from [courseProgress].
  CourseProgressProvider call({required String courseId}) {
    return CourseProgressProvider(courseId: courseId);
  }

  @override
  CourseProgressProvider getProviderOverride(
    covariant CourseProgressProvider provider,
  ) {
    return call(courseId: provider.courseId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'courseProgressProvider';
}

/// Fetches course progress statistics
///
/// Copied from [courseProgress].
class CourseProgressProvider extends AutoDisposeFutureProvider<CourseProgress> {
  /// Fetches course progress statistics
  ///
  /// Copied from [courseProgress].
  CourseProgressProvider({required String courseId})
    : this._internal(
        (ref) => courseProgress(ref as CourseProgressRef, courseId: courseId),
        from: courseProgressProvider,
        name: r'courseProgressProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseProgressHash,
        dependencies: CourseProgressFamily._dependencies,
        allTransitiveDependencies:
            CourseProgressFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseProgressProvider._internal(
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
    FutureOr<CourseProgress> Function(CourseProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseProgressProvider._internal(
        (ref) => create(ref as CourseProgressRef),
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
  AutoDisposeFutureProviderElement<CourseProgress> createElement() {
    return _CourseProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseProgressProvider && other.courseId == courseId;
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
mixin CourseProgressRef on AutoDisposeFutureProviderRef<CourseProgress> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseProgressProviderElement
    extends AutoDisposeFutureProviderElement<CourseProgress>
    with CourseProgressRef {
  _CourseProgressProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseProgressProvider).courseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
