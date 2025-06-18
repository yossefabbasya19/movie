import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/constace.dart';

class CustomCarouselSlider extends StatelessWidget {
  final void Function(int,CarouselPageChangedReason)?onPageChanged;
  const CustomCarouselSlider({super.key, this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return  CarouselSlider(
      items:
      avatars.map((e) {
        return Image(image: AssetImage(e));
      }).toList(),
      options: CarouselOptions(
        onPageChanged:onPageChanged ,
          height: height * 0.1727467811158798,
          enlargeCenterPage: true,
          aspectRatio: 3/1.5,
          viewportFraction: 0.37
      ),
    );
  }
}
