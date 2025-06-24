import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/extention/string_ex.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';
import 'package:movies/feature/movie_details/data/repo/movie_details_repo_imple.dart';
import 'package:movies/feature/movie_details/presentation/view_model/movie_detail_cubit.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/cast_widget.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/display_movie_image.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/genres_widget.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/short_cut_widget.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/suggestion_movie_widget.dart';

class MovieDetails extends StatefulWidget {
  final Movies movie;

  const MovieDetails({super.key, required this.movie});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late MovieDetailCubit movieDetailCubit;
  Data? movie;
  List<Movies>? movieSuggestion;

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
    await movieDetailCubit.getMovieSuggestionsDetails("${widget.movie.id}");
    movieSuggestion = movieDetailCubit.movieSuggestion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            BlocConsumer<MovieDetailCubit, MovieDetailState>(
              listener: (context, state) {
                if (state is MovieDetailSuccess) {
                  print("object");
                }
              },
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: DisplayMovieImage(movie: widget.movie),
                );
              },
            ),
            SliverToBoxAdapter(child: ShortCutWidget(movie: movie)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Text(
                  AppLocalizations.of(context)!.similar,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SuggestionMovieWidget(movieSuggestion: movieSuggestion),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  AppLocalizations.of(context)!.summary,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  movie?.movie?.descriptionFull?.descriptionIsEmpty ??
                      "not founded",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Text(
                  AppLocalizations.of(context)!.cast,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            CastWidget(movie: movie),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Text(
                  AppLocalizations.of(context)!.genres,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            GenresWidget(movie: movie),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.03)),
          ],
        ),
      ),
    );
  }
}
