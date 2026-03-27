import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:get_it/get_it.dart';
import '../../logic/observables/auth_observable.dart';
import '../entities/response_data.dart';
import '../models/user.dart';

abstract class AuthRepository {

  final box = GetStorage();

  Future<ResponseData> logout();
  Future<ResponseData> loginWithEmail(Map data);
  Future<ResponseData> loginWithGoogle();
  Future<ResponseData> loginWithPhone(Map data);
  Future<ResponseData> loginWithPhoneVerification(Map data);

  Future<ResponseData> register(Map data);
  Future<ResponseData> registerVerification(Map data);

  Future<ResponseData> forgotPassword(Map data);
  Future<ResponseData> forgetPasswordVerification(Map data);
  Future<ResponseData> resetPassword(Map data);

  Future<bool> fetchUser();
  Future<bool> storeFcmToken(String token);

  User? getUser() {
    var json = box.read('auth');
    try {
      return json != null ? User.fromJson(jsonDecode(json.toString())) : null;
    } catch(e, s) {
      print(s);
      return null;
    }
  }

  void saveUser(User? user) {
    box.write('auth', jsonEncode(user?.toJson()));
    GetIt.I.get<AuthObservable>().notify(user);
  }

  void saveToken(String? token) {
    box.write('token', token);
  }

}