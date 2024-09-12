import 'package:dio/dio.dart';

import '../network/api/api_config.dart';

class DioUtils {
  static final DioUtils instance = DioUtils();

  Future<Dio> getDioInstance() async {
    return Dio(BaseOptions(
        baseUrl: APIConfig.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        responseType: ResponseType.json,
        contentType: "application/json"));
  }

/*  Future<Dio> getDioInstance() async {
    var token = await SessionManager.getAccessToken();
    if (token != null && token.isNotEmpty) {
      return Dio(BaseOptions(
          baseUrl: APIConfig.baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          responseType: ResponseType.json,
          contentType: "application/json",
          headers: {"access_key": token}));
    } else {
      return Dio(BaseOptions(
          baseUrl: APIConfig.baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          responseType: ResponseType.json,
          contentType: "application/json"));
    }
  }*/
}
