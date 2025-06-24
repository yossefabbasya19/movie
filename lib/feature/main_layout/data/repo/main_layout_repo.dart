import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';

abstract class MainLayoutRepo {
 Future<Either<Failure,MoviesResponseDm>> fetchData(String url);
 Future<Either<Failure,Movies>> fetchMovieByID(String url);
 Future<Either<Failure,void>> getUserInfo(String token);

}