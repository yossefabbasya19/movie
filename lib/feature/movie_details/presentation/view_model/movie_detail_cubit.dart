import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:either_dart/src/either.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';
import 'package:movies/feature/movie_details/data/repo/movie_details_repo.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this.movieDetailsRepo) : super(MovieDetailInitial());
  final MovieDetailsRepo movieDetailsRepo;
  late Data movieData;
  late List<Movies>? movieSuggestion;

  Future<void> getMovieDetails(String movieID) async {
    emit(MovieDetailLoading());
    Either<Failure, Data> result = await movieDetailsRepo.getMovieDetails(
      movieID,
    );
    result.fold(
      (left) {
        emit(MovieDetailFailure(left.errMessage));
      },
      (right) {
        movieData = right;
        emit(MovieDetailSuccess(right));
      },
    );
  }

  Future<void> getMovieSuggestionsDetails(String movieID) async {
    emit(MovieDetailSuggestionLoading());
    var result = await movieDetailsRepo.getMovieSuggestionsDetails(movieID);
    result.fold(
      (left) {
        emit(MovieDetailSuggestionFailure(left.errMessage));
      },
      (right) {
        movieSuggestion = right.movies;
        emit(MovieDetailSuggestionSuccess(right.movies!));
      },
    );
  }
}
