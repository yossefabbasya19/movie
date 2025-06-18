import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/widgets/custom_tab_bar.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo_implements.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/browse/cubit/fetch_data_cubit.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/image_with_ratin.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<Browse> createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int selectedTab = 0;
  bool loader = false;
  late FetchBrowseDataCubit fetchBrowseDataCubit;
  List<Movies> movies = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    fetchBrowseDataCubit = FetchBrowseDataCubit(MainLayoutRepoImplements());
    await fetchBrowseDataCubit.fetchBrowserData(
      "https://yts.mx/api/v2/list_movies.json?genre=${genres[selectedTab]}",
    );
    fetchBrowseDataCubit.scrollController.addListener(() async {
      await fetchBrowseDataCubit.loadMoreData(genres[selectedTab]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return BlocProvider.value(
      value: fetchBrowseDataCubit,
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  CustomTabBar(
                    selectedTab: selectedTab,
                    onTap: (value) {
                      movies = [];
                      fetchBrowseDataCubit.pageNumber = 2;
                      selectedTab = value;
                      fetchBrowseDataCubit.fetchBrowserData(
                        "https://yts.mx/api/v2/list_movies.json?genre=${genres[selectedTab]}&page=1&sort_by=year",
                      );
                      setState(() {});
                    },
                  ),
                  BlocConsumer<FetchBrowseDataCubit, FetchDataState>(
                    listener: (context, state) {
                      if (state is FetchDataSuccess) {
                        state.movies.forEach((element) => movies.add(element));
                      } else if (state is FetchDataFailure) {
                        showSnackBar(context, state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      return movies.isNotEmpty
                          ? Expanded(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                GridView.builder(
                                  controller:
                                      fetchBrowseDataCubit.scrollController,
                                  itemCount: movies.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 4 / 6,
                                      ),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: image_with_rating(
                                        width: width,
                                        movies: movies[index],
                                      ),
                                    );
                                  },
                                ),
                                fetchBrowseDataCubit.isLoading
                                    ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.yellow,
                                      ),
                                    )
                                    : SizedBox(),
                              ],
                            ),
                          )
                          : Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: CircularProgressIndicator(
                              color: ColorsManager.yellow,
                            ),
                          );
                    },
                  ),
                  SizedBox(height: height * 0.09),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
