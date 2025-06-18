import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/edit_profile/data/repo/edit_profile_repo.dart';

class EditProfileRepoImple extends EditProfileRepo {
  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await FirebaseService.resetPassword(email);
      return Right(null);
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        return Left(FireBaseFailure(e.message!));
      }
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserInfo(UserDm userInfo) async {
    try {
      await FirebaseService.addUserToFireStore(userInfo);
      UserDm.currentUser = userInfo;
      return Right(null);
    } on Exception catch (e) {
      if (e is FirebaseException) {
        return Left(FireBaseFailure(e.message!));
      }
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String userID) async {
    try {
      await FirebaseService.deleteAccount(userID);
      return Right(null);
    } on Exception catch (e) {
      if (e is FirebaseException) {
        return Left(FireBaseFailure(e.message!));
      }
      return Left(Failure(e.toString()));
    }
  }
}
