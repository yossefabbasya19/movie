part of 'fetch_home_data_with_category_cubit.dart';

@immutable
sealed class FetchHomeDataWithCategoryState {}

final class FetchHomeDataWithCategoryInitial extends FetchHomeDataWithCategoryState {}
final class FetchHomeDataWithCategoryFailure extends FetchHomeDataWithCategoryState {
  final String errMessage;

  FetchHomeDataWithCategoryFailure(this.errMessage);
}

final class FetchHomeDataWithCategorySuccess extends FetchHomeDataWithCategoryState {
}

final class FetchHomeDataWithCategoryLoading extends FetchHomeDataWithCategoryState {}