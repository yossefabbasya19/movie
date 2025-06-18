import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';

class background_widget extends StatelessWidget {
  const background_widget({
    super.key,
    required this.width,
    required this.movies,
    required this.selectMovie,
  });

  final double width;
  final List<Movies> movies;
  final int selectMovie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          width: width,
          fit: BoxFit.fill,
          image: NetworkImage(
            movies[selectMovie].largeCoverImage!,
          ),
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsManager.black.withValues(
                  alpha: 0.3,
                ),
                ColorsManager.black.withValues(alpha: 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}
