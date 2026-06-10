import '../../data/models/system_settings_model.dart';

abstract class SystemSettingsRepository {
  Future<SystemSettingsModel> fetchSystemSettings();
}
