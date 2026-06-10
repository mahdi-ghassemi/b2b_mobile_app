import 'package:flutter/foundation.dart';

import '../../data/models/system_settings_model.dart';

class AppConfigProvider extends ChangeNotifier {
  SystemSettingsModel? _settings;

  SystemSettingsModel? get settings => _settings;

  bool get hasSettings => _settings != null;

  String get appName => _settings?.appName ?? '';

  String get defaultLanguage => _settings?.defaultLanguage ?? 'en';

  HomeMode get homeMode => _settings?.home.mode ?? HomeMode.empty;

  bool get hasHomeProducts => _settings?.home.hasHomeProducts ?? false;

  Map<String, dynamic> get extra => _settings?.extra ?? <String, dynamic>{};

  void setSettings(SystemSettingsModel settings) {
    _settings = settings;
    notifyListeners();
  }

  void clear() {
    _settings = null;
    notifyListeners();
  }
}
