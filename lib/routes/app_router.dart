import 'package:ecommerce/screens/checkout_screen.dart';
import 'package:ecommerce/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/login_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/checkout':
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // case '/product':
      //   return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
