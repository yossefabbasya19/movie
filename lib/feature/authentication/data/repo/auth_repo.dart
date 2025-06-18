import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserDm>> createUserAccount(
    UserDm userDm,
    String password,
  );
  Future<Either<Failure, UserDm>> loginWithEmail(
      String email,
      String password,
      );
  Future<Either<Failure, UserCredential?>> signInWithGoogle();
}
