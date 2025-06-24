import 'package:either_dart/src/either.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/feature/reset_password/data/data_source/reset_password_data_source.dart';
import 'package:movies/feature/reset_password/data/repo/reset_password_repo.dart';

class ResetPasswordRepoImple extends ResetPasswordRepo {
  final ResetPasswordDataSource dataSource;

  ResetPasswordRepoImple(this.dataSource);

  @override
  Future<Either<Failure, void>> resetPassword(
    String oldPassword,
    String newPassword,
  ) async {
    return await dataSource.resetPassword(oldPassword, newPassword);
  }
}
