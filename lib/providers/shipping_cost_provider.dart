import 'package:flutter/material.dart';
import '../models/shipping_cost.dart';
import '../api/shipping_cost_api.dart';

class ShippingCostProvider with ChangeNotifier {
  List<ShippingCost> _shippingCost = [];
  bool _isLoading = false;

  List<ShippingCost> get shippingCosts => _shippingCost;
  bool get isLoading => _isLoading;

  Future<void> fetchShippingCost() async {
    _isLoading = true;
    notifyListeners();

    try {
      _shippingCost = await ShippingCostApi().fetchShippingCost();
    } catch (e) {
      debugPrint("Error fetching shipping cost: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
