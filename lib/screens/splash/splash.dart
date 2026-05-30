import 'package:b2b_mobile_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:b2b_mobile_app/l10n/app_localizations.dart';


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

    Future.delayed(const Duration(milliseconds: 2600), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
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
              const Color(0xFFFFF7D1), // soft yellow
              const Color(0xFFFFFFFF), // white
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Center sun + texts
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
                      // Sun circle
                      Container(
                        width: 160,
                        height: 160,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Color(0xFFFFE45E), // bright sun yellow
                              Color(0xFFFFC93C), // deeper yellow
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
                        t.appName, // "KuriHub" از ARB
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        t.welcomeSubtitle, // فعلاً از همون welcomeSubtitle استفاده می‌کنیم
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom progress indicator
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(
                      minHeight: 3,
                      borderRadius: BorderRadius.circular(999),
                      backgroundColor: theme.colorScheme.surface.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFFFFC93C),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      t.appName,
                      style: theme.textTheme.labelMedium?.copyWith(
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}