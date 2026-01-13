/// Custom exceptions for the app
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException({
    required this.message,
    this.code,
    this.details,
  });

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException({
    required super.message,
    super.code,
    super.details,
  });
}

class ServerException extends AppException {
  ServerException({
    required super.message,
    super.code,
    super.details,
  });
}

class CacheException extends AppException {
  CacheException({
    required super.message,
    super.code,
    super.details,
  });
}

class ValidationException extends AppException {
  ValidationException({
    required super.message,
    super.code,
    super.details,
  });
}

class AuthException extends AppException {
  AuthException({
    required super.message,
    super.code,
    super.details,
  });
}

class NotFoundException extends AppException {
  NotFoundException({
    required super.message,
    super.code,
    super.details,
  });
}

class PermissionException extends AppException {
  PermissionException({
    required super.message,
    super.code,
    super.details,
  });
}

class LocationException extends AppException {
  LocationException({
    required super.message,
    super.code,
    super.details,
  });
}

class MediaException extends AppException {
  MediaException({
    required super.message,
    super.code,
    super.details,
  });
}

class AIException extends AppException {
  AIException({
    required super.message,
    super.code,
    super.details,
  });
}
