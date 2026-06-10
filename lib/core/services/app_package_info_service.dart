import 'package:package_info_plus/package_info_plus.dart';

class AppPackageInfo {
  final String appName;
  final String packageName;
  final String version;
  final int buildNumber;

  const AppPackageInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  String get displayVersion => '$version+$buildNumber';
}

class AppPackageInfoService {
  Future<AppPackageInfo> getPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return AppPackageInfo(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: int.tryParse(packageInfo.buildNumber) ?? 0,
    );
  }
}
