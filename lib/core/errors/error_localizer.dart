import 'package:b2b_mobile_app/core/l10n/arb/app_localizations.dart';

import 'app_exception.dart';

class ErrorLocalizer {
  static String localizeAppException(
      AppException exception,
      AppLocalizations l10n,
      ) {

    switch (exception.code) {
      case 'application_startup_failed':
        return l10n.errorApplicationStartupFailed;
      case 'update_link_invalid':
        return l10n.errorUpdateLinkInvalid;
      case 'not_open_update_link':
        return l10n.errorNotOpenUpdateLink;
      case 'request_timeout':
        return l10n.errorTimeout;
      case 'unauthorized':
        return l10n.errorUnauthorized;
      case 'server_error':
        return l10n.errorServer;
      case 'network_error':
        return l10n.errorNetwork;
      case 'parsing_error':
        return l10n.errorParsing;
    }


    if (exception is NetworkException) {
      return l10n.errorNetwork;
    }

    if (exception is TimeoutAppException) {
      return l10n.errorTimeout;
    }

    if (exception is UnauthorizedException) {
      return l10n.errorUnauthorized;
    }

    if (exception is ServerException) {
      return l10n.errorServer;
    }

    if (exception is ParsingException) {
      return l10n.errorParsing;
    }

    //fallback: message
    if (exception.message != null && exception.message!.trim().isNotEmpty) {
      return exception.message!;
    }

    //fallback نهایی
    return l10n.errorUnknown;
  }
}
