enum HomeMode {
  products,
  categories,
  empty;

  static HomeMode fromString(String? value) {
    switch (value) {
      case 'products':
        return HomeMode.products;
      case 'categories':
        return HomeMode.categories;
      case 'empty':
      default:
        return HomeMode.empty;
    }
  }

  String get value {
    switch (this) {
      case HomeMode.products:
        return 'products';
      case HomeMode.categories:
        return 'categories';
      case HomeMode.empty:
        return 'empty';
    }
  }
}

class SystemSettingsModel {
  final String appName;
  final CompanyModel company;
  final ReleaseModel release;
  final String serverTime;
  final String defaultLanguage;
  final HomeModel home;
  final Map<String, dynamic> extra;

  const SystemSettingsModel({
    required this.appName,
    required this.company,
    required this.release,
    required this.serverTime,
    required this.defaultLanguage,
    required this.home,
    required this.extra,
  });

  factory SystemSettingsModel.fromJson(Map<String, dynamic> json) {
    return SystemSettingsModel(
      appName: json['appName'] as String? ?? '',
      company: CompanyModel.fromJson(
        (json['company'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
      release: ReleaseModel.fromJson(
        (json['release'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
      serverTime: json['serverTime'] as String? ?? '',
      defaultLanguage: json['defaultLanguage'] as String? ?? 'en',
      home: HomeModel.fromJson(
        (json['home'] as Map<String, dynamic>?) ?? <String, dynamic>{},
      ),
      extra: (json['extra'] as Map<String, dynamic>?) ?? <String, dynamic>{},
    );
  }
}

class CompanyModel {
  final String name;
  final String email;
  final String phone;
  final String address;

  const CompanyModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
    );
  }
}

class ReleaseModel {
  final String currentVersion;
  final int lastBuildNumber;

  const ReleaseModel({
    required this.currentVersion,
    required this.lastBuildNumber,
  });

  factory ReleaseModel.fromJson(Map<String, dynamic> json) {
    return ReleaseModel(
      currentVersion: json['currentVersion'] as String? ?? '',
      lastBuildNumber: (json['lastBuildNumber'] as num?)?.toInt() ?? 0,
    );
  }
}

class HomeModel {
  final HomeMode mode;
  final bool hasHomeProducts;

  const HomeModel({
    required this.mode,
    required this.hasHomeProducts,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      mode: HomeMode.fromString(json['mode'] as String?),
      hasHomeProducts: json['hasHomeProducts'] as bool? ?? false,
    );
  }
}