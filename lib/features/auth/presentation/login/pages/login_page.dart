import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, "/home");
            }
          },
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 20),

                            TextField(
                              controller: emailController,  
                              decoration: const InputDecoration(labelText: 'Email'),
                            ),

                            const SizedBox(height: 10),

                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(labelText: 'Password'),
                            ),

                            const SizedBox(height: 20),

                            if (state is LoginFailure)
                              Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),

                            ElevatedButton(
                              onPressed: state is LoginLoading
                                  ? null
                                  : () {
                                      context.read<LoginBloc>().add(
                                            LoginSubmitted(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ),
                                          );
                                    },
                              child: state is LoginLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Text("Se connecter"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
