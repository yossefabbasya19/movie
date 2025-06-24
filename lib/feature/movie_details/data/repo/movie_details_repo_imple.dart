import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:movies/core/api_service/api_service.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';
import 'package:movies/feature/movie_details/data/repo/movie_details_repo.dart';

class MovieDetailsRepoImple extends MovieDetailsRepo {
  @override
  Future<Either<Failure, Data>> getMovieDetails(String movieID) async {
    try {
      Map<String, dynamic> data = await ApiService.get(
        "https://yts.mx/api/v2/movie_details.json?movie_id=$movieID&with_images=true&with_cast=true",
      );
      Data movie = Data.fromJson(data);
      return Right(movie);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MoviesResponseDm>> getMovieSuggestionsDetails(
    String movieID,
  ) async {
    try {
      var response = await ApiService.get(
        "https://yts.mx/api/v2/movie_suggestions.json?movie_id=$movieID",
      );
      MoviesResponseDm moviesResponseDm = MoviesResponseDm.fromJson(response);
      return Right(moviesResponseDm);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
