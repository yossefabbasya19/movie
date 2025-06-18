import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

part 'fetch_home_data_state.dart';

class FetchHomeDataCubit extends Cubit<FetchHomeDataState> {
  FetchHomeDataCubit(this.mainLayoutRepo) : super(FetchHomeDataInitial());
  final MainLayoutRepo mainLayoutRepo;
  List<Movies> movies = [];

  Future<void> fetchHomeData(String url) async {
    emit(FetchHomeDataLoading());
    var result = await mainLayoutRepo.fetchData(url);
    result.fold(
          (left) {
        emit(FetchHomeDataFailure(left.errMessage));
      },
          (right) {
        movies = right.movies!;
        emit(FetchHomeDataSuccess());
      },
    );
  }

}
