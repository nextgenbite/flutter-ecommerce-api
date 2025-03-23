import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/custom_app_bar.dart';
import '../screens/cart_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/product_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
    );
  }

  int _currentIndex = 0;
  final List<Widget> _pages = [HomeScreen(), CartScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'E-Commerce Home',
        isHome: true,
        onCartTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CartScreen()),
          );
        },
      ),
      body: PageTransitionSwitcher(
        duration: Duration(milliseconds: 400),
        reverse: true,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: SafeArea(
          child: SingleChildScrollView(
            key: ValueKey<int>(_currentIndex),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    return productProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : productProvider.products.isEmpty
                        ? Center(child: Text('No products available'))
                        : ProductSection(
                          products: productProvider.products,
                          title: 'New Products',
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _currentIndex,
        // onTap: _onItemTapped,
      ),
    );
  }
}
