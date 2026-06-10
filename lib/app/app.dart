import 'package:b2b_mobile_app/core/l10n/arb/app_localizations.dart';
import 'package:b2b_mobile_app/core/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../features/startup/presentation/providers/app_theme_provider.dart';
import '../features/startup/presentation/screens/splash_screen.dart';


class B2BApp extends StatelessWidget {
  const B2BApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final locale = context.watch<AppLocaleProvider>().locale;
    final themeMode = context.watch<AppThemeProvider>().mode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      supportedLocales: L10n.supportedLocales,
      locale: null,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xFFFFC93C),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFFFFC93C),
      ),
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
