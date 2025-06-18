import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';

class InfoDisplay extends StatelessWidget {
  final String imagePath;
  final num number;
  const InfoDisplay({super.key, required this.imagePath, required this.number});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorsManager.lightBlack,
      ),
      child: Row(
        children: [
          Image(image: AssetImage(imagePath)),
          SizedBox(width: width * 0.03),
          Text(
            "$number",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
