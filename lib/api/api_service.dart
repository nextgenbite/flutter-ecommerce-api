import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://ecomapi.nextgenbite.com/public/api/homepage';

  // static Future<HomepageModel> fetchHomepageData() async {
  //   final response = await http.get(Uri.parse(_baseUrl));

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body)['data'];
  //     return HomepageModel.fromJson(data);
  //   } else {
  //     throw Exception("Failed to load homepage data");
  //   }
  // }

  static Future<Map<String, dynamic>> fetchHomepageData() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data; // Returning the raw map to be processed in the provider
    } else {
      throw Exception("Failed to load homepage data");
    }
  }
}
