import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/edit_profile/data/data_source/data_source.dart';

 class EditProfileFireBaseDataSource extends DataSource {
  Future<Either<Failure, void>> updateUser(UserDm userInfo)async{
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
  Future<Either<Failure, void>> deleteUser(String userID)async{
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