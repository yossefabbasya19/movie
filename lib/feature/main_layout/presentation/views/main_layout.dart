import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/widgets/custom_botton_navigation.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo_implements.dart';
import 'package:movies/feature/main_layout/presentation/view_model/fetch_user_info/fetch_user_info_cubit.dart';
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
  late FetchUserInfoCubit fetchUserInfoCubit;

  @override
  void initState() {
    fetchUserInfoCubit = FetchUserInfoCubit(MainLayoutRepoImplements());
    fetchUserInfoCubit.getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocProvider.value(
      value: fetchUserInfoCubit,
      child: Scaffold(
        body: BlocBuilder<FetchUserInfoCubit, FetchUserInfoState>(
          builder: (context, state) {
            if (state is FetchUserInfoSuccess) {
              return Stack(
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
              );
            } else {
              return Center(child: CircularProgressIndicator(color: ColorsManager.yellow));
            }
          },
        ),
      ),
    );
  }
}
