import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';

class DisplayShortcut extends StatelessWidget {
  final String imagePath;

  const DisplayShortcut({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        errorWidget:
            (context, url, error) =>
                Image(image: AssetImage(AssetsManager.noImage)),
        imageUrl: imagePath,
        height: height * 0.15,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
