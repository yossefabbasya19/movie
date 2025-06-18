part of 'fetch_search_data_cubit.dart';

@immutable
sealed class FetchSearchDataState {}

final class FetchSearchDataInitial extends FetchSearchDataState {}
final class FetchSearchDataLoading extends FetchSearchDataState {}
final class FetchSearchDataSuccess extends FetchSearchDataState {
  final List<Movies> movies;

  FetchSearchDataSuccess(this.movies);
}
final class FetchSearchDataFailure extends FetchSearchDataState {
  final String errMessage;

  FetchSearchDataFailure(this.errMessage);
}
