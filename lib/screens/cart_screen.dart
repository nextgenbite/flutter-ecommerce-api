import 'package:ecommerce/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/app_bottom_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<CartProvider>(context, listen: false).fetchCart(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 80,
                  top: 20,
                ),
                margin: const EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          if (cart == null || cart.items.isEmpty) {
                            return Center(
                              child: Text(
                                'Your cart is empty.',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (context, index) {
                              final cartItem = cart.items[index];
                              return Dismissible(
                                key: Key(
                                  cartItem.product.id.toString(),
                                ), // Use a unique key for each item
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  cartProvider.removeFromCart(
                                    cartItem.productId,
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 0.5,
                                          blurRadius: 1,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.network(
                                            "http://ecomapi.nextgenbite.com/${cartItem.product.thumbnail}",
                                            fit: BoxFit.cover,
                                            width: 67,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: SizedBox(
                                            width: 100,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartItem.product.title,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      Theme.of(
                                                        context,
                                                      ).textTheme.titleMedium,
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "\$${cartItem.product.price.toString()}",
                                                      style:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .titleLarge,
                                                    ),
                                                    Expanded(
                                                      child: Container(),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  15,
                                                                ),
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primary,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                  1.0,
                                                                  1.0,
                                                                ),
                                                                blurRadius: 1.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.add,
                                                            ),
                                                            color: Colors.white,
                                                            iconSize: 16,
                                                            onPressed: () {
                                                              cartProvider
                                                                  .incrementItem(
                                                                    cartItem
                                                                        .productId,
                                                                  );
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          cartItem.quantity
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  15,
                                                                ),
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primary,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                color:
                                                                    Colors.grey,
                                                                offset: Offset(
                                                                  1.0,
                                                                  1.0,
                                                                ),
                                                                blurRadius: 1.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.remove,
                                                            ),
                                                            color: Colors.white,
                                                            iconSize: 16,
                                                            onPressed: () {
                                                              if (cartItem
                                                                      .quantity >=
                                                                  1) {
                                                                cartProvider
                                                                    .decrementItem(
                                                                      cartItem
                                                                          .productId,
                                                                    );
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: Container()),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Provider.of<CartProvider>(context,
                                      //         listen: false)
                                      //     .clearCart();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text(
                                      "Clear Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Total Price:',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    '\$${cart?.items.length != null ? cart!.subtotal : 0.00}',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder:
                                            (BuildContext context) =>
                                                CheckoutScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    elevation: 10,
                                  ),
                                  child: const Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomBar(currentIndex: 1),
    );
  }
}
