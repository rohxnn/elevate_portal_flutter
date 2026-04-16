import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/core/constants/app_routes.dart';
import 'package:elevate_portal_flutter/data/services/login_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final LoginService _loginService = LoginService();

  bool _isLoading = false;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> forgotPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _loginService.resetPassword(
        _emailController.text.trim(),
        _newPasswordController.text,
      );

      if (!mounted) return;

      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, AppRoutes.resetOtp, arguments: {
        'identifier': _emailController.text.trim(),
        'password': _newPasswordController.text,
        'resendOtp': forgotPassword,
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('RESET_FAILED_TRY_AGAIN'.tr())),
      );
    }
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFFA6A1AF),
        fontSize: 17,
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF6F6A78), size: 21),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: const Color(0xFFF3F1F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFF7A4AE0), width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF484652),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primary = AppColors.primary;
    final secondary = AppColors.secondary;
    final bgTint = AppColors.background;

    return Scaffold(
      backgroundColor: bgTint,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, bgTint, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).maybePop(),
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'RESET_PASSWORD'.tr(),
                          style: TextStyle(
                            color: primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 56),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.96),
                        borderRadius: BorderRadius.circular(36),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withValues(alpha: 0.10),
                            blurRadius: 34,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 6,
                            margin: const EdgeInsets.only(top: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              gradient: LinearGradient(
                                colors: [
                                  primary,
                                  Color.lerp(primary, secondary, 0.5) ?? primary,
                                  secondary,
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 28, 24, 26),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildLabel('EMAIL_MOBILE_USERNAME'.tr()),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: _inputDecoration(
                                      hintText: 'EMAIL_USERNAME_HINT'.tr(),
                                      prefixIcon: Icons.person,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'ENTER_EMAIL_MOBILE_USERNAME'
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 22),
                                  _buildLabel('NEW_PASSWORD'.tr()),
                                  TextFormField(
                                    controller: _newPasswordController,
                                    obscureText: _obscureNewPassword,
                                    decoration: _inputDecoration(
                                      hintText: 'MIN_8_CHARACTERS'.tr(),
                                      prefixIcon: Icons.lock,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureNewPassword =
                                                !_obscureNewPassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscureNewPassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: const Color(0xFF6F6A78),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'ENTER_NEW_PASSWORD'.tr();
                                      }
                                      if (value.length < 8) {
                                        return 'PASSWORD_MIN_8'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 22),
                                  _buildLabel('CONFIRM_PASSWORD'.tr()),
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: _obscureConfirmPassword,
                                    decoration: _inputDecoration(
                                      hintText: 'REPEAT_NEW_PASSWORD'.tr(),
                                      prefixIcon: Icons.lock_reset,
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureConfirmPassword =
                                                !_obscureConfirmPassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscureConfirmPassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: const Color(0xFF6F6A78),
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'CONFIRM_NEW_PASSWORD'.tr();
                                      }
                                      if (value != _newPasswordController.text) {
                                        return 'PASSWORDS_DO_NOT_MATCH'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 40),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(999),
                                      gradient: LinearGradient(
                                        colors: [
                                          primary,
                                          Color.lerp(primary, secondary, 0.35) ??
                                              primary,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: primary.withValues(alpha: 0.28),
                                          blurRadius: 20,
                                          offset: const Offset(0, 12),
                                        ),
                                      ],
                                    ),
                                    child: SizedBox(
                                      height: 64,
                                      child: _isLoading
                                          ? const Center(
                                              child: SizedBox(
                                                width: 28,
                                                height: 28,
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2.6,
                                                ),
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: forgotPassword,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        999,
                                                      ),
                                                ),
                                              ),
                                              child: Text(
                                                'RESET_PASSWORD'.tr(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 36),
                                  const Divider(height: 1, color: Color(0xFFF0ECF6)),
                                  const SizedBox(height: 24),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 6,
                                    children: [
                                      Text(
                                        'REMEMBERED_PASSWORD'.tr(),
                                        style: TextStyle(
                                          color: Color(0xFF5F616A),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            AppRoutes.login,
                                          );
                                        },
                                        child: Text(
                                          'BACK_TO_LOGIN'.tr(),
                                          style: TextStyle(
                                            color: primary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
