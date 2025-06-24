import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';

class GenresWidget extends StatelessWidget {
  final Data? movie;
  const GenresWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return movie != null
        ? SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.188888888888889,
        crossAxisSpacing: 0.1,
        mainAxisSpacing: 0.1,
      ),
      itemCount: movie?.movie?.genres?.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.blackWithOp,
              borderRadius: BorderRadius.circular(12),
            ),
            child: FittedBox(child: Text(movie!.movie!.genres![index])),
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
