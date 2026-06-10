sealed class AppException implements Exception {
  final String? message;
  final String? code;

  const AppException({this.message, this.code});

  @override
  String toString() => message ?? code ?? runtimeType.toString();
}

class NetworkException extends AppException {
  const NetworkException({super.message, super.code});
}

class TimeoutAppException extends AppException {
  const TimeoutAppException({super.message, super.code});
}

class ServerException extends AppException {
  const ServerException({super.message, super.code});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({super.message, super.code});
}

class ParsingException extends AppException {
  const ParsingException({super.message, super.code});
}

class UnknownAppException extends AppException {
  const UnknownAppException({super.message, super.code});
}
