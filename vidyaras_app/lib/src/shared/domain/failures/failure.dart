import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
/// Uses equatable for value-based equality comparison
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Failure related to local storage operations
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code,
  });
}

/// Failure related to network/API operations
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

/// Failure related to data parsing/serialization
class DataFailure extends Failure {
  const DataFailure({
    required super.message,
    super.code,
  });
}

/// Generic server failure
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

/// Failure related to authentication
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

/// Generic unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.code,
  });
}
