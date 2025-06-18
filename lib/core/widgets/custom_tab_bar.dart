import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';

class CustomTabBar extends StatelessWidget {
  final void Function(int)? onTap;
  final int selectedTab ;
  const CustomTabBar({super.key, this.onTap, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: genres.length,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        unselectedLabelColor: ColorsManager.yellow,
        labelColor: ColorsManager.black,
        indicator:BoxDecoration(color: Colors.transparent) ,
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.symmetric(horizontal: 8),
        onTap: onTap,
        isScrollable: true,
        labelStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        tabs:
        genres.map((e) {
          return genres.indexOf(e) == selectedTab
              ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.yellow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(e),
          )
              : Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsManager.yellow,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(e),
          );
        }).toList(),
      ),
    );
  }
}
