//import 'package:b2b_mobile_app/screens/splash/splash.dart';
import 'package:b2b_mobile_app/app/theme_controller.dart';
import 'package:b2b_mobile_app/screens/home/main_home.dart';
import 'package:b2b_mobile_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import 'language_controller.dart';


class B2BApp extends StatelessWidget {
  const B2BApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([languageController, themeController]),
      builder: (_, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: languageController.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          themeMode: themeController.mode,

          home: const HomeScreen(),
        );
      },
    );
  }
}