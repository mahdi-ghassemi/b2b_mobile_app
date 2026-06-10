import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/app_environment.dart';
import '../errors/app_exception.dart';

class ApiClient {
  final http.Client httpClient;
  final AppEnvironment environment;
  final Duration timeout;

  const ApiClient({
    required this.httpClient,
    required this.environment,
    this.timeout = const Duration(seconds: 15),
  });

  Future<http.Response> get(
      String path, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParameters,
      }) async {
    final uri = _buildUri(path, queryParameters);

    try {
      final response = await httpClient
          .get(
        uri,
        headers: _buildHeaders(headers),
      )
          .timeout(timeout);

      _throwIfInvalidResponse(response);
      return response;
    } on SocketException {
      throw const NetworkException(
        code: 'network_error',
      );
    } on TimeoutException {
      throw const TimeoutAppException(
        code: 'request_timeout',
      );
    } on AppException {
      rethrow;
    } catch (_) {
      throw const UnknownAppException(
        code: 'unknown_error',
      );
    }
  }

  Uri _buildUri(String path, Map<String, dynamic>? queryParameters) {
    final base = environment.baseUrl.endsWith('/')
        ? environment.baseUrl.substring(0, environment.baseUrl.length - 1)
        : environment.baseUrl;

    final normalizedPath = path.startsWith('/') ? path : '/$path';

    final uri = Uri.parse('$base$normalizedPath');

    if (queryParameters == null || queryParameters.isEmpty) {
      return uri;
    }

    return uri.replace(
      queryParameters: queryParameters.map(
            (key, value) => MapEntry(key, value.toString()),
      ),
    );
  }

  Map<String, String> _buildHeaders(Map<String, String>? headers) {
    return {
      'Accept': 'application/json',
      environment.apiKeyHeaderName: environment.apiKey,
      if (headers != null) ...headers,
    };
  }

  void _throwIfInvalidResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    final backendError = _extractBackendError(response);

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw UnauthorizedException(
        code: backendError.code ?? 'unauthorized',
        message: backendError.message,
      );
    }

    throw ServerException(
      code: backendError.code ?? 'server_error',
      message: backendError.message,
    );
  }

  _BackendError _extractBackendError(http.Response response) {
    try {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        final code = decoded['code'] ??
            decoded['errorCode'] ??
            decoded['error_code'] ??
            decoded['type'];

        final message = decoded['message'] ?? decoded['error'];

        return _BackendError(
          code: code is String && code.trim().isNotEmpty ? code.trim() : null,
          message: message is String && message.trim().isNotEmpty
              ? message.trim()
              : null,
        );
      }

      return const _BackendError();
    } catch (_) {
      return const _BackendError();
    }
  }
}

class _BackendError {
  final String? code;
  final String? message;

  const _BackendError({
    this.code,
    this.message,
  });
}
