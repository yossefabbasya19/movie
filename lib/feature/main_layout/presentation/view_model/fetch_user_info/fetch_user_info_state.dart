part of 'fetch_user_info_cubit.dart';

@immutable
sealed class FetchUserInfoState {}

final class FetchUserInfoInitial extends FetchUserInfoState {}
final class FetchUserInfoLoading extends FetchUserInfoState {}
final class FetchUserInfoSuccess extends FetchUserInfoState {}
final class FetchUserInfoFailure extends FetchUserInfoState {}
