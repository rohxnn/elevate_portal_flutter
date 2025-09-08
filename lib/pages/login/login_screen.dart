import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/services/login_service.dart';
import '../../data/models/util_model.dart';

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
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadBranding();
    _checkLoginStatus();
  }
Future<void> _loadBranding() async {
  setState(() => _isLoading = true);
  final prefs = await SharedPreferences.getInstance();
  final brandingString = prefs.getString('branding');

  if (brandingString != null) {
    final brandingData = BrandingModel.fromJson(jsonDecode(brandingString));
    setState(() {
      _branding = brandingData;
      _isLoading = false;
    });
  } else {
    await _fetchBranding();
  }
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
    print('Error fetching branding: $e');
    setState(() => _isLoading = false);
  }
}
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _loginService.login(
        _emailController.text,
        _passwordController.text,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);

      setState(() {
        _isLoggedIn = true;
        _isLoading = false;
      });

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed, please try again')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_isLoading && _branding == null)
                  const CircularProgressIndicator()
                else if (_branding != null)
                  Image.network(_branding!.logo, height: 150,fit: BoxFit.contain,)
                else
                  const SizedBox(height: 150),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email or Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter your email or mobile number' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter your password' : null,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
