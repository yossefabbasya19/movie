import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/core/widgets/custom_widget_to_display_all_movies.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo_implements.dart';
import 'package:movies/feature/main_layout/presentation/view_model/fetch_home_data_cubit/fetch_home_data_cubit.dart';
import 'package:movies/feature/main_layout/presentation/view_model/fetch_home_data_with_category_cubit/fetch_home_data_with_category_cubit.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/background_widget.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/display_available.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/image_with_ratin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FetchHomeDataCubit fetchHomeDataCubit;
  late FetchHomeDataWithCategoryCubit fetchHomeDataWithCategoryCubit;
  List<Movies> movies = [];
  Map<String, MoviesResponseDm> moviesWithCategory = {};
  int pageNumber = 1;
  int selectMovie = 0;

  @override
  void initState() {
    fetchHomeDataCubit = FetchHomeDataCubit(MainLayoutRepoImplements());
    fetchHomeDataWithCategoryCubit = FetchHomeDataWithCategoryCubit(
      MainLayoutRepoImplements(),
    );
    fetchData(pageNumber);
    super.initState();
  }

  Future<void> fetchData(int pageNumber) async {
    await fetchHomeDataCubit.fetchHomeData(
      "https://yts.mx/api/v2/list_movies.json?sort_by=year&minimum_rating=7",
    );
    movies = fetchHomeDataCubit.movies;
    await fetchHomeDataWithCategoryCubit.fetchHomeDataWithCategory();
    moviesWithCategory = fetchHomeDataWithCategoryCubit.moviesWithCategory;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: fetchHomeDataCubit),
        BlocProvider.value(value: fetchHomeDataWithCategoryCubit),
      ],
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  BlocConsumer<FetchHomeDataCubit, FetchHomeDataState>(
                    listener: (context, state) {
                      if (state is FetchHomeDataFailure) {
                        showSnackBar(context, state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is FetchHomeDataSuccess && movies.isNotEmpty) {
                        return SizedBox(
                          height: height * 0.65,
                          child: Stack(
                            children: [
                              background_widget(
                                width: width,
                                movies: movies,
                                selectMovie: selectMovie,
                              ),
                              display_available(
                                width: width,
                                onPageChanged: (index, reason) {
                                  selectMovie = index;
                                  setState(() {});
                                },
                                movies: movies,
                                height: height,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: ColorsManager.yellow,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            moviesWithCategory.isEmpty
                ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.yellow,
                      ),
                    ),
                  ),
                )
                : SliverList.builder(
                  itemCount: genres.length,
                  itemBuilder: (context, index) {
                    List<Movies> moviesWithCategoryList =
                        moviesWithCategory[genres[index]]?.movies ?? [];
                    return Column(
                      children: [
                        CustomWidgetToDisplayAllMovies(index: index),
                        SizedBox(height: height * 0.01),
                        SizedBox(
                          height: height * 0.2,
                          child:
                              moviesWithCategoryList.isNotEmpty
                                  ? ListView.separated(
                                    itemCount: moviesWithCategoryList.length,
                                    separatorBuilder:
                                        (context, index) =>
                                            SizedBox(width: width * 0.03),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return image_with_rating(
                                        width: width,
                                        movies: moviesWithCategoryList[index],
                                      );
                                    },
                                  )
                                  : Center(
                                    child: Text("this category not provide"),
                                  ),
                        ),
                        SizedBox(height: height * 0.01),
                      ],
                    );
                  },
                ),
            SliverToBoxAdapter(child: SizedBox(height: height * 0.1)),
          ],
        ),
      ),
    );
  }
}
