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
                          ? NetworkImage(SliderModel.baseUrl + slider.thumbnail)
                          : AssetImage('assets/images/placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
    );
  }
}
