import 'package:flutter/material.dart';

import '../api/product_api.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ProductApi().fetchProducts();
    } catch (e) {
      print('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
