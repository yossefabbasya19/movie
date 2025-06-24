import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/image_with_ratin.dart';
import 'package:movies/feature/movie_details/data/model/Movie.dart';

class SuggestionMovieWidget extends StatelessWidget {
  final List<Movies>? movieSuggestion;

  const SuggestionMovieWidget({super.key, required this.movieSuggestion});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return
      movieSuggestion != null
          ? SliverGrid.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 5 / 7.2
        ),
        itemCount: movieSuggestion!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: image_with_rating(
              width: width,
              movies: movieSuggestion![index],
            ),
          );
        },
      )
          : SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(
            color: ColorsManager.yellow,
          ),
        ),
      );
  }
}
