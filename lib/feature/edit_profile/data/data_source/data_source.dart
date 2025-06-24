import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';

abstract class DataSource {
  Future<Either<Failure, void>> updateUser(UserDm userInfo);
  Future<Either<Failure, void>> deleteUser(String userInfo);
}