// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'B2B Marketplace';

  @override
  String get welcomeTitle => 'Welcome to B2B Marketplace';

  @override
  String get welcomeSubtitle =>
      'Start by entering your mobile number to access B2B opportunities.';

  @override
  String get updateRequired => 'Update Required';

  @override
  String get updateTitle =>
      'A newer version of the application is available. Please update the app to continue.';

  @override
  String get mobileNumber => 'Mobile number';

  @override
  String get current => 'Current';

  @override
  String get required => 'Required';

  @override
  String get updateNow => 'Update Now';

  @override
  String get updateNotAvailable =>
      'Update link is not available. Please contact support.';

  @override
  String get updateLinkIsInvalid => 'Update link is invalid.';

  @override
  String get notOpenUpdateLink => 'Could not open update link.';

  @override
  String get unableStartApplication => 'Unable to start application';

  @override
  String get tryAgain => 'Try Again';

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
  String get welcomeTaglineTitle => 'B2B marketplace for Global Region';

  @override
  String get welcomeTaglineSubtitle =>
      'Connect wholesalers and retailers across cities.';

  @override
  String get errorApplicationStartupFailed => 'Application startup failed.';

  @override
  String get errorUpdateLinkInvalid => 'Update link is invalid.';

  @override
  String get errorNotOpenUpdateLink => 'Could not open update link.';

  @override
  String get errorTimeout => 'The request timed out.';

  @override
  String get errorUnauthorized => 'You are not authorized.';

  @override
  String get errorServer => 'Server error occurred.';

  @override
  String get errorNetwork => 'Network error occurred.';

  @override
  String get errorParsing => 'Failed to process data.';

  @override
  String get errorUnknown => 'An unknown error occurred.';

  @override
  String get version => 'Version';
}
