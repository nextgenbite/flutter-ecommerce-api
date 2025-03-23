import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/product_info.dart';
import 'cart_screen.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: product.title,
        isHome: true,
        onCartTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CartScreen()),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: OutlinedButton(
                    onPressed: () {
                      // Add to cart logic
                      Provider.of<CartProvider>(
                        context,
                        listen: false,
                      ).addToCart(product.id, 1);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.title} added to cart!"),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text("Add to Cart"),
                  ),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to cart logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.title} added to cart!"),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text("Buy Now"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Center(
                  child:
                      product.images.isNotEmpty
                          ? CarouselSlider(
                            options: CarouselOptions(
                              height: 200,
                              autoPlay: true,
                              // enlargeCenterPage: true,
                            ),
                            items:
                                product.images.map((image) {
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          image['path'] != null &&
                                                  image['path'].isNotEmpty
                                              ? Product.baseUrl + image['path']
                                              : Product.baseUrl +
                                                  product.thumbnail,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          )
                          : Image.network(
                            Product.baseUrl + product.thumbnail,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                ),
                SizedBox(height: 20),
                // Product Price
                product.discount > 0
                    ? Row(
                      children: [
                        Text(
                          "\$${product.price.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "\$${product.discount.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    )
                    : Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                ProductInfo(
                  title: product.title,
                  brand: 'test',
                  description: product.description,
                  rating: 4,
                  numOfReviews: 50,
                  isAvailable: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
