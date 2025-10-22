// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizNotifierHash() => r'06a60a90d92473fd7b0536c559f78cc55cff1e4e';

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

abstract class _$QuizNotifier extends BuildlessAutoDisposeNotifier<QuizState> {
  late final String testId;

  QuizState build(String testId);
}

/// Notifier for managing quiz taking state
///
/// Copied from [QuizNotifier].
@ProviderFor(QuizNotifier)
const quizNotifierProvider = QuizNotifierFamily();

/// Notifier for managing quiz taking state
///
/// Copied from [QuizNotifier].
class QuizNotifierFamily extends Family<QuizState> {
  /// Notifier for managing quiz taking state
  ///
  /// Copied from [QuizNotifier].
  const QuizNotifierFamily();

  /// Notifier for managing quiz taking state
  ///
  /// Copied from [QuizNotifier].
  QuizNotifierProvider call(String testId) {
    return QuizNotifierProvider(testId);
  }

  @override
  QuizNotifierProvider getProviderOverride(
    covariant QuizNotifierProvider provider,
  ) {
    return call(provider.testId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'quizNotifierProvider';
}

/// Notifier for managing quiz taking state
///
/// Copied from [QuizNotifier].
class QuizNotifierProvider
    extends AutoDisposeNotifierProviderImpl<QuizNotifier, QuizState> {
  /// Notifier for managing quiz taking state
  ///
  /// Copied from [QuizNotifier].
  QuizNotifierProvider(String testId)
    : this._internal(
        () => QuizNotifier()..testId = testId,
        from: quizNotifierProvider,
        name: r'quizNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$quizNotifierHash,
        dependencies: QuizNotifierFamily._dependencies,
        allTransitiveDependencies:
            QuizNotifierFamily._allTransitiveDependencies,
        testId: testId,
      );

  QuizNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.testId,
  }) : super.internal();

  final String testId;

  @override
  QuizState runNotifierBuild(covariant QuizNotifier notifier) {
    return notifier.build(testId);
  }

  @override
  Override overrideWith(QuizNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: QuizNotifierProvider._internal(
        () => create()..testId = testId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        testId: testId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<QuizNotifier, QuizState> createElement() {
    return _QuizNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizNotifierProvider && other.testId == testId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, testId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin QuizNotifierRef on AutoDisposeNotifierProviderRef<QuizState> {
  /// The parameter `testId` of this provider.
  String get testId;
}

class _QuizNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<QuizNotifier, QuizState>
    with QuizNotifierRef {
  _QuizNotifierProviderElement(super.provider);

  @override
  String get testId => (origin as QuizNotifierProvider).testId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
