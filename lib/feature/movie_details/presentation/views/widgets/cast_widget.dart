import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/extention/string_ex.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';

class CastWidget extends StatelessWidget {
  final Data? movie;
  const CastWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return movie != null
        ? SliverList.builder(
      itemCount: movie?.movie?.cast?.length ?? 0,
      itemBuilder: (context, index) {
        return IntrinsicHeight(
          child: Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorsManager.blackWithOp,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    width: width * 0.2,
                    height: height * 0.09,
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      movie?.movie?.cast?[index].actorImage ?? '',
                    ),
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                      Icons.image_not_supported,
                      size: width * 0.2,
                    ),
                  ),
                ),
                SizedBox(width: width * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Name : ",
                              style: TextStyle(fontSize:20),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                movie!.movie!.cast![index].name!,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "Character : ",
                              style: TextStyle(fontSize:20),
                            ),
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                movie!
                                    .movie!
                                    .cast![index]
                                    .characterName!
                                    .descriptionIsEmpty,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
