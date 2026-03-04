import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../domain/usecases/register.dart';
import 'register_event.dart';
import 'register_state.dart';
import 'package:startkit_app/core/errors/failure.dart';

class RegisterBloc  extends Bloc<RegisterEvent, RegisterState> {
  final Register registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        await registerUseCase(event.name, event.email, event.password, event.confirmPassword);
        emit(RegisterSuccess());
      } on AuthFailure catch (e) {
        Get.snackbar(
        'Erreur',
        e.statusCode != null ? 'Erreur ${e.statusCode} : ${e.message}' : e.message ?? 'Une erreur est survenue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 203, 49, 64)
      );
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}