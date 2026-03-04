import 'package:dio/dio.dart';
import 'package:startkit_app/core/constants/app_config.dart';

class DioClient {
  final Dio dio;

  DioClient._(this.dio);

  static DioClient create() {
    final dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ));

    return DioClient._(dio);
  }
}
