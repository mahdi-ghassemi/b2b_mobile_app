// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'B2B Pazaryeri';

  @override
  String get welcomeTitle => 'B2B Pazaryerine Hoş Geldiniz';

  @override
  String get welcomeSubtitle => 'Toptan satış B2B uygulaması';

  @override
  String get updateRequired => 'Güncelleme Gerekli';

  @override
  String get updateTitle =>
      'Uygulamanın yeni bir sürümü mevcut. Devam etmek için lütfen güncelleyin.';

  @override
  String get mobileNumber => 'Cep telefonu numarası';

  @override
  String get current => 'Mevcut';

  @override
  String get required => 'Zorunlu';

  @override
  String get updateNow => 'Şimdi Güncelle';

  @override
  String get updateNotAvailable =>
      'Güncelleme bağlantısı mevcut değil. Lütfen destek ile iletişime geçin.';

  @override
  String get updateLinkIsInvalid => 'Güncelleme bağlantısı geçersiz.';

  @override
  String get notOpenUpdateLink => 'Güncelleme bağlantısı açılamadı.';

  @override
  String get unableStartApplication => 'Uygulama başlatılamadı';

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String get sendCode => 'Kod gönder';

  @override
  String get verifyCode => 'Kodu doğrula';

  @override
  String get enter6digitCode => '6 haneli kodu girin';

  @override
  String get confirm => 'Onayla';

  @override
  String get searchProduct => 'Ürün ara';

  @override
  String get mainCategories => 'Ana kategoriler';

  @override
  String get welcomeTaglineTitle => 'Küresel bölge için B2B pazaryeri';

  @override
  String get welcomeTaglineSubtitle =>
      'Şehirler arası toptancıları ve perakendecileri birbirine bağlayın.';

  @override
  String get errorApplicationStartupFailed => 'Uygulama başlatılamadı.';

  @override
  String get errorUpdateLinkInvalid => 'Güncelleme bağlantısı geçersiz.';

  @override
  String get errorNotOpenUpdateLink => 'Güncelleme bağlantısı açılamadı.';

  @override
  String get errorTimeout => 'İstek zaman aşımına uğradı.';

  @override
  String get errorUnauthorized => 'Bu işlem için yetkiniz bulunmamaktadır.';

  @override
  String get errorServer => 'Sunucu hatası oluştu.';

  @override
  String get errorNetwork =>
      'Bağlantı hatası oluştu. Lütfen internetinizi kontrol edin.';

  @override
  String get errorParsing => 'Veri işleme ve analiz hatası.';

  @override
  String get errorUnknown =>
      'Bilinmeyen bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get version => 'Sürüm';
}
