import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/firebase_servise/firebase_service.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/feature/edit_profile/data/data_source/data_source.dart';
import 'package:movies/feature/edit_profile/data/repo/edit_profile_repo.dart';

class EditProfileRepoImple extends EditProfileRepo {
  final DataSource dataSource ;

  EditProfileRepoImple(this.dataSource);
  @override
  Future<Either<Failure, void>> updateUserInfo(UserDm userInfo) async {
    return await dataSource.updateUser(userInfo);
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String userID) async {
    return await dataSource.deleteUser(userID);
  }
}
