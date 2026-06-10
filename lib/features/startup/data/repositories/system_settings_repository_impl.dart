import '../../domain/repositories/system_settings_repository.dart';
import '../datasources/system_remote_data_source.dart';
import '../models/system_settings_model.dart';

class SystemSettingsRepositoryImpl implements SystemSettingsRepository {
  final SystemRemoteDataSource remoteDataSource;

  const SystemSettingsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<SystemSettingsModel> fetchSystemSettings() {
    return remoteDataSource.fetchSystemSettings();
  }
}
