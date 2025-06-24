import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';

abstract class DataSource {
  Future<Either<Failure,UserDm>>login( String email,
      String password,);
  Future<Either<Failure,UserDm>>register(UserDm userDm,String password);
}