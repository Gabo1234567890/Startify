import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final String baseUrl = "http://10.0.2.2:8000";
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(
    String username,
    String email,
    String password,
  ) async {
    final url = Uri.parse("$baseUrl/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      login(email, password);
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to register: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data["access_token"];
      await storage.write(key: "access_token", value: accessToken);
      return data;
    } else {
      throw Exception("Failed to login: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final token = await storage.read(key: "access_token");
    if (token == null) {
      return {"username": "", "email": "", "bio": ""};
    }
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load profile: ${response.body}");
    }
  }

  Future<void> updateProfile({required String bio}) async {
    final token = await storage.read(key: "access_token");
    final response = await http.put(
      Uri.parse("$baseUrl/me"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"bio": bio}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update profile: ${response.body}");
    }
  }

  Future<List<Map<String, dynamic>>> getUsers({
    int skip = 0,
    int limit = 10,
    String search = "",
  }) async {
    final url = Uri.parse(
      "$baseUrl/users?skip=$skip&limit=$limit&search=$search",
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      final loggedInUser = await getProfile();
      if (loggedInUser["username"] != "") {
        data =
            data
                .where((user) => user['username'] != loggedInUser['username'])
                .toList();
      }
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
