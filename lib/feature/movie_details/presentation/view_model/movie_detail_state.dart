part of 'movie_detail_cubit.dart';

@immutable
sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}
final class MovieDetailLoading extends MovieDetailState {}
final class MovieDetailSuccess extends MovieDetailState {
 final  Data data;

  MovieDetailSuccess(this.data);
}
final class MovieDetailFailure extends MovieDetailState {
  final String errorMessage;

  MovieDetailFailure(this.errorMessage);
}
final class MovieDetailSuggestionInitial extends MovieDetailState {}
final class MovieDetailSuggestionLoading extends MovieDetailState {}
final class MovieDetailSuggestionSuccess extends MovieDetailState {
  final  List<Movies> data;

  MovieDetailSuggestionSuccess(this.data);
}
final class MovieDetailSuggestionFailure extends MovieDetailState {
  final String errorMessage;

  MovieDetailSuggestionFailure(this.errorMessage);
}
