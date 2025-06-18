import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

part 'fetch_search_data_state.dart';

class FetchSearchDataCubit extends Cubit<FetchSearchDataState> {
  FetchSearchDataCubit(this.mainLayoutRepo) : super(FetchSearchDataInitial());
  final MainLayoutRepo mainLayoutRepo;
  List<Movies> movies = [];
  int pageNumber = 2;
  bool isPagination = false;
  late int maxPageNumber;
  ScrollController scrollController = ScrollController();
  late MoviesResponseDm moviesResponseDm;

  Future<void> fetchHomeData(String url) async {
    emit(FetchSearchDataLoading());
    var result = await mainLayoutRepo.fetchData(url);
    result.fold(
      (left) {
        emit(FetchSearchDataFailure(left.errMessage));
      },
      (right) {
        moviesResponseDm = right;
        maxPageNumber = calculateMaxPageNumber(moviesResponseDm);
        emit(FetchSearchDataSuccess(right.movies!));
      },
    );
  }

  int calculateMaxPageNumber(MoviesResponseDm moviesResponseDm) {
    return (moviesResponseDm.movieCount! / moviesResponseDm.limit!.toInt())
        .ceil();
  }

  Future<void> loadData(String searchValue) async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        pageNumber <= maxPageNumber) {
      isPagination = true;
      print(scrollController.position.pixels);
      print(scrollController.position.maxScrollExtent);
      await fetchHomeData(
        "https://yts.mx/api/v2/list_movies.json?query_term=$searchValue&page=$pageNumber",
      );
      isPagination = false;
      pageNumber++;
    }
  }
}
