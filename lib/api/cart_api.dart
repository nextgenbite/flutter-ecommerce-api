import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart.dart';

class CartApi {
  static const String baseUrl = 'http://ecomapi.nextgenbite.com/public/api';
  // static const String baseUrl = 'http://ecomerce_lara_nuxt.test/api';

  static Future<String> _getGuestId() async {
    final prefs = await SharedPreferences.getInstance();
    String? guestId = prefs.getString('guest_id');

    if (guestId == null) {
      guestId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString('guest_id', guestId);
    }
    return guestId;
  }

  // Fetch cart
  static Future<Cart?> fetchCart() async {
    String guestId = await _getGuestId();
    final response = await http.get(
      Uri.parse("$baseUrl/cart"),
      headers: {'Guest-Id': guestId, 'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }

  // Add item to cart
  static Future<Cart?> addToCart(int productId, int quantity) async {
    String guestId = await _getGuestId();
    final response = await http.post(
      Uri.parse("$baseUrl/cart/add"),
      headers: {'Guest-Id': guestId, 'Content-Type': 'application/json'},
      body: jsonEncode({"product_id": productId, "quantity": quantity}),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }

  // Increment item quantity
  static Future<Cart?> incrementItem(int productId) async {
    String guestId = await _getGuestId();

    final response = await http.post(
      Uri.parse("$baseUrl/cart/increment"),
      headers: {"Content-Type": "application/json", "Guest-Id": guestId},
      body: jsonEncode({"product_id": productId}),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }

  // Decrement item quantity
  static Future<Cart?> decrementItem(int productId) async {
    String guestId = await _getGuestId();

    final response = await http.post(
      Uri.parse("$baseUrl/cart/decrement"),
      headers: {"Content-Type": "application/json", "Guest-Id": guestId},
      body: jsonEncode({"product_id": productId}),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }

  // Remove item from cart
  static Future<Cart?> removeFromCart(int productId) async {
    String guestId = await _getGuestId();

    final response = await http.post(
      Uri.parse("$baseUrl/cart/remove"),
      headers: {"Content-Type": "application/json", "Guest-Id": guestId},
      body: jsonEncode({"product_id": productId}),
    );

    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body)['data']);
    }
    return null;
  }

  // Update shipping cost
  static Future<double?> updateShipping(int shippingId) async {
    String guestId = await _getGuestId();

    final response = await http.post(
      Uri.parse("$baseUrl/cart/updateShipping"),
      headers: {"Content-Type": "application/json", "Guest-Id": guestId},
      body: jsonEncode({"id": shippingId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['shipping_cost']['cost'].toDouble();
    }
    return null;
  }
}
