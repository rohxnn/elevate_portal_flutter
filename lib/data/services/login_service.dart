import 'dart:convert';

import 'package:elevate_portal_flutter/core/config/env.dart';
import 'package:elevate_portal_flutter/core/constants/api_endpoints.dart';
import 'package:elevate_portal_flutter/data/models/util_model.dart';
import 'package:http/http.dart' as http;

class LoginService {  
  Future<BrandingModel> fetchBranding() async {
    final origin = Env.publicBaseUrl;

    final response = await http.get(
      Uri.parse(ApiEndpoints.tenantRead),
      headers: { "origin": origin ?? "" },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return BrandingModel.fromJson(json['result']);
    } else {
      throw Exception("Failed to fetch branding: ${response.statusCode}");
    }
  }

 Future<void> login(String username, String password) async {
  final apiUrl = Uri.parse(ApiEndpoints.accountLogin);

  final isMobile = RegExp(r'^[6-9]\d{9}$').hasMatch(username);

  final requestBody = {
    "identifier": username,
    "password": password,
    if (isMobile) "phone_code": "+91", 
  };

  try {
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      
      return data;
    } else {
      throw Exception("${data?['message']}");
    }
  } catch (e) {
    print("Login error: $e");
    rethrow;
  }
}

Future<void> ResetPassword(String identifier, String password) async {
  final apiUrl = Uri.parse(ApiEndpoints.sendForgetOtp);

  final requestBody = {
    "identifier": identifier,
    "password": password,
  };

  try {
    final response = await http.post(
      apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Failed to reset password: ${response.statusCode}");
    }
  } catch (e) {
    print("Reset password error: $e");
    rethrow;
  }
  }

}
