import 'package:elevate_portal_flutter/core/constants/app_colors.dart';
import 'package:elevate_portal_flutter/core/constants/app_routes.dart';
import 'package:elevate_portal_flutter/pages/home/home_screen.dart';
import 'package:elevate_portal_flutter/pages/login/login_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final bool isLoggedIn = false;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to shikshagraha',
     theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
      routes:  {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
      },

    );
  }
}