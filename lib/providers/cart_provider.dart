import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../api/cart_api.dart';

class CartProvider with ChangeNotifier {
  Cart? _cart;

  Cart? get cart => _cart;

  bool get isLoading => _cart == null;

  Future<void> fetchCart() async {
    _cart = await CartApi.fetchCart();
    notifyListeners();
  }

  Future<void> addToCart(int productId, int quantity) async {
    _cart = await CartApi.addToCart(productId, quantity);
    notifyListeners();
  }

  Future<void> incrementItem(int productId) async {
    _cart = await CartApi.incrementItem(productId);
    notifyListeners();
  }

  Future<void> decrementItem(int productId) async {
    _cart = await CartApi.decrementItem(productId);
    notifyListeners();
  }

  Future<void> removeFromCart(int productId) async {
    _cart = await CartApi.removeFromCart(productId);
    notifyListeners();
  }

  // Future<void> updateShipping(int shippingId) async {
  //   double? shippingCost = await CartApi.updateShipping(shippingId);
  //   if (shippingCost != null && _cart != null) {
  //     _cart!.shippingCost = shippingCost;
  //     _cart!.total =
  //         _cart!.subtotal + shippingCost + _cart!.tax - _cart!.discount;
  //     notifyListeners();
  //   }
  // }
}
