import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/config.dart';
import '../models/shipping_cost.dart';

class ShippingCostApi {
  static const String baseUrl = "${Config.apiUrl}api";
  // Fetch cart

  Future<List<ShippingCost>> fetchShippingCost() async {
    final response = await http.get(
      Uri.parse('$baseUrl/public/shipping/cost'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ShippingCost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
