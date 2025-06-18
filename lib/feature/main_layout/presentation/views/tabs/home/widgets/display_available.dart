import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/image_with_ratin.dart';

class display_available extends StatelessWidget {
  const display_available({
    super.key,
    required this.movies,
    required this.height,
    required this.width,
    this.onPageChanged,
  });

  final List<Movies> movies;
  final double height;
  final double width;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image(image: AssetImage(AssetsManager.availableNow)),
        CarouselSlider(
          items:
              movies.map((e) {
                return image_with_rating(width: width,movies: e,);
              }).toList(),
          options: CarouselOptions(
            onPageChanged: onPageChanged,
            height: height * 0.2827467811158798,
            enlargeCenterPage: true,
            aspectRatio: 3 / 1.5,
            viewportFraction: 0.39,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.05),
          child: Image(image: AssetImage(AssetsManager.watchNow)),
        ),
      ],
    );
  }
}

