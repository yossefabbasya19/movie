import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/assets_manager.dart';
import 'package:movies/core/colors_manager.dart';
import 'package:movies/core/common_function/get_url_for_api.dart';
import 'package:movies/core/helper/show_snack_bar.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/widgets/custom_text_form_failed.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo_implements.dart';
import 'package:movies/feature/main_layout/presentation/view_model/fetch_seach_data/fetch_search_data_cubit.dart';
import 'package:movies/feature/main_layout/presentation/views/tabs/home/widgets/image_with_ratin.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget isLoading = FittedBox(
    child: Center(child: Image(image: AssetImage(AssetsManager.searchImage))),
  );
  List<Movies> searchMovie = [];
  FocusNode focus = FocusNode();
  String searchValue = '';
  late FetchSearchDataCubit fetchSearchDataCubit;

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focus.requestFocus();
    fetchSearchDataCubit = FetchSearchDataCubit(MainLayoutRepoImplements());
    fetchSearchDataCubit.scrollController.addListener(loadData);
    super.initState();
  }
  void loadData() async{
    await fetchSearchDataCubit.loadData(searchValue);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return BlocProvider<FetchSearchDataCubit>.value(
      value: fetchSearchDataCubit,
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Column(
              children: [
                CustomTextFormFailed(
                  focusNode: focus,
                  onFieldSubmitted: (value) {
                    searchMovie = [];
                    fetchSearchDataCubit.pageNumber = 2;
                    searchValue = value;
                    if (value.isEmpty) {
                      focus.requestFocus();
                      return;
                    }
                    BlocProvider.of<FetchSearchDataCubit>(
                      context,
                    ).fetchHomeData(getSearchUrl(value));
                    setState(() {});
                  },
                  label: "Search",
                  prefixIconPath: AssetsManager.searchTab,
                ),
                BlocConsumer<FetchSearchDataCubit, FetchSearchDataState>(
                  listener: (context, state) {
                    if (state is FetchSearchDataSuccess) {
                      state.movies.forEach(
                        (element) => searchMovie.add(element),
                      );
                    } else if (state is FetchSearchDataLoading) {
                      isLoading = FittedBox(
                        child: CircularProgressIndicator(
                          color: ColorsManager.yellow,
                        ),
                      );
                    } else if (state is FetchSearchDataInitial) {
                      isLoading = FittedBox(
                        child: Image(image: AssetImage(AssetsManager.searchImage)),
                      );
                    } else {
                      showSnackBar(context, "please try later");
                    }
                  },
                  builder:
                      (context, state) =>
                          searchMovie.isNotEmpty
                              ? Expanded(
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    GridView.builder(
                                      controller:
                                          fetchSearchDataCubit.scrollController,
                                      itemCount: searchMovie.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 4 / 5.8,
                                          ),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: image_with_rating(
                                            width: width,
                                            movies: searchMovie[index],
                                          ),
                                        );
                                      },
                                    ),
                                    fetchSearchDataCubit.isPagination? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: ColorsManager.yellow,
                                      ),
                                    ):SizedBox(),
                                  ],
                                ),
                              )
                              : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: isLoading),
                              ),
                ),
                SizedBox(height: height * 0.09),
              ],
            ),
          );
        },
      ),
    );
  }


}
