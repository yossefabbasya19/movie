import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:movies/core/api_service/api_service.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/feature/edit_profile/data/data_source/data_source.dart';

class EditProfileApiDataSource extends DataSource {
  @override
  Future<Either<Failure, void>> deleteUser(String userInfo) async {
    try {
      Map<String, dynamic> message = await ApiService.delete(
        "https://route-movie-apis.vercel.app/profile",
        SharedPref().userToken!,
      );
      UserDm.currentUser = null;
      SharedPref().removeToken();
      return Right(null);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UserDm userInfo) async{
    try {
      await ApiService.patch("https://route-movie-apis.vercel.app/profile", {
        "name" : userInfo.userName,
        "phone" : "+2${userInfo.phoneNumber}",
      });
      UserDm.currentUser = userInfo;
      return Right(null);
    } on Exception catch (e) {
      if(e is DioException){
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
