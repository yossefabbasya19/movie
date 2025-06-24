import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:movies/core/api_service/api_service.dart';
import 'package:movies/core/failure/failure.dart';
import 'package:movies/feature/reset_password/data/data_source/reset_password_data_source.dart';

class ResetPasswordApiDataSource extends ResetPasswordDataSource {
  Future<Either<Failure, void>> resetPassword(
    String oldPassword,
    String newPassword,
  ) async{
    try{
       await ApiService.patch(
        "https://route-movie-apis.vercel.app/auth/reset-password",
        {"oldPassword": oldPassword, "newPassword": newPassword},
      );
       return Right(null);
    }catch(e){
      if(e is DioException ){
        return Left(ServerFailure.fromDioException(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
