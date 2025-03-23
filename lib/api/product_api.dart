import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductApi {
  // static const String baseUrl = 'https://dummyjson.com/';
  static const String baseUrl = 'https://ecomapi.nextgenbite.com/api/';

  // Future<List<Product>> fetchProducts() async {
  //   final response = await http.get(Uri.parse(baseUrl + 'new/products'));
  //   // print(json.decode(response.body));
  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     print('ok');
  //     // List<dynamic> data = json.decode(response.body);
  //     return data.map((productJson) => Product.fromJson(productJson)).toList();
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('${baseUrl}new/products'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      // print(data);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
