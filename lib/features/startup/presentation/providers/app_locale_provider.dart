import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/app_config.dart';

class AppLocaleProvider extends ChangeNotifier {
  static const String _storageKey = 'app_locale';

  final SharedPreferences preferences;

  late Locale _locale;

  AppLocaleProvider({
    required this.preferences,
  }) {
    final storedLanguageCode = preferences.getString(_storageKey);
    _locale = findLanguageOption(storedLanguageCode ?? 'en').locale;
  }

  Locale get locale => _locale;

  bool get hasUserSelectedLanguage => preferences.containsKey(_storageKey);

  Future<void> changeLanguage(String code) async {
    final language = findLanguageOption(code);

    _locale = language.locale;
    await preferences.setString(_storageKey, language.code);

    notifyListeners();
  }

  Future<void> applyServerDefaultIfNeeded(String code) async {
    if (hasUserSelectedLanguage) {
      return;
    }

    final language = findLanguageOption(code);

    if (_locale.languageCode == language.locale.languageCode) {
      return;
    }

    _locale = language.locale;
    notifyListeners();
  }
}
