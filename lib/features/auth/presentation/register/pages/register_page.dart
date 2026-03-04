import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startkit_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:startkit_app/features/auth/presentation/register/bloc/register_state.dart';
import '../widgets/register_card.dart';

class  RegisterPage extends StatefulWidget {
  const RegisterPage({super.key }); 
  
 @override
  State<RegisterPage>   createState() => _RegisterPageState();  
}

class _RegisterPageState extends State<RegisterPage>
  with SingleTickerProviderStateMixin {
    late AnimationController _controller;
    late Animation<double> _fadeAnimation;
    final nameController = TextEditingController(); 
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

  @override
     void initState() {    
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3)
    );
    _fadeAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(CurvedAnimation(parent:  _controller, curve: Curves.bounceOut)     
    ); 
    _controller.forward();

  }
  @override
  void dispose() {
    _controller.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(      
    body: Container(
      decoration: BoxDecoration(
         gradient: LinearGradient(
            colors: [Color(0xFF9B5DE5), Color(0xFFF15BB5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      ),
      child:SafeArea(
        child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context , state){
          if (state is RegisterSuccess){
            Navigator.pushReplacementNamed(context, "/home");
          }
              if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }

        },
        builder: (context, state){
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9B5DE5), Color(0xFFF15BB5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
              ),
            ),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: RegisterCard(
                nameController: nameController ,                 
                emailController: emailController,
                passwordController: passwordController, 
                confirmPasswordController: confirmPasswordController,
                isLoading : state is RegisterLoading,
                )
              )
          );
        },
        )
        )
      
       
    )
   );
  }

}
