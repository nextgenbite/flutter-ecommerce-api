import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
    required this.title,
    required this.brand,
    required this.description,
    required this.rating,
    required this.numOfReviews,
    required this.isAvailable,
  });

  final String title, brand, description;
  final double rating;
  final int numOfReviews;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brand.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        // const SizedBox(height: 16 / 2 / 2),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        // const SizedBox(height: 16 / 2),
        // Row(
        //   children: [
        //     // ProductAvailabilityTag(isAvailable: isAvailable),
        //     const Spacer(),
        //     // SvgPicture.asset("assets/icons/Star_filled.svg"),
        //     Icon(Icons.star_outline_rounded, color: Colors.amber),
        //     const SizedBox(width: 16 / 2 / 4),
        //     Text("$rating ", style: Theme.of(context).textTheme.bodyLarge),
        //     Text("($numOfReviews Reviews)"),
        //   ],
        // ),
        // const SizedBox(height: 16 / 2),
        Text(
          "Product info",
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        // const SizedBox(height: 16 / 2 / 2),
        Text(description),
        // const SizedBox(height: 16 / 2 / 2),
      ],
    );
  }
}
