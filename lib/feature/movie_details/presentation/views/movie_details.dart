import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';
import 'package:movies/feature/movie_details/data/repo/movie_details_repo_imple.dart';
import 'package:movies/feature/movie_details/presentation/view_model/movie_detail_cubit.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/display_movie_image.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/display_shortcut.dart';

class MovieDetails extends StatefulWidget {
  final Movies movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieDetailCubit movieDetailCubit;
  Data? movie;

  @override
  void initState() {
    movieDetailCubit = MovieDetailCubit(MovieDetailsRepoImple());
    loadMovieDetails();
    super.initState();
  }

  loadMovieDetails() async {
    await movieDetailCubit.getMovieDetails("${widget.movie.id}");
    movie = movieDetailCubit.movieData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<MovieDetailCubit, MovieDetailState>(
                listener: (context, state) {
                  if (state is MovieDetailSuccess) {
                    print("object");
                  }
                },
                builder: (context, state) {
                  return DisplayMovieImage(movie: widget.movie);
                },
              ),
              movie != null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Screen Shots",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: height * 0.01),
                        DisplayShortcut(
                          imagePath: movie?.movie?.largeScreenshotImage1 ?? "",
                        ),
                        SizedBox(height: height * 0.01),
                        DisplayShortcut(
                          imagePath: movie?.movie?.largeScreenshotImage2 ?? '',
                        ),
                        SizedBox(height: height * 0.01),
                        DisplayShortcut(
                          imagePath: movie?.movie!.largeScreenshotImage3 ?? '',
                        ),
                      ],
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(
                      color: ColorsManager.yellow,
                    ),
                  ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
