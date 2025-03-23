import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details (if implemented)
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => ProductDetailScreen(product: product),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.15,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.r),
                  ),
                  child: CachedNetworkImage(
                    progressIndicatorBuilder:
                        (context, url, progress) => Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                    imageUrl: Product.baseUrl + product.thumbnail,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 120,
                  ),
                ),
                if (product.stock < 1)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Sold Out ${product.stock}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '\$${product.price}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    height: 25.h,
                    child: ElevatedButton(
                      onPressed: product.stock == 0 ? null : () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        backgroundColor:
                            product.stock == 0
                                ? Colors.grey
                                : Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'BUY NOW',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    height: 25.h,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: product.stock == 0 ? null : () {},
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
