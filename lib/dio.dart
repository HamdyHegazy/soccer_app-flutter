import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init({required String url}) {
    dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: url,
    ));
  }

  static Future<Response> getData({
    required String path,
    required Map<String, dynamic> params,
  }) {
    return dio!.get(path, queryParameters: params);
  }
}

class DioHelperr {
  static Dio? dio;

  static void init({required String url}) {
    dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: url,
    ));
  }

  static Future<Response> getData({
    required String path,
    required Map<String, dynamic> params,
  }) {
    print("your data is here");
    return dio!.get(path, queryParameters: params);
  }
}
