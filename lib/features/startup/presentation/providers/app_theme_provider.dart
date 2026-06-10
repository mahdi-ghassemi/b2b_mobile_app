import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  static const String _storageKey = 'theme_mode';

  final SharedPreferences preferences;

  late ThemeMode _mode;

  AppThemeProvider({
    required this.preferences,
  }) {
    _mode = _themeModeFromString(
      preferences.getString(_storageKey) ?? ThemeMode.system.name,
    );
  }

  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  Future<void> setThemeMode(ThemeMode mode) async {
    _mode = mode;
    await preferences.setString(_storageKey, mode.name);
    notifyListeners();
  }

  Future<void> toggleLightDark() async {
    if (_mode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
      return;
    }

    await setThemeMode(ThemeMode.dark);
  }

  Future<void> useSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }

  ThemeMode _themeModeFromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}
