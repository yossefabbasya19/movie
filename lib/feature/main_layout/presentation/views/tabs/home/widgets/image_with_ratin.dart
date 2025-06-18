import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/my_routes/my_routes.dart';

class image_with_rating extends StatelessWidget {
  const image_with_rating({
    super.key,
    required this.width,
    required this.movies,
  });

  final double width;
  final Movies movies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.movieDetails, arguments: movies);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: movies.largeCoverImage!,
              errorWidget:
                  (context, url, error) =>
                      Image(image: AssetImage(AssetsManager.noImage)),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            width: width * 0.2,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("${movies.rating}"),
                Icon(Icons.star, color: ColorsManager.yellow),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
