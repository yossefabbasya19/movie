import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/api_service/api_service.dart';
import 'package:movies/feature/reset_password/data/repo/reset_password_repo.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this.resetPasswordRepo) : super(ResetPasswordInitial());
  final ResetPasswordRepo resetPasswordRepo;

  Future<void> resetPassword(String oldPassword, String newPassword) async {
  emit(ResetPasswordLoading());
    var result =  await  resetPasswordRepo.resetPassword(oldPassword, newPassword);
  result.fold((left) {
    emit(ResetPasswordFailure(left.errMessage));
  }, (right) {
    emit(ResetPasswordSuccess());
  },);
  }
}
