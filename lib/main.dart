import 'package:elevate_portal_flutter/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading asset: $e");
  }
  runApp(const MyApp());
}