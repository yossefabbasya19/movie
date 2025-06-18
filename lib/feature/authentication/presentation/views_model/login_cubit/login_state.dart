part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginWithGoogleInitial extends LoginState {}
final class LoginWithGoogleLoading extends LoginState {}
final class LoginWithGoogleFailure extends LoginState {
  final String errMessage;

  LoginWithGoogleFailure(this.errMessage);
}
final class LoginWithGoogleSuccess extends LoginState {}
final class LoginLoading extends LoginState {}
final class LoginSuccess extends LoginState {
  final UserDm? userDm;

  LoginSuccess(this.userDm);

}
final class LoginFailure extends LoginState {
  final String errMessage;

  LoginFailure(this.errMessage);
}
