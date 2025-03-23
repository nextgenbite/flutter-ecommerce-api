import 'package:flutter/material.dart';
import '../models/product.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/product_info.dart';
import 'cart_screen.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              // Center(
              //   child: CarouselSlider(
              //     options: CarouselOptions(
              //       height: 200,
              //       autoPlay: true,
              //       enlargeCenterPage: true,
              //     ),
              //     items:
              //         product.images.map((image) {
              //           return Container(
              //             margin: EdgeInsets.all(5),
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               image: DecorationImage(
              //                 image: NetworkImage(
              //                   image['path'] != null &&
              //                           image['path'].isNotEmpty
              //                       ? Product.baseUrl + image['path']
              //                       : Product.baseUrl + product.thumbnail,
              //                 ),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           );
              //         }).toList(),
              //   ),

              // ),
              SizedBox(height: 20),
              ProductInfo(
                title: product.title,
                brand: 'test',
                description: product.description,
                rating: 4,
                numOfReviews: 50,
                isAvailable: true,
              ),
              // Product Name
              Text(
                product.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Product Price
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
              SizedBox(height: 10),

              // Product Description
              Text(product.description, style: TextStyle(fontSize: 16)),

              Spacer(),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
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
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text("Buy Now"),
                      ),
                    ),
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
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text("Add to Cart"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
