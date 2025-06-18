import 'package:movies/core/assets_manager.dart';

class OnBoardingDm {
  final String imagePath;
  final String title;
  final String? description;

  OnBoardingDm({
    required this.imagePath,
    required this.title,
    this.description,
  });
}

List<OnBoardingDm> onBoardingItems = [
  OnBoardingDm(
    imagePath: AssetsManager.image2,
    title: "Explore All Genres",
    description:
        "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
  ),
  OnBoardingDm(
    imagePath: AssetsManager.image3,
    title: "Create Watchlists",
    description:
        "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.",
  ),
  OnBoardingDm(
    imagePath: AssetsManager.image4,
    title: "Rate, Review, and Learn",
    description:
        "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
  ),
  OnBoardingDm(
    imagePath: AssetsManager.image5,
    title: "Rate, Review, and Learn",
    description:
        "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.",
  ),
  OnBoardingDm(imagePath: AssetsManager.image6, title: "Start Watching Now"),
];
