import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/config/app_environment.dart';
import '../core/network/api_client.dart';
import '../core/services/app_package_info_service.dart';
import '../features/startup/data/datasources/system_remote_data_source.dart';
import '../features/startup/data/repositories/system_settings_repository_impl.dart';
import '../features/startup/domain/repositories/system_settings_repository.dart';
import '../features/startup/presentation/providers/app_config_provider.dart';
import '../features/startup/presentation/providers/app_locale_provider.dart';
import '../features/startup/presentation/providers/app_theme_provider.dart';
import '../features/startup/presentation/providers/startup_controller.dart';

class AppProviders extends StatelessWidget {
  final SharedPreferences preferences;
  final Widget child;

  const AppProviders({
    super.key,
    required this.preferences,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(
          create: (_) => http.Client(),
          dispose: (_, client) => client.close(),
        ),
        Provider<AppEnvironment>.value(
          value: AppEnvironment.current,
        ),
        Provider<ApiClient>(
          create: (context) => ApiClient(
            httpClient: context.read<http.Client>(),
            environment: context.read<AppEnvironment>(),
          ),
        ),
        Provider<AppPackageInfoService>(
          create: (_) => AppPackageInfoService(),
        ),
        Provider<SystemRemoteDataSource>(
          create: (context) => SystemRemoteDataSourceImpl(
            apiClient: context.read<ApiClient>(),
          ),
        ),
        Provider<SystemSettingsRepository>(
          create: (context) => SystemSettingsRepositoryImpl(
            remoteDataSource: context.read<SystemRemoteDataSource>(),
          ),
        ),
        ChangeNotifierProvider<AppConfigProvider>(
          create: (_) => AppConfigProvider(),
        ),
        ChangeNotifierProvider<AppLocaleProvider>(
          create: (_) => AppLocaleProvider(
            preferences: preferences,
          ),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(
            preferences: preferences,
          ),
        ),
        ChangeNotifierProvider<StartupController>(
          create: (context) => StartupController(
            packageInfoService: context.read<AppPackageInfoService>(),
            systemSettingsRepository: context.read<SystemSettingsRepository>(),
            appConfigProvider: context.read<AppConfigProvider>(),
            appLocaleProvider: context.read<AppLocaleProvider>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
