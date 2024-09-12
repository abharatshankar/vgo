import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../utils/dio_utils.dart';
import '../../utils/utils.dart';
import 'api_config.dart';

class Services {
  static final Services instance = Services();
  Response? response;

  retryScreen(){
  /*  if(!(_isFromRetryScreen ?? false)){
      Navigator.push(
        CommonUtils.instance.globalContext!,
        MaterialPageRoute(
            builder: (context) =>
            const RetryScreen()),
      );
    }*/
  }

  Future<bool> hasNetworkAvailable({bool isFromRetryScreen = false}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void getRequest(String path,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i("Api $path\n Method---> GET\n");
      response = await dio.get(path);
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      //retryScreen();
    }
  }

  void getRequestBody(String path, Object requestParams,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i(
          "Api ${APIConfig.baseUrl + path}\nParams $requestParams\n Method---> GET\n");
      response = await dio.get(
        path,
        data: requestParams,
      );
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void getRequestPath(String path,
      {required String id,
      required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i("Api $path\n Method---> GET\n");
      response = await dio.get(('$path/$id'));
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void putRequest(String path,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i("Api $path\n Method---> PUT\n");
      response = await dio.put(path, data: {'name': 'tas', 'job': 'leader'});
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void patchRequest(String path,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i("Api $path\n Method---> PUT\n");
      response = await dio.patch(path, data: {'name': 'tas', 'job': 'leader'});
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void postRequest(String path, Object requestParams,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i(
          "Api ${APIConfig.baseUrl + path}\nParams $requestParams\n Method---> POST\n");
      response = await dio.post(
        path,
        data: requestParams,
      );
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void postRequestWithoutRequest(String path,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i("Api ${APIConfig.baseUrl + path} \n Method---> POST\n");
      response = await dio.post(
        path,
      );
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void deleteRequest(String path,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      response = await dio.delete(path);
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void deleteRequestQueryParams(String path,
      {required int id,
      required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      var dio = await DioUtils.instance.getDioInstance();
      loggerNoStack.i("Api $path\n Method---> DELETE\n");
      response = await dio.delete(('$path/$id'));
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void putMethodWithRequest(String path, Object requestParams,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      loggerNoStack.i(
          "Api ${APIConfig.baseUrl + path}\nParams $requestParams\n Method---> POST\n");
      var dio = await DioUtils.instance.getDioInstance();
      response = await dio.put(
        path,
        data: requestParams,
      );
      loggerNoStack.i("Response $response");
      completion(response);
    } else {
      retryScreen();
    }
  }

  void uploadImage(String path, CroppedFile file,
      {required Function(Response? reponse) completion}) async {
    if (await hasNetworkAvailable()) {
      loggerNoStack.i("Api ${APIConfig.baseUrl + path}");
      var dio = await DioUtils.instance.getDioInstance();
      String fileName = (file.path ?? '').split('/').last;
      FormData formData = FormData.fromMap({
        "sendimage":
            await MultipartFile.fromFile(file.path ?? '', filename: fileName),
      });
      response = await dio.post(path, data: formData);
      completion(response);
    } else {
      retryScreen();
    }
  }
}
