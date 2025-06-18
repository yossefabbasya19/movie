import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

 class Failure {
  final String errMessage;

  Failure(this.errMessage);
}

class FireBaseFailure extends Failure {
  FireBaseFailure(super.errMessage);

  factory FireBaseFailure.fromCreateAccount(FirebaseException fireBaseEx) {
    if (fireBaseEx.code == 'weak-password') {
      return FireBaseFailure("The password provided is too weak.");
    } else if (fireBaseEx.code == 'email-already-in-use') {
      return FireBaseFailure("The account already exists for that email.");
    }
    return FireBaseFailure(fireBaseEx.code);
  }
  factory FireBaseFailure.fromLogin(FirebaseException fireBaseEx) {
    if (fireBaseEx.code == 'user-not-found') {
      return FireBaseFailure('No user found for that email.');
    } else if (fireBaseEx.code == 'wrong-password') {
      return FireBaseFailure('Wrong password provided for that user.');
    }
    return FireBaseFailure(fireBaseEx.code);
  }
}
class ServerFailure extends Failure{
  ServerFailure(super.errMessage);
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("connection Timeout");
      case DioExceptionType.sendTimeout:
        return ServerFailure("send Timeout");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("receive Timeout");
      case DioExceptionType.badCertificate:
        return ServerFailure("bad Certificate");
      case DioExceptionType.badResponse:
        return ServerFailure.forBadResponse(dioException);
      case DioExceptionType.cancel:
        return ServerFailure("your Requests is cancel, plz try later");
      case DioExceptionType.connectionError:
        return ServerFailure("your Requests is cancel, plz try later");
      case DioExceptionType.unknown:
        return ServerFailure("your Requests is cancel, plz try later");
    }
  }

  factory ServerFailure.forBadResponse(DioException dioException) {

    if (dioException.response!.statusCode == 404) {
      return ServerFailure("your request not founded");
    } else if (dioException.response!.statusCode == 500) {
      return ServerFailure("internal server error ,plz later again");
    }
    return ServerFailure("ops there is error , plz try later1");
  }

}
