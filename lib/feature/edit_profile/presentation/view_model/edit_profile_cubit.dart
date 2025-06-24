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
  int selectAvatar = UserDm.currentUser!.avatar;


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
      emit(DeleteAccountSuccess());
    });
  }
  String formatPhoneNumber(String phone)   {
    if(phone.contains("+2")){
     return phone.substring(2);
    }
    return phone;
  }
}
