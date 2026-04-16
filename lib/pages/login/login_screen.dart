import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/core/constants/app_routes.dart';
import 'package:elevate_portal_flutter/pages/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/util_model.dart';
import '../../data/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginService _loginService = LoginService();

  BrandingModel? _branding;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadBranding();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadBranding() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    final brandingString = prefs.getString('branding');

    if (brandingString != null) {
      final brandingData = BrandingModel.fromJson(
        jsonDecode(brandingString) as Map<String, dynamic>,
      );
      setState(() {
        _branding = brandingData;
        _isLoading = false;
      });
      return;
    }

    await _fetchBranding();
  }

  Future<void> _fetchBranding() async {
    try {
      final branding = await _loginService.fetchBranding();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('branding', jsonEncode(branding.toJson()));

      setState(() {
        _branding = branding;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching branding: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _loginService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      setState(() => _isLoading = false);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Widget _buildBrandLogo() {
    final logoUrl = _branding?.logo.trim() ?? '';

    if (logoUrl.isNotEmpty && Uri.tryParse(logoUrl)?.hasAbsolutePath == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.network(
          logoUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildFallbackLogo(),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Container(
              width: 110,
              height: 110,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF132431),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2.4),
              ),
            );
          },
        ),
      );
    }

    return _buildFallbackLogo();
  }

  Widget _buildFallbackLogo() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        'assets/images/SG_Logo.jpg',
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Color(0xFF5F616A),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: const Color(0xFFF3F1F8),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 22,
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF7A4AE0), width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.redAccent),
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
            colors: [
              Colors.white,
              bgTint,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 36),
                      if (_isLoading && _branding == null)
                        const Padding(
                          padding: EdgeInsets.only(bottom: 48),
                          child: CircularProgressIndicator(),
                        )
                      else
                        _buildBrandLogo(),
                      const SizedBox(height: 56),
                      Container(
                        padding: const EdgeInsets.fromLTRB(26, 34, 26, 30),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.96),
                          borderRadius: BorderRadius.circular(42),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.10),
                              blurRadius: 34,
                              offset: const Offset(0, 18),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: _inputDecoration(
                                hintText: 'EMAIL_OR_MOBILE'.tr(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'ENTER_EMAIL_OR_MOBILE'.tr();
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: _inputDecoration(
                                hintText: 'PASSWORD'.tr(),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: const Color(0xFF5C5D64),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'ENTER_PASSWORD'.tr();
                                }
                                return null;
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.forgotPassword,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 18,
                                  ),
                                  foregroundColor: primary,
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: Text('FORGOT_PASSWORD_QUESTION'.tr()),
                              ),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                  colors: [primary, secondary],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: primary.withValues(alpha: 0.18),
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
                                        onPressed: _login,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: Text(
                                          'LOGIN'.tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
