import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movies/feature/movie_details/presentation/views/widgets/display_shortcut.dart';

class ShortCutWidget extends StatelessWidget {
  final Data? movie;
  const ShortCutWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return movie != null
        ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.screen_shots,
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
    );
  }
}
