import 'package:flutter/material.dart';
import 'package:movies/core/colors_manager.dart';

class CustomTabBarForProfileTab extends StatelessWidget {
  const CustomTabBarForProfileTab({super.key, this.onTap});
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        onTap:onTap,
        tabAlignment: TabAlignment.fill,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorColor: ColorsManager.yellow,
        indicatorWeight: 2.5,
        tabs: [
          Tab(
            icon: Icon(
              Icons.list_outlined,
              color: ColorsManager.yellow,
            ),
            child: Text(
              "Watch List",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Tab(
            icon: Icon(Icons.folder, color: ColorsManager.yellow),
            child: Text(
              "History",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
