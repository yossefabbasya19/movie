part of 'get_watch_list_cubit.dart';

@immutable
sealed class GetWatchListState {}

final class GetWatchListInitial extends GetWatchListState {}
final class GetWatchListSuccess extends GetWatchListState {}
final class GetWatchListLoading extends GetWatchListState {}
final class GetWatchListFailure extends GetWatchListState {
  final String errMessage;

  GetWatchListFailure(this.errMessage);
}
