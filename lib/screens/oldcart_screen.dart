import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      // ignore: use_build_context_synchronously
      () => Provider.of<CartProvider>(context, listen: false).fetchCart(),
    );
  }

  final int _selectedIndex = 1;
  final List<String> _routes = ['/', '/cart', '/login'];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      Navigator.pushReplacementNamed(context, _routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body:
          cartProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : cart == null || cart.items.isEmpty
              ? const Center(child: Text("Cart is empty"))
              : ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];

                  return ListTile(
                    leading: Image.network(
                      "http://ecomerce_lara_nuxt.test/${item.product.thumbnail}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                        Text("Price: \$${item.price}"),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Free Shipping",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed:
                                  () => cartProvider.decrementItem(
                                    item.productId,
                                  ),
                            ),
                            Text(item.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed:
                                  () => cartProvider.incrementItem(
                                    item.productId,
                                  ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed:
                                  () => cartProvider.removeFromCart(
                                    item.productId,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     IconButton(
                    //       icon: const Icon(Icons.remove),
                    //       onPressed:
                    //           () => cartProvider.decrementItem(item.productId),
                    //     ),
                    //     Text(item.quantity.toString()),
                    //     IconButton(
                    //       icon: const Icon(Icons.add),
                    //       onPressed:
                    //           () => cartProvider.incrementItem(item.productId),
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(Icons.delete, color: Colors.red),
                    //       onPressed:
                    //           () => cartProvider.removeFromCart(item.productId),
                    //     ),
                    //   ],
                    // ),
                  );
                },
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
        ],
      ),
    );
  }
}
