import 'package:b2b_mobile_app/core/errors/error_localizer.dart';
import 'package:b2b_mobile_app/core/l10n/arb/app_localizations.dart';
import 'package:b2b_mobile_app/features/home/presentation/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/startup_controller.dart';
import 'force_update_screen.dart';
import 'startup_error_screen.dart';
import '../utils/update_url_resolver.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  StartupController? _startupController;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startupController = context.read<StartupController>();
      _startupController!.addListener(_onStartupStateChanged);
      _startupController!.bootstrap();
    });
  }

  void _onStartupStateChanged() {
    if (!mounted || _hasNavigated || _startupController == null) {
      return;
    }

    final state = _startupController!.state;

    switch (state.status) {
      case StartupStatus.ready:
        _hasNavigated = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
        break;

      case StartupStatus.forceUpdate:
        final packageInfo = state.packageInfo;
        final settings = state.settings;

        if (packageInfo == null || settings == null) return;

        final updateUrl = UpdateUrlResolver.resolveFromExtra(settings.extra);

        _hasNavigated = true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ForceUpdateScreen(
              currentVersion: packageInfo.version,
              currentBuildNumber: packageInfo.buildNumber,
              requiredVersion: settings.release.currentVersion,
              requiredBuildNumber: settings.release.lastBuildNumber,
              updateUrl: updateUrl,
            ),
          ),
        );
        break;

      case StartupStatus.failure:
        _hasNavigated = true;
        final localizations = AppLocalizations.of(context)!;

        final message = state.exception != null
            ? ErrorLocalizer.localizeAppException(
          state.exception!,
          localizations,
        )
            : state.errorMessage?.trim().isNotEmpty == true
            ? state.errorMessage!
            : localizations.errorUnknown;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StartupErrorScreen(
              message: message,
            ),
          ),
        );
        break;

      case StartupStatus.initial:
      case StartupStatus.loading:
        break;
    }
  }

  @override
  void dispose() {
    _startupController?.removeListener(_onStartupStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
              const Color(0xFF1A1A1A),
              const Color(0xFF0F0F0F),
            ]
                : [
              const Color(0xFFFFF7D1),
              const Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Color(0xFFFFE45E),
                              Color(0xFFFFC93C),
                            ],
                            center: Alignment(0.0, -0.2),
                            radius: 0.9,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x55FFC93C),
                              blurRadius: 35,
                              spreadRadius: 4,
                              offset: Offset(0, 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        localizations.appTitle,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizations.welcomeSubtitle,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Consumer<StartupController>(
                  builder: (context, controller, _) {
                    final packageInfo = controller.state.packageInfo;

                    final versionText = packageInfo == null
                        ?  localizations.version
                        : '${localizations.version} ${packageInfo.displayVersion}';

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LinearProgressIndicator(
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(999),
                          backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFFFFC93C),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          versionText,
                          style: theme.textTheme.labelMedium?.copyWith(
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
