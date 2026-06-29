import 'package:equatable/equatable.dart';

/// Base class for all failures
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    String message = 'Server error occurred',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'Network connection failed',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({
    String message = 'Authentication failed',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    String message = 'Validation failed',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    String message = 'Resource not found',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Permission-related failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    String message = 'Permission denied',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Cache error occurred',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Database-related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    String message = 'Database error occurred',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

/// Unknown/unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'An unknown error occurred',
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}