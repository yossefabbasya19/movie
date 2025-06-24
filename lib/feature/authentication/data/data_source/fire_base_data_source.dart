import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/authentication/data/data_source/data_source.dart';

class FireBaseDataSource extends DataSource {
  @override
  Future<Either<Failure, UserDm>> login(String email, String password) async {
    try {
      UserDm userDm = await FirebaseService.loginWithEmail(email, password);
      return Right(userDm);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FireBaseFailure.fromLogin(e));
      }
      return Left(FireBaseFailure("please try later"));
    }
  }

  @override
  Future<Either<Failure, UserDm>> register(
    UserDm userDm,
    String password,
  ) async {
    try {
      UserDm user = await FirebaseService.createUserAccount(userDm, password);
      return Right(user);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FireBaseFailure.fromCreateAccount(e));
      }
      return Left(FireBaseFailure("please try later"));
    }
  }
}
