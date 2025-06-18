import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';

class CustomWidgetToDisplayAllMovies extends StatelessWidget {
  final int index ;
  const CustomWidgetToDisplayAllMovies({super.key, required this.index,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(genres[index]),
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  "See More",
                  style: Theme.of(context).textTheme.titleSmall!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                Icon(
                  Icons.arrow_forward,
                  color: ColorsManager.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
