import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/core/widgets/custom_elevation_button.dart';
import 'package:movies/feature/movie_details/presentation/view_model/movie_detail_cubit.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/info_display.dart';

class DisplayMovieImage extends StatefulWidget {
  final Movies movie;
  final bool isFavorites;

  const DisplayMovieImage({
    super.key,
    required this.movie,
    required this.isFavorites,
  });

  @override
  State<DisplayMovieImage> createState() => _DisplayMovieImageState();
}

class _DisplayMovieImageState extends State<DisplayMovieImage> {
  late bool isFavorites;

  @override
  void initState() {
    isFavorites = widget.isFavorites;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Stack(
          children: [
            Stack(
              children: [
                Image(
                  fit: BoxFit.fill,
                  width: width,
                  height: height * 0.6520600858369099,
                  image: NetworkImage(widget.movie.mediumCoverImage!),
                ),
                Container(
                  width: width,
                  height: height * 0.6520600858369099,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        ColorsManager.black.withValues(alpha: 0.2),
                        ColorsManager.black.withValues(alpha: 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (!isFavorites) {
                            await BlocProvider.of<MovieDetailCubit>(
                              context,
                            ).addFavorites(widget.movie);
                            isFavorites = !isFavorites;
                            setState(() {});
                          } else {
                            await BlocProvider.of<MovieDetailCubit>(
                              context,
                            ).removeFavorites(widget.movie.id!);
                            isFavorites = !isFavorites;
                            setState(() {});
                          }
                          print(UserDm.currentUser!.watchList);
                        },
                        child: Image(
                          image:
                              isFavorites
                                  ? AssetImage(AssetsManager.watchLaterSelect)
                                  : AssetImage(AssetsManager.watchLater),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("play movie");
                  },
                  child: Image(image: AssetImage(AssetsManager.playMovie)),
                ),
                Column(
                  children: [
                    Text(
                      widget.movie.title!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      "${widget.movie.year!}",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        CustomElevationButton(
          textColor: ColorsManager.white,
          buttonColor: ColorsManager.red,
          onPressed: () {},
          txt: "Watch",
        ),
        SizedBox(height: height * 0.01),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoDisplay(
                imagePath: AssetsManager.likes,
                number: widget.movie.runtime! - 20,
              ),
              InfoDisplay(
                imagePath: AssetsManager.time,
                number: widget.movie.runtime!,
              ),
              InfoDisplay(
                imagePath: AssetsManager.rate,
                number: widget.movie.rating!,
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.02),
      ],
    );
  }
}
