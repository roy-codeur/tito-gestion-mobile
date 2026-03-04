import 'package:flutter/material.dart';
import '../widgets/input_field.dart';
import '../widgets/login_button.dart';
import '../widgets/social_buttons.dart';


class LoginCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;

  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_outline, size: 64, color: Colors.white),
          const SizedBox(height: 16),

          const Text(
            "Bienvenue",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            "Connectez-vous à votre compte",
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 32),

          InputField(
            controller: emailController,
            hint: "Email",
            icon: Icons.email_outlined,
            obscure: false,
          ),

          const SizedBox(height: 16),

          InputField(
            controller: passwordController,
            hint: "Mot de passe",
            icon: Icons.lock_outline,
            obscure: true,
          ),

          const SizedBox(height: 12),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Mot de passe oublié ?",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 16),
          

          LoginButton(       
            isLoading: isLoading,
            email: emailController.text,
            password: passwordController.text,
          ),

          const SizedBox(height: 24),

          const SocialButtons(),
        ],
      ),
    );
  }
}
