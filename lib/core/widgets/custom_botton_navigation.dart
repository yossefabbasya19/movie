import 'package:flutter/material.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedTab;
  final void Function(int)? onTap;
  const CustomBottomNavigation({super.key, required this.selectedTab, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: ColorsManager.blackWithOp,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorsManager.yellow,
          currentIndex: selectedTab,
          onTap: onTap,
          selectedLabelStyle: TextStyle(fontSize: 0),
          unselectedLabelStyle: TextStyle(fontSize: 0),

          items: [
            BottomNavigationBarItem(
              icon: Image(
                image:
                selectedTab == 0
                    ? AssetImage(AssetsManager.selectedHomeTab)
                    : AssetImage(AssetsManager.homeTab),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image:
                selectedTab == 1
                    ? AssetImage(AssetsManager.selectedSearchTab)
                    : AssetImage(AssetsManager.searchTab),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image:
                selectedTab == 2
                    ? AssetImage(AssetsManager.selectedExploreTab)
                    : AssetImage(AssetsManager.browseTab),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image:
                selectedTab == 3
                    ? AssetImage(AssetsManager.selectedProfileTab)
                    : AssetImage(AssetsManager.profileTab),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
