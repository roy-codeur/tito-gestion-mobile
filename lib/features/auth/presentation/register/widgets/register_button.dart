import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startkit_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:startkit_app/features/auth/presentation/register/bloc/register_event.dart';

class RegisterButton extends StatelessWidget {
  final bool isLoading;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  

 const  RegisterButton({
  super.key,
  required this.isLoading,
  required this.name,
  required this.email,
  required this.password,
  required this.confirmPassword,
 
  });

 @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient( 
            colors: [Color(0x00FFFFFF) ,Color(0xFFF15BB5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )

        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
             borderRadius: BorderRadius.circular(14),
            onTap: isLoading ? null : (){
              context.read<RegisterBloc>().add(
                RegisterSubmitted(name: name, email: email, password: password, confirmPassword: confirmPassword)
              );
            },
            child: Center(
              child: isLoading ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(),) : const Text('se'),
            ),

          ),

        ),

      ),
    );
    
  }


} 