import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacenews_core/core/utils/helpers.dart';
import 'package:spacenews_core/providers/auth_provider.dart';
import 'package:spacenews_core/widgets/custom_button.dart';
import 'package:spacenews_core/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  static const _secondary = Color(0xFF2563EB);
  static const _accent = Color(0xFF38BDF8);
  static const _background = Color(0xFFF8FAFC);
  static const _textPrimary = Color(0xFF111827);
  static const _textSecondary = Color(0xFF6B7280);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.resetPassword(
      _emailController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Helpers.showSuccessSnackbar(
        context,
        'Password reset link sent! Check your email.',
      );
      Navigator.pop(context);
    } else {
      Helpers.showErrorSnackbar(
        context,
        authProvider.error ?? 'Failed to send reset link. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: _textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 32),
              _buildIcon(),
              const SizedBox(height: 32),
              const Text(
                'Reset Password',
                style: TextStyle(
                  color: _textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Enter your email to receive a password reset link',
                  style: TextStyle(
                    color: _textSecondary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 36),
              _buildForm(authProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: _accent.withOpacity(0.12),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.lock_reset,
        color: _secondary,
        size: 44,
      ),
    );
  }

  Widget _buildForm(AuthProvider authProvider) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email address',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value.trim())) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 28),
          CustomButton(
            text: 'Send Reset Link',
            onPressed: _handleResetPassword,
            isLoading: authProvider.isLoading,
            icon: Icons.send_rounded,
          ),
        ],
      ),
    );
  }
}
