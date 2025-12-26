import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startkit_app/core/routes/app_routes.dart';
import 'package:startkit_app/features/onboarding/data/local/onboarding_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = OnboardingStorage();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    try {
      // petite pause pour l'animation
      await Future.delayed(const Duration(seconds: 2));

      // 1. Onboarding
      final hasSeenOnboarding = await storage.isSeen();
      if (!hasSeenOnboarding) {
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      // 2. Auth Supabase
      final currentUser = supabase.auth.currentUser;
      if (currentUser != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.snackbar('Erreur', "Impossible de charger l'application");
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
