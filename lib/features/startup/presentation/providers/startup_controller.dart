import 'package:flutter/foundation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/services/app_package_info_service.dart';
import '../../data/models/system_settings_model.dart';
import '../../domain/repositories/system_settings_repository.dart';
import 'app_config_provider.dart';
import 'app_locale_provider.dart';

enum StartupStatus {
  initial,
  loading,
  ready,
  forceUpdate,
  failure,
}

class StartupState {
  final StartupStatus status;
  final AppPackageInfo? packageInfo;
  final SystemSettingsModel? settings;


  final String? errorMessage;


  final AppException? exception;

  const StartupState({
    required this.status,
    this.packageInfo,
    this.settings,
    this.errorMessage,
    this.exception,
  });

  const StartupState.initial()
      : status = StartupStatus.initial,
        packageInfo = null,
        settings = null,
        errorMessage = null,
        exception = null;

  StartupState copyWith({
    StartupStatus? status,
    AppPackageInfo? packageInfo,
    SystemSettingsModel? settings,
    String? errorMessage,
    AppException? exception,
    bool clearError = false,
  }) {
    return StartupState(
      status: status ?? this.status,
      packageInfo: packageInfo ?? this.packageInfo,
      settings: settings ?? this.settings,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      exception: clearError ? null : exception ?? this.exception,
    );
  }
}

class StartupController extends ChangeNotifier {
  final AppPackageInfoService packageInfoService;
  final SystemSettingsRepository systemSettingsRepository;
  final AppConfigProvider appConfigProvider;
  final AppLocaleProvider appLocaleProvider;

  StartupState _state = const StartupState.initial();
  bool _isBootstrapping = false;

  StartupController({
    required this.packageInfoService,
    required this.systemSettingsRepository,
    required this.appConfigProvider,
    required this.appLocaleProvider,
  });

  StartupState get state => _state;

  Future<void> bootstrap({bool force = false}) async {
    if (_isBootstrapping && !force) {
      return;
    }

    _isBootstrapping = true;

    AppPackageInfo? packageInfo;

    try {
      _emit(
        const StartupState(
          status: StartupStatus.loading,
        ),
      );

      packageInfo = await packageInfoService.getPackageInfo();

      _emit(
        StartupState(
          status: StartupStatus.loading,
          packageInfo: packageInfo,
        ),
      );

      final settings = await systemSettingsRepository.fetchSystemSettings();

      appConfigProvider.setSettings(settings);

      await appLocaleProvider.applyServerDefaultIfNeeded(
        settings.defaultLanguage,
      );

      if (settings.release.lastBuildNumber > packageInfo.buildNumber) {
        _emit(
          StartupState(
            status: StartupStatus.forceUpdate,
            packageInfo: packageInfo,
            settings: settings,
          ),
        );
        return;
      }

      _emit(
        StartupState(
          status: StartupStatus.ready,
          packageInfo: packageInfo,
          settings: settings,
        ),
      );
    } on AppException catch (e) {
      _emit(
        StartupState(
          status: StartupStatus.failure,
          packageInfo: packageInfo,
          errorMessage: e.message,
          exception: e,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('Unexpected startup error: $e');
      debugPrintStack(stackTrace: stackTrace);

      _emit(
        StartupState(
          status: StartupStatus.failure,
          packageInfo: packageInfo,
          errorMessage: null,
          exception: null,
        ),
      );
    } finally {
      _isBootstrapping = false;
    }
  }

  void reset() {
    _emit(const StartupState.initial());
  }

  void _emit(StartupState state) {
    _state = state;
    notifyListeners();
  }
}
