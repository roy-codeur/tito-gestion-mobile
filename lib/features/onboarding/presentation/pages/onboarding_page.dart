import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/local/onboarding_storage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final storage = OnboardingStorage();

  final controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (i) => setState(() => index = i),
        children: [
          _page("Bienvenue", "Découvrez notre app e-commerce"),
          _page("Produits", "Explorez des milliers d'articles"),
          _page("Livraison", "Livré rapidement et en sécurité"),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            if (index == 2) {
              await storage.setSeen();
              Get.offAllNamed('/login');
            } else {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: Text(index == 2 ? "Commencer" : "Suivant"),
        ),
      ),
    );
  }

  Widget _page(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 20),
          Text(subtitle),
        ],
      ),
    );
  }
}
