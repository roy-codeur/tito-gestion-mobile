import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Ou continuer avec",
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialButton(icon: Icons.g_mobiledata),
            const SizedBox(width: 16),
            _SocialButton(icon: Icons.facebook),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;

  const _SocialButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: Icon(icon, color: Colors.black),
    );
  }
}



