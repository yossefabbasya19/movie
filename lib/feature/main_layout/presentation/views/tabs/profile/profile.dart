import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo_implements.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/image_with_ratin.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/profile/cubit/get_watch_list_cubit/get_watch_list_cubit.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/profile/widgets/custom_tab_bar_for_profile_tab.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/profile/widgets/profile_button.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/profile/widgets/user_display_info.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late GetWatchListAndHistoryCubit getWatchListCubit;
  List<Movies> watchListMovies = [];
  List<Movies> historyListMovies = [];
  int selectTab = 0;

  @override
  void initState() {
    getWatchListCubit = GetWatchListAndHistoryCubit(MainLayoutRepoImplements());
    loadData();
    super.initState();
  }

  loadData() async {
    await getWatchListCubit.getWatchList(
      UserDm.currentUser!.watchList,
    );
    watchListMovies = getWatchListCubit.watchList;
    setState(() {});
    await getWatchListCubit.getHistoryList(
      UserDm.currentUser!.history,
    );
    historyListMovies = getWatchListCubit.watchList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocProvider.value(
      value: getWatchListCubit,
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: UserDisplayInfo()),
                const SliverToBoxAdapter(child: ProfileButton()),
                SliverToBoxAdapter(child: SizedBox(height: height * 0.01)),
                SliverToBoxAdapter(
                  child: CustomTabBarForProfileTab(
                    onTap: (value) {
                      selectTab = value;
                      setState(() {});
                    },
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: height * 0.01)),
                BlocBuilder<GetWatchListAndHistoryCubit, GetWatchListState>(
                  builder: (context, state) {
                    if (state is GetWatchListSuccess) {
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount:
                              selectTab == 0
                                  ? getWatchListCubit.watchList.length
                                  : getWatchListCubit.historyList.length,
                          (context, index) => image_with_rating(
                            width: width,
                            movies:
                                selectTab == 0
                                    ? getWatchListCubit.watchList[index]
                                    : getWatchListCubit.historyList[index],
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 4 / 6,
                              crossAxisCount: 3,
                            ),
                      );
                    } else if (state is GetWatchListFailure) {
                      return SliverToBoxAdapter(child: Text(state.errMessage));
                    } else {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.yellow,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: height * 0.01)),
              ],
            ),
          );
        },
      ),
    );
  }
}
