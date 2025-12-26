import 'package:startkit_app/core/network/network_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<UserEntity> login(String email, String password) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      throw Exception('No internet connection');
    }

    // Appel au remote
    return await remote.login(email, password);
  }
}
