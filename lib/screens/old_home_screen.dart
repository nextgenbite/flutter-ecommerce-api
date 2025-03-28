import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../widgets/app_bottom_bar.dart';
import '../widgets/custom_app_bar.dart';
import '../screens/cart_screen.dart';
import '../widgets/product_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          // ignore: use_build_context_synchronously
          Provider.of<ProductProvider>(context, listen: false).fetchProducts(),
    );
  }

  final int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context);

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
