import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/authentication/data/data_source/data_source.dart';
import 'package:movies/feature/authentication/data/repo/auth_repo.dart';

class AuthRepoImplement extends AuthRepo {
  AuthRepoImplement(this.dataSource);
  final DataSource dataSource;
  @override
  Future<Either<Failure, UserDm>> createUserAccount(
    UserDm userDm,
    String password,
  ) async {
    var result =  await dataSource.register(userDm, password);
    return result;
  }

  @override
  Future<Either<Failure, UserDm>> loginWithEmail(
    String email,
    String password,
  ) async {
  var result = await  dataSource.login(email, password);
  return result;
  }

  @override
  Future<Either<Failure, UserCredential?>> signInWithGoogle() async{
    try{
     UserCredential? user =  await FirebaseService.signInWithGoogle();
      return Right(user);
    }catch(e){
      if(e is FirebaseException){
        return Left(FireBaseFailure(e.code));
      }
      return Left(FireBaseFailure("please try later"));
    }
  }
}
