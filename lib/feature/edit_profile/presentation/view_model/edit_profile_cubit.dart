import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/edit_profile/data/repo/edit_profile_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.editProfileRepo) : super(EditProfileInitial());
  final EditProfileRepo editProfileRepo;
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoading());
    var result = await editProfileRepo.resetPassword(email);
    result.fold(
      (left) {
        emit(ResetPasswordFailure(left.errMessage));
      },
      (right) {
        emit(ResetPasswordSuccess());
      },
    );
  }

  Future<void> updateData(UserDm userInfo) async {
    if (formKey.currentState!.validate()) {
      emit(UpdateDataLoading());
      var result = await editProfileRepo.updateUserInfo(userInfo);
      result.fold(
        (left) {
          emit(UpdateDataFailure(left.errMessage));
        },
        (right) {
          emit(UpdateDataSuccess());
        },
      );
    }
  }

  Future<void> deleteAccount(String userID) async {
    emit(DeleteAccountLoading());
    var result = await editProfileRepo.deleteAccount(userID);
    result.fold((left) {
      emit(DeleteAccountFailure(left.errMessage));
    }, (right) {
      print("object");
      print("_______________________________");
      emit(DeleteAccountSuccess());
    });
  }
}
