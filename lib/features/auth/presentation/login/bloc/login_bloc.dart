import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:startkit_app/core/errors/failure.dart';
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
      } on AuthFailure catch (e) {
        Get.snackbar(
        'Erreur',
        e.statusCode != null ? 'Erreur ${e.statusCode} : ${e.message}' : e.message ?? 'Une erreur est survenue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 203, 49, 64)
      );
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
