import 'package:dio/dio.dart';
import 'package:movies/core/models/user_Dm.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';

abstract class ApiService {
  static Dio dio = Dio();

  static Future<dynamic> get(String url, {String? token}) async {
    Response response = await dio.get(
      url,
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    return response.data["data"];
  }

  static Future<dynamic> post(String url, Map<String, dynamic> data) async {
    Response response = await dio.post(url, data: data);
    return response.data["data"];
  }

  static Future<dynamic> delete(String url, String token) async {
    Response response = await dio.delete(
      url,
      options: Options(headers: {"authorization": "Bearer $token"}),
    );
    return response.data;
  }

  static Future<dynamic> patch(String url, Map<String, dynamic> data) async {
    Response response = await dio.patch(
      url,
      data: data,
      options: Options(
        headers: {"authorization": "Bearer ${SharedPref().userToken}"},
      ),
    );
    return response.data;
  }
}
