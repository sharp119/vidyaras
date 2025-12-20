// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$supabaseClientHash() => r'36e9cae00709545a85bfe4a5a2cb98d8686a01ea';

/// Supabase client provider
///
/// Copied from [supabaseClient].
@ProviderFor(supabaseClient)
final supabaseClientProvider = AutoDisposeProvider<SupabaseClient>.internal(
  supabaseClient,
  name: r'supabaseClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$supabaseClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SupabaseClientRef = AutoDisposeProviderRef<SupabaseClient>;
String _$coursesRemoteDataSourceHash() =>
    r'a8ba8ea2fb977f13cd6c97eb1ce4b5da2fefe9aa';

/// Courses remote data source provider
///
/// Copied from [coursesRemoteDataSource].
@ProviderFor(coursesRemoteDataSource)
final coursesRemoteDataSourceProvider =
    AutoDisposeProvider<CoursesRemoteDataSource>.internal(
      coursesRemoteDataSource,
      name: r'coursesRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coursesRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoursesRemoteDataSourceRef =
    AutoDisposeProviderRef<CoursesRemoteDataSource>;
String _$coursesRepositoryHash() => r'27efd719a5c17100de273ba7ac7488b8a7e09fa2';

/// Courses repository provider
///
/// Copied from [coursesRepository].
@ProviderFor(coursesRepository)
final coursesRepositoryProvider =
    AutoDisposeProvider<CoursesRepository>.internal(
      coursesRepository,
      name: r'coursesRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$coursesRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoursesRepositoryRef = AutoDisposeProviderRef<CoursesRepository>;
String _$allCoursesHash() => r'1d17e00ace57b6b9c77c57ef833ba84c6a828a1a';

/// Provider for fetching all courses
///
/// Copied from [allCourses].
@ProviderFor(allCourses)
final allCoursesProvider = AutoDisposeFutureProvider<List<Course>>.internal(
  allCourses,
  name: r'allCoursesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allCoursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCoursesRef = AutoDisposeFutureProviderRef<List<Course>>;
String _$searchCoursesHash() => r'638d51b7628292d79e7d6d49dd5ec48eaa4eb80e';

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

/// Provider for searching courses
///
/// Copied from [searchCourses].
@ProviderFor(searchCourses)
const searchCoursesProvider = SearchCoursesFamily();

/// Provider for searching courses
///
/// Copied from [searchCourses].
class SearchCoursesFamily extends Family<AsyncValue<List<Course>>> {
  /// Provider for searching courses
  ///
  /// Copied from [searchCourses].
  const SearchCoursesFamily();

  /// Provider for searching courses
  ///
  /// Copied from [searchCourses].
  SearchCoursesProvider call(String query) {
    return SearchCoursesProvider(query);
  }

  @override
  SearchCoursesProvider getProviderOverride(
    covariant SearchCoursesProvider provider,
  ) {
    return call(provider.query);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchCoursesProvider';
}

/// Provider for searching courses
///
/// Copied from [searchCourses].
class SearchCoursesProvider extends AutoDisposeFutureProvider<List<Course>> {
  /// Provider for searching courses
  ///
  /// Copied from [searchCourses].
  SearchCoursesProvider(String query)
    : this._internal(
        (ref) => searchCourses(ref as SearchCoursesRef, query),
        from: searchCoursesProvider,
        name: r'searchCoursesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$searchCoursesHash,
        dependencies: SearchCoursesFamily._dependencies,
        allTransitiveDependencies:
            SearchCoursesFamily._allTransitiveDependencies,
        query: query,
      );

  SearchCoursesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Course>> Function(SearchCoursesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchCoursesProvider._internal(
        (ref) => create(ref as SearchCoursesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Course>> createElement() {
    return _SearchCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchCoursesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SearchCoursesRef on AutoDisposeFutureProviderRef<List<Course>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchCoursesProviderElement
    extends AutoDisposeFutureProviderElement<List<Course>>
    with SearchCoursesRef {
  _SearchCoursesProviderElement(super.provider);

  @override
  String get query => (origin as SearchCoursesProvider).query;
}

String _$coursesByCategoryHash() => r'faff09c19d318790883f0e903d90f899676ec186';

/// Provider for filtering courses by category
///
/// Copied from [coursesByCategory].
@ProviderFor(coursesByCategory)
const coursesByCategoryProvider = CoursesByCategoryFamily();

/// Provider for filtering courses by category
///
/// Copied from [coursesByCategory].
class CoursesByCategoryFamily extends Family<AsyncValue<List<Course>>> {
  /// Provider for filtering courses by category
  ///
  /// Copied from [coursesByCategory].
  const CoursesByCategoryFamily();

  /// Provider for filtering courses by category
  ///
  /// Copied from [coursesByCategory].
  CoursesByCategoryProvider call(String category) {
    return CoursesByCategoryProvider(category);
  }

  @override
  CoursesByCategoryProvider getProviderOverride(
    covariant CoursesByCategoryProvider provider,
  ) {
    return call(provider.category);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'coursesByCategoryProvider';
}

/// Provider for filtering courses by category
///
/// Copied from [coursesByCategory].
class CoursesByCategoryProvider
    extends AutoDisposeFutureProvider<List<Course>> {
  /// Provider for filtering courses by category
  ///
  /// Copied from [coursesByCategory].
  CoursesByCategoryProvider(String category)
    : this._internal(
        (ref) => coursesByCategory(ref as CoursesByCategoryRef, category),
        from: coursesByCategoryProvider,
        name: r'coursesByCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$coursesByCategoryHash,
        dependencies: CoursesByCategoryFamily._dependencies,
        allTransitiveDependencies:
            CoursesByCategoryFamily._allTransitiveDependencies,
        category: category,
      );

  CoursesByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    FutureOr<List<Course>> Function(CoursesByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CoursesByCategoryProvider._internal(
        (ref) => create(ref as CoursesByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Course>> createElement() {
    return _CoursesByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CoursesByCategoryProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CoursesByCategoryRef on AutoDisposeFutureProviderRef<List<Course>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _CoursesByCategoryProviderElement
    extends AutoDisposeFutureProviderElement<List<Course>>
    with CoursesByCategoryRef {
  _CoursesByCategoryProviderElement(super.provider);

  @override
  String get category => (origin as CoursesByCategoryProvider).category;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
