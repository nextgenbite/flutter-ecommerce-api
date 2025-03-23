import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/slider.dart';
import '../models/category.dart';
import '../api/api_service.dart';

class HomepageProvider extends ChangeNotifier {
  List<SliderModel> _sliders = [];
  List<Category> _categories = [];
  List<Product> _trendingProducts = [];
  List<Product> _latestProducts = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  List<SliderModel> get sliders => _sliders;
  List<Product> get trendingProducts => _trendingProducts;
  List<Product> get latestProducts => _latestProducts;
  bool get isLoading => _isLoading;

  Future<void> fetchHomepageData() async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await ApiService.fetchHomepageData();
      // Using your existing Product to parse products
      _sliders =
          (data['sliders'] as List)
              .map((item) => SliderModel.fromJson(item))
              .toList();
      _categories =
          (data['categories'] as List)
              .map((item) => Category.fromJson(item))
              .toList();
      _trendingProducts =
          (data['trends'] as List)
              .map((item) => Product.fromJson(item))
              .toList();

      _latestProducts =
          (data['latest'] as List)
              .map((item) => Product.fromJson(item))
              .toList();
    } catch (e) {
      print("Error fetching homepage data: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
