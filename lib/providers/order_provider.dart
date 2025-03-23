import 'package:flutter/material.dart';

import '../api/order_api.dart';

class OrderProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> store(Map<String, dynamic> orderData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await OrderApi().submitOrder(orderData);
      if (response['success']) {
        print('Order placed successfully!');
        response;
      } else {
        print('Order failed: ${response['message']}');
      }
    } catch (e) {
      print('Error submitting order: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
