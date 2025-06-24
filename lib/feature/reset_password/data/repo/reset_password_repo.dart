import 'package:either_dart/either.dart';
import 'package:movies/core/failure/failure.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failure,void>>resetPassword(String oldPassword, String newPassword);

}