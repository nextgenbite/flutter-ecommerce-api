import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/shipping_cost.dart';

class ShippingCostApi {
  static const String baseUrl = 'http://ecomapi.nextgenbite.com/public/api';

  // Fetch cart
  // static Future<ShippingCost?> fetchShippingCost() async {
  //   final response = await http.get(
  //     Uri.parse("$baseUrl/public/shipping/cost"),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     return ShippingCost.fromJson(jsonDecode(response.body));
  //   }
  //   return null;
  // }

  Future<List<ShippingCost>> fetchShippingCost() async {
    final response = await http.get(
      Uri.parse('$baseUrl/public/shipping/cost'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // print(data);
      return data.map((json) => ShippingCost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
