import 'package:dio/dio.dart';
import 'package:either_dart/src/either.dart';
import 'package:movies/core/api_service/api_service.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/feature/authentication/data/data_source/data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiDataSource extends DataSource {
  @override
  Future<Either<Failure, UserDm>> login(String email, String password) async {
    try {
      String token = await ApiService.post(
        "https://route-movie-apis.vercel.app/auth/login",
        {"email": email, "password": password},
      );
      Map<String, dynamic> profileInfo = await ApiService.get(
        "https://route-movie-apis.vercel.app/profile",
        token: token,
      );
      SharedPref().setUserToken(token);
      UserDm.currentUser = UserDm.fromJson(profileInfo);
      UserDm.currentUser!.token = token;
      return Right(UserDm.currentUser!);
    } on Exception catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDm>> register(
    UserDm userDm,
    String password,
  ) async {
    try {
     Map<String,dynamic> response =  await ApiService.post(
        "https://route-movie-apis.vercel.app/auth/register",
        {
          "name": userDm.userName,
          "email": userDm.email,
          "password": password,
          "confirmPassword": password,
          "phone": "+2"+userDm.phoneNumber,
          "avaterId": userDm.avatar,
        },
      );
     UserDm.currentUser = UserDm.fromJson(response);
     return Right(UserDm.currentUser!);
    } catch (e) {
      if(e is DioException){
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(Failure(e.toString()));
    }
  }
}
