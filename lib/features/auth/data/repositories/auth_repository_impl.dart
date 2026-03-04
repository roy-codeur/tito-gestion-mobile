import 'package:startkit_app/core/errors/api_exception.dart';
import 'package:startkit_app/core/errors/failure.dart';
import 'package:startkit_app/core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../datasources/auth_local_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
    required this.networkInfo,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    // if (!await networkInfo.isConnected) {
    //   throw Exception('No internet connection');
    // }
    try {
          // 1️⃣ Appel API
    final data = await remote.login(email, password);
        // 2️⃣ Sauvegarde du token
    await local.saveToken(data['token'].toString());

    // 3️⃣ Mapping Model → Entity
    return UserModel.fromJson(data['user']);
    
    } on ApiException catch (e) {
      if (e.statusCode !=  null) {        
        throw AuthFailure.fromStatusCode( e.statusCode ?? 0 , e.message ?? '');
      } else {
        throw AuthFailure.fromStatusCode(e.statusCode ?? 0, e.message ?? 'une erreur est survenue');
      }
    } catch (e) {
      throw ApiException(message: 'une erreur est survenue');
    }
  } 

  @override
  Future<UserEntity> register(String name,  String email, String password, String confirmPassword) async {
    try {
      final data = await remote.register(name, email, password, confirmPassword);
      await local.saveToken(data['token'].toString());
      return UserModel.fromJson(data['user']);
    } on ApiException catch (e) {
      if (e.statusCode !=  null) {        
        throw AuthFailure.fromStatusCode( e.statusCode ?? 0 , e.message ?? '');
      } else {
        throw AuthFailure.fromStatusCode(e.statusCode ?? 0, e.message ?? 'une erreur est survenue');
      }
    } catch (e) {
      throw ApiException(message: 'une erreur est survenue');
    } 
  }
}
