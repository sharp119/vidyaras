// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$publishedQuizzesHash() => r'9822dcf087bf279a4844f122db8e24cbae6f619f';

/// Provider to fetch all published quizzes for the current user
///
/// Copied from [publishedQuizzes].
@ProviderFor(publishedQuizzes)
final publishedQuizzesProvider = AutoDisposeFutureProvider<List<Quiz>>.internal(
  publishedQuizzes,
  name: r'publishedQuizzesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$publishedQuizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PublishedQuizzesRef = AutoDisposeFutureProviderRef<List<Quiz>>;
String _$availableQuizzesHash() => r'50086cb86465e890eb762f494d5813be169efed2';

/// Provider to fetch available quizzes (not attempted) for the current user
///
/// Copied from [availableQuizzes].
@ProviderFor(availableQuizzes)
final availableQuizzesProvider = AutoDisposeFutureProvider<List<Quiz>>.internal(
  availableQuizzes,
  name: r'availableQuizzesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$availableQuizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AvailableQuizzesRef = AutoDisposeFutureProviderRef<List<Quiz>>;
String _$completedQuizzesHash() => r'84408a5fbc3219b41b4a8dc7ed0030b601334747';

/// Provider to fetch completed quizzes (quiz history) for the current user
///
/// Copied from [completedQuizzes].
@ProviderFor(completedQuizzes)
final completedQuizzesProvider = AutoDisposeFutureProvider<List<Quiz>>.internal(
  completedQuizzes,
  name: r'completedQuizzesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedQuizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompletedQuizzesRef = AutoDisposeFutureProviderRef<List<Quiz>>;
String _$quizByIdHash() => r'89125fb210d9dfe08765ef1a4cbe86faac16a272';

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

/// Provider to fetch a specific quiz by ID
///
/// Copied from [quizById].
@ProviderFor(quizById)
const quizByIdProvider = QuizByIdFamily();

/// Provider to fetch a specific quiz by ID
///
/// Copied from [quizById].
class QuizByIdFamily extends Family<AsyncValue<Quiz>> {
  /// Provider to fetch a specific quiz by ID
  ///
  /// Copied from [quizById].
  const QuizByIdFamily();

  /// Provider to fetch a specific quiz by ID
  ///
  /// Copied from [quizById].
  QuizByIdProvider call(String quizId) {
    return QuizByIdProvider(quizId);
  }

  @override
  QuizByIdProvider getProviderOverride(covariant QuizByIdProvider provider) {
    return call(provider.quizId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizByIdProvider';
}

/// Provider to fetch a specific quiz by ID
///
/// Copied from [quizById].
class QuizByIdProvider extends AutoDisposeFutureProvider<Quiz> {
  /// Provider to fetch a specific quiz by ID
  ///
  /// Copied from [quizById].
  QuizByIdProvider(String quizId)
    : this._internal(
        (ref) => quizById(ref as QuizByIdRef, quizId),
        from: quizByIdProvider,
        name: r'quizByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$quizByIdHash,
        dependencies: QuizByIdFamily._dependencies,
        allTransitiveDependencies: QuizByIdFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  QuizByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizId,
  }) : super.internal();

  final String quizId;

  @override
  Override overrideWith(FutureOr<Quiz> Function(QuizByIdRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: QuizByIdProvider._internal(
        (ref) => create(ref as QuizByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizId: quizId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Quiz> createElement() {
    return _QuizByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizByIdProvider && other.quizId == quizId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuizByIdRef on AutoDisposeFutureProviderRef<Quiz> {
  /// The parameter `quizId` of this provider.
  String get quizId;
}

class _QuizByIdProviderElement extends AutoDisposeFutureProviderElement<Quiz>
    with QuizByIdRef {
  _QuizByIdProviderElement(super.provider);

  @override
  String get quizId => (origin as QuizByIdProvider).quizId;
}

String _$quizQuestionsHash() => r'460e0336b3002a1dece6437d928ba1396e2ebe44';

/// Provider to fetch questions for a specific quiz
///
/// Copied from [quizQuestions].
@ProviderFor(quizQuestions)
const quizQuestionsProvider = QuizQuestionsFamily();

/// Provider to fetch questions for a specific quiz
///
/// Copied from [quizQuestions].
class QuizQuestionsFamily extends Family<AsyncValue<List<QuizQuestion>>> {
  /// Provider to fetch questions for a specific quiz
  ///
  /// Copied from [quizQuestions].
  const QuizQuestionsFamily();

  /// Provider to fetch questions for a specific quiz
  ///
  /// Copied from [quizQuestions].
  QuizQuestionsProvider call(String quizId) {
    return QuizQuestionsProvider(quizId);
  }

  @override
  QuizQuestionsProvider getProviderOverride(
    covariant QuizQuestionsProvider provider,
  ) {
    return call(provider.quizId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizQuestionsProvider';
}

/// Provider to fetch questions for a specific quiz
///
/// Copied from [quizQuestions].
class QuizQuestionsProvider
    extends AutoDisposeFutureProvider<List<QuizQuestion>> {
  /// Provider to fetch questions for a specific quiz
  ///
  /// Copied from [quizQuestions].
  QuizQuestionsProvider(String quizId)
    : this._internal(
        (ref) => quizQuestions(ref as QuizQuestionsRef, quizId),
        from: quizQuestionsProvider,
        name: r'quizQuestionsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$quizQuestionsHash,
        dependencies: QuizQuestionsFamily._dependencies,
        allTransitiveDependencies:
            QuizQuestionsFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  QuizQuestionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizId,
  }) : super.internal();

  final String quizId;

  @override
  Override overrideWith(
    FutureOr<List<QuizQuestion>> Function(QuizQuestionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuizQuestionsProvider._internal(
        (ref) => create(ref as QuizQuestionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizId: quizId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<QuizQuestion>> createElement() {
    return _QuizQuestionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizQuestionsProvider && other.quizId == quizId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuizQuestionsRef on AutoDisposeFutureProviderRef<List<QuizQuestion>> {
  /// The parameter `quizId` of this provider.
  String get quizId;
}

class _QuizQuestionsProviderElement
    extends AutoDisposeFutureProviderElement<List<QuizQuestion>>
    with QuizQuestionsRef {
  _QuizQuestionsProviderElement(super.provider);

  @override
  String get quizId => (origin as QuizQuestionsProvider).quizId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
