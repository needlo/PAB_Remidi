import 'package:flutter/material.dart';
import 'package:spacenews_core/screens/splash/splash_screen.dart';
import 'package:spacenews_core/screens/auth/login_screen.dart';
import 'package:spacenews_core/screens/auth/register_screen.dart';
import 'package:spacenews_core/screens/auth/forgot_password_screen.dart';
import 'package:spacenews_core/screens/welcome/welcome_screen.dart';
import 'package:spacenews_core/screens/home/home_screen.dart';
import 'package:spacenews_core/screens/detail/detail_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String detail = '/detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _fadeRoute(settings, const SplashScreen());
      case login:
        return _slideRoute(settings, const LoginScreen());
      case register:
        return _slideRoute(settings, const RegisterScreen());
      case forgotPassword:
        return _slideRoute(settings, const ForgotPasswordScreen());
      case welcome:
        return _fadeRoute(settings, const WelcomeScreen());
      case home:
        return _fadeRoute(settings, const HomeScreen());
      case detail:
        return _fadeRoute(settings, const DetailScreen());
      default:
        return _fadeRoute(settings, const _NotFoundPage());
    }
  }

  static Route<dynamic> _slideRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static Route<dynamic> _fadeRoute(RouteSettings settings, Widget page) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation.drive(
            Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: Curves.easeInOut),
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
