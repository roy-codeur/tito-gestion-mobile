import '../entities/response_data.dart';
import 'api.dart';

class AuthApi {

  final Api _api = Api();

  Future<ResponseData> loginWithEmail(Map data) async {
     return _api.post('/login', data: data);
  }

  Future<ResponseData> loginWithPhone(Map data) async {
    return _api.post('client/login_with_phone', data: data);
  }

  Future<ResponseData> loginPhoneVerification(Map data) async {
    return _api.post('client/login_phone_verification', data: data);
  }

  Future<ResponseData> loginWithGoogle(Map data) async {
    return _api.post('client/login_with_google', data: data);
  }

  Future<ResponseData> registerWithEmail(Map data) async {
    return _api.post('client/email_register', data: data);
  }

  Future<ResponseData> registerVerification(Map data) async {
    return _api.post('client/email_register_verification', data: data);
  }

  Future<ResponseData> forgotPassword(Map data) async {
    return _api.post('client/forgot-password', data: data);
  }

  Future<ResponseData> forgetPasswordVerification(Map data) async {
    return _api.post('client/forgot-password-verification', data: data);
  }

  Future<ResponseData> resetPassword(Map data) async {
    return _api.post('client/reset-password', data: data);
  }

  Future<ResponseData> logout() async {
    return _api.post('client/logout');
  }

  Future<ResponseData> user() async {
    return _api.post('user');
  }

  Future<ResponseData> saveFcmToken(Map data) async {
    return _api.post('fcm_tokens', data: data);
  }

}