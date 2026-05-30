// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'B2B Marketplace';

  @override
  String get welcomeTitle => 'Welcome to KuriHub';

  @override
  String get welcomeSubtitle => 'Start by entering your mobile number to access B2B opportunities.';

  @override
  String get mobileNumber => 'Mobile number';

  @override
  String get sendCode => 'Send code';

  @override
  String get verifyCode => 'Verify code';

  @override
  String get enter6digitCode => 'Enter the 6-digit code';

  @override
  String get confirm => 'Confirm';

  @override
  String get searchProduct => 'Search product';

  @override
  String get mainCategories => 'Main categories';

  @override
  String get welcomeTaglineTitle => 'B2B marketplace for Kurdistan Region';

  @override
  String get welcomeTaglineSubtitle => 'Connect wholesalers and retailers across cities.';
}
