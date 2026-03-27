import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import 'dart:convert';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // ✅ Injecté via constructeur, pas récupéré en interne
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  // ── Setters ───────────────────────────────────────────────────────────────

  void setEmail(String? value) {
    emit(state.copyWith(
      email:      value ?? '',
      emailError: _validateEmail(value),
      clearEmailError: value?.isNotEmpty == true && _validateEmail(value) == null,
    ));
  }

  void setPassword(String? value) {
    emit(state.copyWith(
      password:      value ?? '',
      passwordError: _validatePassword(value),
      clearPasswordError: value?.isNotEmpty == true && _validatePassword(value) == null,
    ));
  }

  void togglePasswordVisibility() =>
      emit(state.copyWith(obscurePassword: !state.obscurePassword));

  // ── Validation ────────────────────────────────────────────────────────────

  // Retourne true si le formulaire est valide
  bool _validateAll() {
    final emailError    = _validateEmail(state.email);
    final passwordError = _validatePassword(state.password);

    emit(state.copyWith(
      emailError:         emailError,
      passwordError:      passwordError,
      clearEmailError:    emailError    == null,
      clearPasswordError: passwordError == null,
    ));

    return emailError == null && passwordError == null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "L'email ne peut pas être vide";
    if (!GetUtils.isEmail(value))       return "L'email n'est pas valide";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty)        return "Le mot de passe ne peut pas être vide";
    if (GetUtils.isLengthLessThan(value, 8))   return "Le mot de passe doit contenir au moins 8 caractères";
    return null;
  }

  // ── Actions ───────────────────────────────────────────────────────────────

  Future<void> login() async {
    // ✅ Valide d'abord, charge ensuite
    if (!_validateAll()) return;

    emit(state.copyWith(loading: true));

    Map data = {
      'email': state.email,
      'password': state.password
    };

    try {
      final response = await _authRepository.loginWithEmail(data);


      if (!response.success) {
        emit(state.copyWith(
          loading:       false,
          errorMessage:  response.message,
          errorId: state.errorId + 1,
        ));
        return;
      }

     emit(state.copyWith(loading: false, navigatedToHome: true));
      

    } catch (e) {
      emit(state.copyWith(
        loading:      false,
        errorMessage: "Une erreur : $e.message",
        errorId: state.errorId + 1,
      ));
      print("$e.message");
    }
  }

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(loading: true));
    try {
      final response = await _authRepository.loginWithGoogle();

      if (response.error) {
        emit(state.copyWith(
          loading:      false,
          errorMessage: "Connexion Google échouée.",
        ));
        return;
      }

      emit(state.copyWith(loading: false));
      Get.offAllNamed('/home');

    } catch (e) {
      emit(state.copyWith(
        loading:      false,
        errorMessage: "Une erreur est survenue, veuillez réessayer.",
      ));
    }
  }
}