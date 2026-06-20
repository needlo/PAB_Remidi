import 'package:flutter/material.dart';
import 'package:spacenews_core/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _secondary = Color(0xFF2563EB);
  static const _accent = Color(0xFF38BDF8);
  static const _textPrimary = Color(0xFF111827);
  static const _textSecondary = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 2),
                _buildContent(),
                const Spacer(flex: 1),
                _buildButton(context),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Globe icon with accent circle
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: _accent.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.public,
            color: _secondary,
            size: 120,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Welcome to SpaceNews\nCore Application',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w800,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Your Gateway to International\nSpace Exploration News',
          style: TextStyle(
            color: _textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomButton(
      text: 'Get Started',
      icon: Icons.arrow_forward,
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/home');
      },
    );
  }
}
