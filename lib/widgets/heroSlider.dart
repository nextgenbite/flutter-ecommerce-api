import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/models/slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// import '../models/slider.dart';

class Heroslider extends StatelessWidget {
  final List sliders;
  const Heroslider({super.key, required this.sliders});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items:
          sliders.map((slider) {
            return Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image:
                      slider.thumbnail != null && slider.thumbnail.isNotEmpty
                          ? CachedNetworkImageProvider(
                            SliderModel.baseUrl + slider.thumbnail,
                          )
                          : const AssetImage('assets/images/placeholder.png')
                              as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child:
                  slider.thumbnail != null && slider.thumbnail.isNotEmpty
                      ? CachedNetworkImage(
                        imageUrl: SliderModel.baseUrl + slider.thumbnail,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 120,
                        progressIndicatorBuilder:
                            (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                      )
                      : null, // No need for a child if using a placeholder
            );
          }).toList(),
    );
  }
}
