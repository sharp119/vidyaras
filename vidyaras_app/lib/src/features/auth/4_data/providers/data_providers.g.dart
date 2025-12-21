// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileDataSourceHash() => r'dcf645cc781d9b34a75d9ed971824b18aa2131e8';

/// ProfileDataSource provider - wires concrete datasource implementation
///
/// Copied from [profileDataSource].
@ProviderFor(profileDataSource)
final profileDataSourceProvider =
    AutoDisposeProvider<ProfileDataSource>.internal(
      profileDataSource,
      name: r'profileDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileDataSourceRef = AutoDisposeProviderRef<ProfileDataSource>;
String _$authRepositoryHash() => r'b7c8d17c4b6355106bcda90664f12fd2d054b1af';

/// AuthRepository provider - wires concrete repository implementation
///
/// Copied from [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$msg91ServiceHash() => r'bdcf22fbc197156c935af20481711301b0a97fb6';

/// MSG91 Service provider
///
/// Copied from [msg91Service].
@ProviderFor(msg91Service)
final msg91ServiceProvider = AutoDisposeProvider<Msg91Service>.internal(
  msg91Service,
  name: r'msg91ServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$msg91ServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef Msg91ServiceRef = AutoDisposeProviderRef<Msg91Service>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
