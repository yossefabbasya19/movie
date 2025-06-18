import 'package:dio/dio.dart';

abstract class ApiService {
  static Dio dio = Dio();

  static Future<Map<String,dynamic>> get(String url) async {
    Response response = await dio.get(url);
    return response.data["data"];
  }
}
