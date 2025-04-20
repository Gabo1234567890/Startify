import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StartupService {
  final String baseUrl = "http://10.0.2.2:8000";
  final storage = FlutterSecureStorage();

  Future<List<Map<String, dynamic>>> getMyStartups() async {
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception('Access token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/startups/my'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load startups");
    }
  }
}
