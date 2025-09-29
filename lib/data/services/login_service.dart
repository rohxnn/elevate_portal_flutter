import 'dart:convert';
import 'package:elevate_portal_flutter/core/config/env.dart';
import 'package:elevate_portal_flutter/core/constants/api_endpoints.dart';
import 'package:elevate_portal_flutter/data/models/util_model.dart';
import 'api_service.dart'; // import the centralized service

class LoginService {
  final ApiService _api = ApiService();

  Future<BrandingModel> fetchBranding() async {
    final response = await _api.get(ApiEndpoints.tenantRead);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return BrandingModel.fromJson(json['result']);
    } else {
      throw Exception("Failed to fetch branding: ${response.statusCode}");
    }
  }

  Future<void> login(String username, String password) async {
    final isMobile = RegExp(r'^[6-9]\d{9}$').hasMatch(username);

    final requestBody = {
      "identifier": username,
      "password": password,
      if (isMobile) "phone_code": "+91",
    };

    try {
      final response = await _api.post(ApiEndpoints.accountLogin, requestBody);
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

  Future<void> resetPassword(String identifier, String password) async {
    final requestBody = {
      "identifier": identifier,
      "password": password,
    };

    try {
      final response = await _api.post(ApiEndpoints.sendForgetOtp, requestBody);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
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
