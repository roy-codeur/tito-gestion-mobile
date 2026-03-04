import 'package:flutter/material.dart';
import 'package:startkit_app/features/auth/presentation/login/widgets/input_field.dart';
import 'package:startkit_app/features/auth/presentation/login/widgets/social_buttons.dart';
import 'package:startkit_app/features/auth/presentation/register/widgets/register_button.dart';


class RegisterCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;

  const RegisterCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading
    });

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white.withOpacity(0.15),   
              
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.transparent

                  )
                ]

              ),
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.all(40),

              child: Column(
                
              
                children: [
                  SizedBox(height:50),
                  Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple
                    ),
                  ), 
                  SizedBox(height:50),
                  InputField(controller: nameController, hint: 'name', icon: Icons.account_circle ),
                  SizedBox(height: 16),
                  InputField(controller: emailController, hint: 'Email', icon: Icons.mail ),
                  SizedBox(height: 16),
                  InputField(controller: passwordController, hint: 'Password', icon: Icons.password ),
                  SizedBox(height: 16),
                  InputField(controller: confirmPasswordController, hint: 'Confirmation Password', icon: Icons.lock ),
                  SizedBox(height: 50),
                  RegisterButton(isLoading: isLoading , name: nameController.text , email: emailController.text, password: passwordController.text ,confirmPassword: confirmPasswordController.text ),
                  SizedBox(height:50),
                  Divider(height: 0.5),
                  SizedBox(height:50),          
                  SocialButtons(),
                  SizedBox(height:30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Vous avez déjà un Compte ? '),
                      TextButton(
                        onPressed: () => {
                          Navigator.pushNamed(context, '/login')
                        },
                        child: Text('Connexion'))
                    ],
                  )
                ],
              )
            )
            );
    
  }
}

