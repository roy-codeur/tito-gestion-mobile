import 'package:get_it/get_it.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import '../../logic/observables/auth_observable.dart';

class AuthDao extends AuthObservable{

  AuthDao() {
    User? user = GetIt.I.get<AuthRepository>().getUser();
    notify(user);
  }

}