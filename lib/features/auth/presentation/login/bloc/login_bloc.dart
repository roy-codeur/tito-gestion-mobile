import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginUseCase(event.email, event.password);
        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
