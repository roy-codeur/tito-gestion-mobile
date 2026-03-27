// login_state.dart
part of 'login_cubit.dart';

class LoginState {
  // ✅ Tous les champs sont final — immutable
  final String  email;
  final String  password;
  final bool    loading;
  final bool    obscurePassword;
  final String? emailError;
  final String? passwordError;
  final String? errorMessage;
  final bool navigatedToHome;
  final int errorId;

  const LoginState({
    this.email           = '',
    this.password        = '',
    this.loading         = false,
    this.obscurePassword = true,
    this.emailError,
    this.passwordError,
    this.errorMessage,
    this.navigatedToHome = false,
    this.errorId = 0,
  });

  bool get isValidForm => emailError == null && passwordError == null
      && email.isNotEmpty && password.isNotEmpty;

  // ✅ clearXError permet de passer null explicitement
  LoginState copyWith({
    String?  email,
    String?  password,
    bool?    loading,
    bool?    obscurePassword,
    String?  emailError,
    String?  passwordError,
    String?  errorMessage,
    bool     clearEmailError    = false,
    bool     clearPasswordError = false,
    bool     clearErrorMessage  = false,
    bool? navigatedToHome,
    int? errorId,
  }) {
    return LoginState(
      email:           email           ?? this.email,
      password:        password        ?? this.password,
      loading:         loading         ?? this.loading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      emailError:      clearEmailError    ? null : emailError    ?? this.emailError,
      passwordError:   clearPasswordError ? null : passwordError ?? this.passwordError,
      errorMessage:    clearErrorMessage  ? null : errorMessage  ?? this.errorMessage,
      navigatedToHome: navigatedToHome ?? this.navigatedToHome,
      errorId: errorId ?? this.errorId,
    );
  }
}