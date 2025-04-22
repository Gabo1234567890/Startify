import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatService {
  final storage = FlutterSecureStorage();
  final String baseUrl = "http://10.0.2.2:8000";

  Future<String?> _getToken() async {
    return await storage.read(key: "access_token");
  }

  Future<List<Map<String, dynamic>>> getChats({String search = ""}) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/chats?search=$search"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load chats: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> createChat(String userId) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/chats"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({"user_id": userId}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to create chat: ${response.body}");
    }
  }

  Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse("$baseUrl/chats/$chatId/messages"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Failed to load messages: ${response.body}");
    }
  }

  Future<Map<String, dynamic>> sendMessage(
    String chatId,
    String content,
  ) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse("$baseUrl/chats/$chatId/messages"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: json.encode({"chat_id": chatId, "content": content}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("Failed to send message: ${response.body}");
    }
  }
}
