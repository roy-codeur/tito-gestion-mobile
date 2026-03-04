
import 'package:dio/dio.dart';
import 'package:startkit_app/core/errors/api_exception.dart';
import '../../../../core/api/api_client.dart';


abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> register(String name, String email, String password, String confirmPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;

  AuthRemoteDataSourceImpl(this.dioClient);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {

    try {

    final response = await dioClient.dio.post(
      '/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(
          message: e.response?.data['message'] ?? 'Unknown error',
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ApiException(
          message: e.message ?? 'une erreur est survenue',
          statusCode: 0
          );
      }
     
    }
  }

  @override
  Future<Map<String, dynamic>> register(String name, String email, String password, String confirmPassword) async {
    try {
    final response = await dioClient.dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'confirm_password': confirmPassword,
      },
    );
    return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw ApiException(
          message: e.response?.data['message'] ?? 'Unknown error',
          statusCode: e.response?.statusCode,
        );
      } else {
        throw ApiException(
          message: e.message ?? 'une erreur est survenue',
          statusCode: 0
          );    

          }
    }
    }
 



}
