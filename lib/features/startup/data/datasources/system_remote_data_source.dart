import 'dart:convert';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/api_client.dart';
import '../models/system_settings_model.dart';

abstract class SystemRemoteDataSource {
  Future<SystemSettingsModel> fetchSystemSettings();
}

class SystemRemoteDataSourceImpl implements SystemRemoteDataSource {
  final ApiClient apiClient;

  const SystemRemoteDataSourceImpl({
    required this.apiClient,
  });

  @override
  Future<SystemSettingsModel> fetchSystemSettings() async {
    final response = await apiClient.get(ApiConstants.systemSettingsPath);

    try {
      final decoded = jsonDecode(response.body);

      if (decoded is! Map<String, dynamic>) {
        throw const ParsingException(
          code: 'parsing_error'
        );
      }

      return SystemSettingsModel.fromJson(decoded);
    } on AppException {
      rethrow;
    } catch (_) {
      throw const ParsingException(
        code: 'parsing_error'
      );
    }
  }
}
