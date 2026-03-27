import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:startkit_app/core/di/dependancy_injection.dart';
import 'package:startkit_app/core/routes/app_routes.dart';
import 'package:startkit_app/data/local/onboarding_storage.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static String tag = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  // ── Dépendances injectées ─────────────────────────────────────────────────
  final _storage   = sl<OnboardingStorage>();
  final _authLocal = GetStorage();

  // ── Animation ─────────────────────────────────────────────────────────────
  late final AnimationController _controller;
  late final Animation<double>    _fadeAnim;
  late final Animation<double>    _scaleAnim;

  // ─────────────────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initApp();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
  }

  Future<void> _initApp() async {
    try {
      // Laisser l'animation se jouer
      await Future.delayed(const Duration(milliseconds: 2200));
      if (!mounted) return;

      // 1. Onboarding
      final hasSeenOnboarding = await _storage.isSeen();
      if (!mounted) return;
      if (!hasSeenOnboarding) {
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      // 2. Authentification
      final token = await _authLocal.read('auth');
      if (!mounted) return;

      if (token != null && token.isNotEmpty) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (_) {
      if (!mounted) return;
      Get.snackbar(
        'Erreur',
        "Impossible de charger l'application.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: _C.danger.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── UI ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: Stack(
        children: [
          // Halo décoratif
          Positioned(
            top: -120,
            left: -80,
            child: _Glow(color: _C.accent.withValues(alpha: 0.15), size: 420),
          ),
          Positioned(
            bottom: -100,
            right: -60,
            child: _Glow(color: _C.accent.withValues(alpha: 0.08), size: 320),
          ),

          // Contenu centré
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo / icône
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _C.surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _C.accent.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _C.accent.withValues(alpha: 0.2),
                            blurRadius: 32,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: _C.accent,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Nom de l'app
                    const Text(
                      'PayTrack',
                      style: TextStyle(
                        color: _C.textHi,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Chargement en cours...',
                      style: TextStyle(
                        color: _C.textLow,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Indicateur de chargement fin
                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        backgroundColor: _C.border,
                        color: _C.accent,
                        borderRadius: BorderRadius.circular(4),
                        minHeight: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Version en bas
          const Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              'v1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0x30FFFFFF),
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widgets internes ─────────────────────────────────────────────────────────

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color  color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

// ── Palette ───────────────────────────────────────────────────────────────────

class _C {
  static const bg      = Color(0xFF0B0E14);
  static const surface = Color(0xFF13171F);
  static const accent  = Color(0xFF4F7EFF);
  static const border  = Color(0x1AFFFFFF);
  static const textHi  = Colors.white;
  static const textLow = Color(0x50FFFFFF);
  static const danger  = Color(0xFFE24B4A);
}