import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:movies/core/api_service/api_service.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

class MainLayoutRepoImplements extends MainLayoutRepo {
  @override
  Future<Either<Failure, MoviesResponseDm>> fetchData(String url) async {
    try {
      Map<String, dynamic> response = await ApiService.get(url);
      MoviesResponseDm moviesResponseDm = MoviesResponseDm.fromJson(response);
      return Right(moviesResponseDm);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure("please try later"));
    }
  }

  @override
  Future<Either<Failure, Movies>> fetchMovieByID(String url) async {
    try {
      Map<String, dynamic> dataFromApi = await ApiService.get(url);
      Movies movie = Movies.fromJson(dataFromApi["movie"]);
      return Right(movie);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure("please try later"));
    }
  }
}
