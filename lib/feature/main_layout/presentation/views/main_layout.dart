import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/widgets/custom_botton_navigation.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/browse/browse.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/home.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/profile/profile.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/search/search.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> tabs = [Home(), Search(), Browse(), Profile()];
  int selectedTab = 0;

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    User user = FirebaseAuth.instance.currentUser!;
    UserDm.currentUser = await FirebaseService.getUserByDocID(user.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          tabs[selectedTab],
          CustomBottomNavigation(
            selectedTab: selectedTab,
            onTap: (value) {
              selectedTab = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
