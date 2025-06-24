import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/movie_DM/Movies_response_Dm.dart';
import 'package:movies/feature/movie_details/data/model/Data.dart';

abstract class MovieDetailsRepo {
  Future<Either<Failure,Data>>getMovieDetails(String movieID) ;
  Future<Either<Failure,MoviesResponseDm>>getMovieSuggestionsDetails(String movieID);
}
