import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
    static String get publicBaseUrl => dotenv.env['NEXT_PUBLIC_BASE_URL'] ?? '';
}