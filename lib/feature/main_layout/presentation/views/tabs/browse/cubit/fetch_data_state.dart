part of 'fetch_data_cubit.dart';

@immutable
sealed class FetchDataState {}

final class FetchDataInitial extends FetchDataState {}
final class FetchDataLoading extends FetchDataState {}
final class FetchDataFailure extends FetchDataState {
  final String errMessage;

  FetchDataFailure(this.errMessage);
}
final class FetchDataSuccess extends FetchDataState {
  final List<Movies> movies;

  FetchDataSuccess(this.movies);
}
