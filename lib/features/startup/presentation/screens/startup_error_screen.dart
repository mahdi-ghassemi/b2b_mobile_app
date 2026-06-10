
import 'package:b2b_mobile_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/startup_controller.dart';
import 'splash_screen.dart';

class StartupErrorScreen extends StatelessWidget {
  final String message;

  const StartupErrorScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 88,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 20),
                Text(
                  localizations.unableStartApplication,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<StartupController>().reset();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SplashScreen(),
                        ),
                      );
                    },
                    child: Text(localizations.tryAgain),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
