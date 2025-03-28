// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../models/slider.dart';

class HeroSlider extends StatelessWidget {
  final List sliders;
  const HeroSlider({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3.5,
      child: CarouselSlider(
        options: CarouselOptions(
          // height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
          // enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items:
            sliders.map((slider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: Config.apiUrl + slider.thumbnail,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
              );
              // return Container(
              //   margin: EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     image: DecorationImage(
              //       image:
              //           slider.thumbnail != null && slider.thumbnail.isNotEmpty
              //               ? CachedNetworkImageProvider(
              //                 SliderModel.baseUrl + slider.thumbnail,
              //               )
              //               : const AssetImage('assets/images/placeholder.png')
              //                   as ImageProvider,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              //   child:
              //       slider.thumbnail != null && slider.thumbnail.isNotEmpty
              //           ? CachedNetworkImage(
              //             imageUrl: SliderModel.baseUrl + slider.thumbnail,
              //             fit: BoxFit.cover,
              //             width: double.infinity,
              //             height: 120,
              //             progressIndicatorBuilder:
              //                 (context, url, progress) => Center(
              //                   child: CircularProgressIndicator(
              //                     value: progress.progress,
              //                   ),
              //                 ),
              //           )
              //           : null, // No need for a child if using a placeholder
              // );
            }).toList(),
      ),
    );
  }
}
