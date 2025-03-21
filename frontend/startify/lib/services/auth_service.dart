import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String baseUrl = "http://79.124.76.138/api";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Login failed");
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String username,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
        "username": username,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Account creation failed');
    }
  }

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
