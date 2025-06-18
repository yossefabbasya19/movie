part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class ResetPasswordLoading extends EditProfileState {}
final class ResetPasswordFailure extends EditProfileState {
  final String errMessage;

  ResetPasswordFailure(this.errMessage);
}
final class ResetPasswordSuccess extends EditProfileState {}
final class UpdateDataLoading extends EditProfileState {}
final class UpdateDataFailure extends EditProfileState {
  final String errMessage;

  UpdateDataFailure(this.errMessage);
}
final class UpdateDataSuccess extends EditProfileState {}
final class DeleteAccountLoading extends EditProfileState {}
final class DeleteAccountFailure extends EditProfileState {
  final String errMessage;

  DeleteAccountFailure(this.errMessage);
}
final class DeleteAccountSuccess extends EditProfileState {}
