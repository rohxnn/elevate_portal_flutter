import 'package:easy_localization/easy_localization.dart';
import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/core/constants/app_routes.dart';
import 'package:elevate_portal_flutter/data/services/api_service.dart';
import 'package:elevate_portal_flutter/pages/forgot_password/forgot_password_screen.dart';
import 'package:elevate_portal_flutter/pages/login/login_screen.dart';
import 'package:elevate_portal_flutter/pages/main_screen/main_screen.dart';
import 'package:elevate_portal_flutter/pages/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;
  final ApiService _apiService = ApiService();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    ApiService.navigatorKey = navigatorKey;
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final storedLoginState = prefs.getBool('is_logged_in');
    final token = await _apiService.getToken();

    setState(() {
      isLoggedIn = storedLoginState ?? token != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Welcome to shikshagraha',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      home: isLoggedIn == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : isLoggedIn!
          ? const MainScreen()
          : const LoginScreen(),
      routes: {
        AppRoutes.home: (context) => const MainScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.resetOtp: (context) =>
            OtpScreen(identifier: null, password: null, resendOtp: () {}),
      },
    );
  }
}
