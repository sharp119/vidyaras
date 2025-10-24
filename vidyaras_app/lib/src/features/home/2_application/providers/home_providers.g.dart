// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeRepositoryHash() => r'350f7e9a9a3f44cd86cee4a184ab9900dad37bae';

/// Provider for HomeRepository
///
/// Copied from [homeRepository].
@ProviderFor(homeRepository)
final homeRepositoryProvider = AutoDisposeProvider<HomeRepository>.internal(
  homeRepository,
  name: r'homeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeRepositoryRef = AutoDisposeProviderRef<HomeRepository>;
String _$courseDetailHash() => r'22418edd2a310bd8af980a2f293df0c28acb4a4d';

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

/// Provider for fetching course detail by ID
/// Returns CourseDetail for the specified course
///
/// Copied from [courseDetail].
@ProviderFor(courseDetail)
const courseDetailProvider = CourseDetailFamily();

/// Provider for fetching course detail by ID
/// Returns CourseDetail for the specified course
///
/// Copied from [courseDetail].
class CourseDetailFamily extends Family<AsyncValue<CourseDetail>> {
  /// Provider for fetching course detail by ID
  /// Returns CourseDetail for the specified course
  ///
  /// Copied from [courseDetail].
  const CourseDetailFamily();

  /// Provider for fetching course detail by ID
  /// Returns CourseDetail for the specified course
  ///
  /// Copied from [courseDetail].
  CourseDetailProvider call(String courseId) {
    return CourseDetailProvider(courseId);
  }

  @override
  CourseDetailProvider getProviderOverride(
    covariant CourseDetailProvider provider,
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
  String? get name => r'courseDetailProvider';
}

/// Provider for fetching course detail by ID
/// Returns CourseDetail for the specified course
///
/// Copied from [courseDetail].
class CourseDetailProvider extends AutoDisposeFutureProvider<CourseDetail> {
  /// Provider for fetching course detail by ID
  /// Returns CourseDetail for the specified course
  ///
  /// Copied from [courseDetail].
  CourseDetailProvider(String courseId)
    : this._internal(
        (ref) => courseDetail(ref as CourseDetailRef, courseId),
        from: courseDetailProvider,
        name: r'courseDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$courseDetailHash,
        dependencies: CourseDetailFamily._dependencies,
        allTransitiveDependencies:
            CourseDetailFamily._allTransitiveDependencies,
        courseId: courseId,
      );

  CourseDetailProvider._internal(
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
    FutureOr<CourseDetail> Function(CourseDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CourseDetailProvider._internal(
        (ref) => create(ref as CourseDetailRef),
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
  AutoDisposeFutureProviderElement<CourseDetail> createElement() {
    return _CourseDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailProvider && other.courseId == courseId;
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
mixin CourseDetailRef on AutoDisposeFutureProviderRef<CourseDetail> {
  /// The parameter `courseId` of this provider.
  String get courseId;
}

class _CourseDetailProviderElement
    extends AutoDisposeFutureProviderElement<CourseDetail>
    with CourseDetailRef {
  _CourseDetailProviderElement(super.provider);

  @override
  String get courseId => (origin as CourseDetailProvider).courseId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
