import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_service.dart';

class StartupService {
  final String baseUrl = "http://10.0.2.2:8000";
  final storage = FlutterSecureStorage();

  Future<List<Map<String, dynamic>>> getMyStartups({String search = ""}) async {
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception('Access token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/startups/my?search=$search'),
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

  Future<List<Map<String, dynamic>>> getStartups({
    int skip = 0,
    int limit = 10,
    String search = "",
  }) async {
    final url = Uri.parse(
      "$baseUrl/startups?skip=$skip&limit=$limit&search=$search",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      final loggedInUser = await AuthService().getProfile();
      if (loggedInUser["username"] != "") {
        data =
            data
                .where((startup) => startup['user_id'] != loggedInUser['id'])
                .toList();
      }
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load startups');
    }
  }

  Future<void> createStartup({
    required String name,
    required String description,
    required int goalAmount,
  }) async {
    final token = await storage.read(key: 'access_token');

    if (token == null) {
      throw Exception('Access token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/startups'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "description": description,
        "goal_amount": goalAmount,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to create startup ${response.body}");
    }
  }

  Future<Map<String, dynamic>> getStartup({required String startupId}) async {
    final response = await http.get(Uri.parse("$baseUrl/startups/$startupId"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get startup ${response.body}");
    }
  }
}
