import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<UserEntity> call(String name, String email, String password, String confirmPassword) {
    return repository.register(name, email, password, confirmPassword);
  }
}