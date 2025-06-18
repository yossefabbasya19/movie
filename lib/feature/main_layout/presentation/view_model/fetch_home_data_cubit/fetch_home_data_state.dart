part of 'fetch_home_data_cubit.dart';

@immutable
sealed class FetchHomeDataState {}

final class FetchHomeDataInitial extends FetchHomeDataState {}

final class FetchHomeDataFailure extends FetchHomeDataState {
  final String errMessage;

  FetchHomeDataFailure(this.errMessage);
}

final class FetchHomeDataSuccess extends FetchHomeDataState {}

final class FetchHomeDataLoading extends FetchHomeDataState {}

