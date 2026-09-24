import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://randomuser.me/api/',

      // API ko connect hone ke liye time
      connectTimeout: const Duration(seconds: 30),

      // Response receive hone ke liye time
      receiveTimeout: const Duration(seconds: 60),
    ),
  )
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: false,
        responseHeader: false,
        responseBody: false,
        error: true,
      ),
    );
}