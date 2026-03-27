import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../entities/response_data.dart';
import '../../models/user.dart';
import '../auth_repository.dart';
import '../../api/auth_api.dart';



class ApiAuthRepository extends AuthRepository {

  @override
Future<ResponseData> loginWithEmail(data) async {
  final api = AuthApi();
  final response = await api.loginWithEmail(data);

  if (!response.success) return response;


  if (response.success == null || response.data is! Map) {
    return ResponseData.customError(
      message: "Réponse serveur invalide",
    );
  }

  bool success = await _login(response.data);

  return success
      ? response
      : ResponseData.customError(message: 'Erreur traitement login');
}

  @override
  Future<ResponseData> register(data) async {
    final api = AuthApi();
    final response = await api.registerWithEmail(data);
    return response;
  }

  @override
  Future<ResponseData> logout() async {
    final api = AuthApi();
    final response = await api.logout();

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
    }catch(e) {
      e.printError();
    }

    if(response.success) {
      saveToken(null);
      saveUser(null);
    }
    return response;
  }

  @override
  Future<ResponseData> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? login = await googleSignIn.signIn();

    if(login == null) return ResponseData.customError(message: 'Okay');

    final GoogleSignInAuthentication authentication = await login.authentication;

    Map data = {
      'access_token': authentication.accessToken,
      'name': login.displayName,
      'email': login.email,
    };

    final response = await AuthApi().loginWithGoogle(data);
    if(response.error) {
      googleSignIn.signOut();
      return response;
    }

    bool success = await _login(response.data);
    return success ? response : ResponseData.customError(message: 'erreur');
  }

  @override
  Future<ResponseData> loginWithPhone(Map data) {
    return AuthApi().loginWithPhone(data);
  }

  @override
  Future<ResponseData> loginWithPhoneVerification(Map data) async {
    final response = await AuthApi().loginPhoneVerification(data);
    if(!response.success) return response;

    bool success = await _login(response.data);
    return success ? response : ResponseData.customError(message: 'erreur');
  }

  @override
  Future<ResponseData> forgetPasswordVerification(Map data) {
    return AuthApi().forgetPasswordVerification(data);
  }

  @override
  Future<ResponseData> forgotPassword(Map data) {
    return AuthApi().forgotPassword(data);
  }

  @override
  Future<ResponseData> resetPassword(Map data) {
    return AuthApi().resetPassword(data);
  }

  @override
  Future<ResponseData> registerVerification(Map data) async {
    final response = await AuthApi().registerVerification(data);
    if(!response.success) return response;

    bool success = await _login(response.data);
    return success ? response : ResponseData.customError(message: 'erreur');
  }

  @override
  Future<bool> fetchUser() async {
    final response = await AuthApi().user();
    if(!response.success) return false;

    try {
      saveUser(response.data);
      return true;
    }catch(e) {
      return false;
    }
  }

  @override
  Future<bool> storeFcmToken(String token) async {
    final response = await AuthApi().saveFcmToken({'token' : token});
    return response.success;
  }

  Future<bool> _login(Map data) async {
    try {
      saveUser(User.fromJson(data['user']));
      saveToken(data['token']);
      // final token = await FirebaseMessaging.instance.getToken();
      // bool success = await storeFcmToken(token!);
      // if(!success) return false;
      return true;
    } catch(e) {
      saveToken(null);
      saveUser(null);
      return false;
    }
  }

}