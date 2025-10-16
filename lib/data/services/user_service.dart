import 'dart:convert';

import 'package:elevate_portal_flutter/core/constants/api_endpoints.dart';
import 'package:elevate_portal_flutter/data/services/api_service.dart';

class UserService {
  final ApiService _api = ApiService();


  readHomeListForm() async {
    final response = await _api.get(ApiEndpoints.readHomeList);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body);
      return json;
    } else {
      throw Exception("Failed to fetch home list: ${response.statusCode}");
    }
  }
}