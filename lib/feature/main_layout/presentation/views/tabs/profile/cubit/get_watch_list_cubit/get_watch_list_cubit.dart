import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

part 'get_watch_list_state.dart';

class GetWatchListAndHistoryCubit extends Cubit<GetWatchListState> {
  GetWatchListAndHistoryCubit(this.mainLayoutRepo) : super(GetWatchListInitial());
  final MainLayoutRepo mainLayoutRepo;
  late List<Movies> watchList ;
  late List<Movies> historyList ;

  Future<void> getWatchList(List moviesIDs) async {
    watchList =[];
    emit(GetWatchListLoading());
    for (var item in moviesIDs) {
      //print(item);
      var result = mainLayoutRepo.fetchMovieByID(
        "https://yts.mx/api/v2/movie_details.json?movie_id=$item",
      );
      await result.fold(
        (left) {
          emit(GetWatchListFailure(left.errMessage));
        },
        (right) {
          watchList.add(right);

        },
      );
    }
    emit(GetWatchListSuccess());
  }
  Future<void> getHistoryList(List moviesIDs) async {
    historyList =[];
    emit(GetWatchListLoading());
    for (var item in moviesIDs) {
      //print(item);
      var result = mainLayoutRepo.fetchMovieByID(
        "https://yts.mx/api/v2/movie_details.json?movie_id=$item",
      );
      await result.fold(
            (left) {
          emit(GetWatchListFailure(left.errMessage));
        },
            (right) {
          historyList.add(right);

        },
      );
    }
    emit(GetWatchListSuccess());
  }
}
