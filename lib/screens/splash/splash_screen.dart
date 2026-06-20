import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spacenews_core/core/routes/app_routes.dart';
import 'package:spacenews_core/services/shared_pref_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _primary = Color(0xFF0F172A);
  static const _secondary = Color(0xFF2563EB);
  static const _accent = Color(0xFF38BDF8);

  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start fade-in animation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _opacity = 1.0);
      }
    });
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final isLoggedIn = await SharedPrefService().isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.register);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo container with gradient
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [_secondary, _accent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _secondary.withOpacity(0.4),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.rocket_launch,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // App name
                  const Text(
                    'SpaceNews',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'CORE',
                    style: TextStyle(
                      color: _accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const SpinKitThreeBounce(
              color: _accent,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
