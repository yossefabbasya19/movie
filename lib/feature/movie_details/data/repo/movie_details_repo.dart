import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';

abstract class MovieDetailsRepo {
  Future<Either<Failure,Data>>getMovieDetails(String movieID) ;
}
