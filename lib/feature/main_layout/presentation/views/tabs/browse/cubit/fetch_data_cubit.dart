import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

part 'fetch_data_state.dart';

class FetchBrowseDataCubit extends Cubit<FetchDataState> {
  FetchBrowseDataCubit(this.mainLayoutRepo) : super(FetchDataInitial());
  final MainLayoutRepo mainLayoutRepo;
  late MoviesResponseDm moviesResponseDm;
  bool isLoading = false;
  int pageNumber = 2;
  ScrollController scrollController = ScrollController();
  late int maxPageNumber;

  Future<void> fetchBrowserData(String url) async {
    emit(FetchDataLoading());
    var result = await mainLayoutRepo.fetchData(url);
    result.fold(
      (left) {
        emit(FetchDataFailure(left.errMessage));
      },
      (right) {
        moviesResponseDm = right;
        maxPageNumber = calculateMaxPageNumber(moviesResponseDm);
        emit(FetchDataSuccess(right.movies!));
      },
    );
  }

  int calculateMaxPageNumber(MoviesResponseDm moviesResponseDm) {
    return (moviesResponseDm.movieCount! / moviesResponseDm.limit!.toInt())
        .ceil();
  }

  loadMoreData(String category) async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        pageNumber <= maxPageNumber) {
      print(pageNumber);
      isLoading = true;
      await fetchBrowserData(
        "https://yts.mx/api/v2/list_movies.json?genre=$category&page=$pageNumber",
      );
      pageNumber++;
      isLoading = false;
    }
  }
}
