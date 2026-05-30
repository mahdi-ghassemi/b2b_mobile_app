import 'package:flutter/material.dart';

class Country {
  final String code;
  final String name;
  final String dialCode;
  final String? flagEmoji;
  final String? flagAsset;

  const Country({
    required this.code,
    required this.name,
    required this.dialCode,
    this.flagEmoji,
    this.flagAsset,
  });
}

class AppLanguageOption {
  final String code;
  final String label;
  final Locale locale;
  final String? flagEmoji;
  final String? flagAsset;
  final String? defaultCountryCode;

  const AppLanguageOption({
    required this.code,
    required this.label,
    required this.locale,
    this.flagEmoji,
    this.flagAsset,
    this.defaultCountryCode,
  });
}

const List<Country> kCountries = [
  Country(
    code: 'kri',
    name: 'Kurdistan Region / Iraq',
    dialCode: '+964',
    flagAsset: 'assets/flags/kurdistan.png',
  ),
  Country(
    code: 'iq',
    name: 'Iraq',
    dialCode: '+964',
    flagEmoji: '🇮🇶',
  ),
  Country(
    code: 'tr',
    name: 'Turkey',
    dialCode: '+90',
    flagEmoji: '🇹🇷',
  ),
  Country(
    code: 'ir',
    name: 'Iran',
    dialCode: '+98',
    flagEmoji: '🇮🇷',
  ),
  Country(
    code: 'sy',
    name: 'Syria',
    dialCode: '+963',
    flagEmoji: '🇸🇾',
  ),
  Country(
    code: 'sa',
    name: 'Saudi Arabia',
    dialCode: '+966',
    flagEmoji: '🇸🇦',
  ),
  Country(
    code: 'ae',
    name: 'United Arab Emirates',
    dialCode: '+971',
    flagEmoji: '🇦🇪',
  ),
];

const List<AppLanguageOption> kAppLanguages = [
  AppLanguageOption(
    code: 'en',
    label: 'English',
    locale: Locale('en'),
    flagEmoji: '🇬🇧',
    defaultCountryCode: 'kri',
  ),
  AppLanguageOption(
    code: 'ku',
    label: 'Kurdî',
    locale: Locale('ku'),
    flagAsset: 'assets/flags/kurdistan.png',
    defaultCountryCode: 'kri',
  ),
  AppLanguageOption(
    code: 'ar',
    label: 'العربية',
    locale: Locale('ar'),
    flagEmoji: '🇮🇶',
    defaultCountryCode: 'kri',
  ),
  AppLanguageOption(
    code: 'fa',
    label: 'فارسی',
    locale: Locale('fa'),
    flagEmoji: '🇮🇷',
    defaultCountryCode: 'ir',
  ),
];

AppLanguageOption findLanguageOption(String code) {
  return kAppLanguages.firstWhere(
        (l) => l.code == code,
    orElse: () => kAppLanguages.first,
  );
}

Country? findCountryByCode(String? code) {
  if (code == null) return null;
  try {
    return kCountries.firstWhere((c) => c.code == code);
  } catch (_) {
    return null;
  }
}

Widget buildFlagWidget({
  String? emoji,
  String? asset,
  double width = 28,
  double height = 20,
}) {
  if (asset != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Image.asset(
        asset,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }

  if (emoji != null) {
    return Text(
      emoji,
      style: const TextStyle(fontSize: 20),
    );
  }

  return const SizedBox.shrink();
}