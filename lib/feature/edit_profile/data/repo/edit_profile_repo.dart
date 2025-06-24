import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';

abstract class EditProfileRepo {
Future<Either<Failure,void>>  updateUserInfo(UserDm userInfo);
Future<Either<Failure,void>>  deleteAccount(String userID);
}