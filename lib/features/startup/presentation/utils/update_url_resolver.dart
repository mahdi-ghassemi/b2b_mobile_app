import 'dart:io';

class UpdateUrlResolver {
  static String? resolveFromExtra(Map<String, dynamic> extra) {
    // Expected keys:
    // androidUpdateUrl, iosUpdateUrl
    if (Platform.isAndroid) {
      final v = extra['androidUpdateUrl'];
      return (v is String && v.trim().isNotEmpty) ? v.trim() : null;
    }

    if (Platform.isIOS) {
      final v = extra['iosUpdateUrl'];
      return (v is String && v.trim().isNotEmpty) ? v.trim() : null;
    }

    return null;
  }
}
