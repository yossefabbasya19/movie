import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/constace.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

part 'fetch_home_data_with_category_state.dart';

class FetchHomeDataWithCategoryCubit
    extends Cubit<FetchHomeDataWithCategoryState> {
  FetchHomeDataWithCategoryCubit(this.mainLayoutRepo)
    : super(FetchHomeDataWithCategoryInitial());
  Map<String, MoviesResponseDm> moviesWithCategory = {};
  final MainLayoutRepo mainLayoutRepo;

   Future<void> fetchHomeDataWithCategory() async {
     for(var item in genres){
    emit(FetchHomeDataWithCategoryLoading());
      var result = await mainLayoutRepo.fetchData(
        "https://yts.mx/api/v2/list_movies.json?genre=${item}&minimum_rating=7&limit=5",
      );
      result.fold(
        (left) {
          emit(FetchHomeDataWithCategoryFailure(left.errMessage));
          return;
        },
        (right) {
          moviesWithCategory[item] = right;
          emit(FetchHomeDataWithCategorySuccess());

        },
      );
     }
  }
}
