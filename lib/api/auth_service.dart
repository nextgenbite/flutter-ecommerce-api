import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/config.dart';

class AuthService {
  static const String baseUrl = " ${Config.apiUrl}api";

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['token']; // Save this token for future API calls
    } else {
      return null;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: {'name': name, 'email': email, 'password': password},
    );

    return response.statusCode == 200;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  /// Fetch stored authentication token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Fetch user data using the stored authentication token
  Future<Map<String, dynamic>?> getUser() async {
    String? token = await getToken(); // Get token from SharedPreferences

    if (token == null) {
      return null; // User is not logged in
    }

    final response = await http.get(
      Uri.parse('$baseUrl/user'), // Laravel Sanctum authenticated route
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return user data
    } else if (response.statusCode == 401) {
      // Token is expired or invalid
      await logout(); // Clear expired token
      return null; // Redirect user to login
    } else {
      return null; // Handle other errors
    }
  }

  /// Logout user by removing token from SharedPreferences
  Future<void> logout() async {
    String? token = await getToken();
    if (token == null) return;

    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token'); // Clear token
  }
}
