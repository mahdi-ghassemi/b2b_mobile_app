// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سوق B2B';

  @override
  String get welcomeTitle => 'مرحباً بكم في سوق B2B';

  @override
  String get welcomeSubtitle => 'تطبيق تجارة الجملة B2B';

  @override
  String get updateRequired => 'التحديث مطلوب';

  @override
  String get updateTitle =>
      'يتوفر إصدار جديد من التطبيق. يرجى التحديث للمتابعة.';

  @override
  String get mobileNumber => 'رقم الهاتف المحمول';

  @override
  String get current => 'الحالي';

  @override
  String get required => 'مطلوب';

  @override
  String get updateNow => 'تحديث الآن';

  @override
  String get updateNotAvailable =>
      'رابط التحديث غير متوفر. يرجى الاتصال بالدعم.';

  @override
  String get updateLinkIsInvalid => 'رابط التحديث غير صالح.';

  @override
  String get notOpenUpdateLink => 'تعذر فتح رابط التحديث.';

  @override
  String get unableStartApplication => 'تعذر بدء التطبيق';

  @override
  String get tryAgain => 'حاول مجدداً';

  @override
  String get sendCode => 'إرسال الرمز';

  @override
  String get verifyCode => 'التحقق من الرمز';

  @override
  String get enter6digitCode => 'أدخل الرمز المكون من 6 أرقام';

  @override
  String get confirm => 'تأكيد';

  @override
  String get searchProduct => 'البحث عن منتج';

  @override
  String get mainCategories => 'الفئات الرئيسية';

  @override
  String get welcomeTaglineTitle => 'سوق B2B للمنطقة العالمية';

  @override
  String get welcomeTaglineSubtitle =>
      'ربط تجار الجملة وتجار التجزئة عبر المدن.';

  @override
  String get errorApplicationStartupFailed => 'فشل بدء تشغيل التطبيق.';

  @override
  String get errorUpdateLinkInvalid => 'رابط التحديث غير صالح.';

  @override
  String get errorNotOpenUpdateLink => 'تعذر فتح رابط التحديث.';

  @override
  String get errorTimeout => 'انتهت مهلة الطلب ولم يتم الرد.';

  @override
  String get errorUnauthorized => 'ليس لديك الصلاحية الكافية للوصول.';

  @override
  String get errorServer => 'حدث خطأ في الخادم (Server Error).';

  @override
  String get errorNetwork => 'يرجى التحقق من الاتصال، حدث خطأ في الشبكة.';

  @override
  String get errorParsing => 'فشل في معالجة وتحليل البيانات.';

  @override
  String get errorUnknown => 'حدث خطأ غير معروف، يرجى المحاولة مرة أخرى.';

  @override
  String get version => 'إصدار';
}
