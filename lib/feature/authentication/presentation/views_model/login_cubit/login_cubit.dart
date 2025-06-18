import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/feature/authentication/data/repo/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  final AuthRepo authRepo;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    var result = await authRepo.loginWithEmail(email, password);
    result.fold(
      (left) {
        emit(LoginFailure(left.errMessage));
      },
      (right) {
        emit(LoginSuccess(right));
      },
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    emit(LoginWithGoogleLoading());
    Either<Failure, UserCredential?> result = await authRepo.signInWithGoogle();
    result.fold(
      (left) {
        emit(LoginWithGoogleFailure(left.errMessage));
      },
      (right) {
        if(right == null) {
          emit(LoginWithGoogleInitial());
          return;
        }
        Navigator.pushReplacementNamed(context,MyRoutes.mainLayout);
        emit(LoginWithGoogleSuccess());
      },
    );
  }
}
