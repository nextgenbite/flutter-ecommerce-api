import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/config.dart';

class OrderApi {
  static const String baseUrl = " ${Config.apiUrl}api";
  static Future<Map?> store(Map order) async {
    final response = await http.post(Uri.parse('$baseUrl/order'), body: order);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> submitOrder(
    Map<String, dynamic> orderData,
  ) async {
    final url = Uri.parse('$baseUrl/order');

    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json", // Ensure this header is set
          "Content-Type": "application/json",
        },

        body: json.encode(orderData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'message': 'Order placed successfully'};
      } else {
        return {'success': false, 'message': 'Failed to place order'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
