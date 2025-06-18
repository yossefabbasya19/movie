import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/authentication/data/repo/auth_repo.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit(this.authRepo) : super(CreateAccountInitial());
  final AuthRepo authRepo;

  Future<void> createAccount(UserDm userDm, String password) async {
    emit(CreateAccountLoading());
    var result = await authRepo.createUserAccount(userDm, password);
    result.fold(
      (left) {
        emit(CreateAccountFailure(left.errMessage));
      },
      (right) {
        emit(CreateAccountSuccess(right));
      },
    );
  }
}
