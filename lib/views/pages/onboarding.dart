import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startkit_app/core/di/dependancy_injection.dart';
import 'package:startkit_app/core/routes/app_routes.dart';
import '../../data/local/onboarding_storage.dart';

// ── Modèle de données ─────────────────────────────────────────────────────────

class _OnboardingData {
  final IconData icon;
  final String   title;
  final String   subtitle;
  final Color    accentColor;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });
}

const List<_OnboardingData> _pages = [
  _OnboardingData(
    icon:        Icons.bolt_rounded,
    title:       'Bienvenue',
    subtitle:    'Découvrez une expérience pensée\npour vous, dès le premier instant.',
    accentColor: Color(0xFF4F7EFF),
  ),
  _OnboardingData(
    icon:        Icons.grid_view_rounded,
    title:       'Explorez',
    subtitle:    'Des milliers de produits soigneusement\nsélectionnés à portée de main.',
    accentColor: Color(0xFF7C5CFF),
  ),
  _OnboardingData(
    icon:        Icons.verified_rounded,
    title:       'En toute sécurité',
    subtitle:    'Livraison rapide, paiement sécurisé\net suivi en temps réel.',
    accentColor: Color(0xFF3DBE7A),
  ),
];

// ── Page principale ───────────────────────────────────────────────────────────

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final _storage    = sl<OnboardingStorage>();
  final _controller = PageController();

  late final AnimationController _btnController;
  late final Animation<double>    _btnScale;

  int _currentIndex = 0;
  bool _isLoading   = false;

  bool get _isLastPage => _currentIndex == _pages.length - 1;

  // ── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.94,
      upperBound: 1.0,
      value: 1.0,
    );
    _btnScale = _btnController;
  }

  @override
  void dispose() {
    _controller.dispose();
    _btnController.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────────────

  Future<void> _onNext() async {
    await _btnController.reverse();
    await _btnController.forward();

    if (_isLastPage) {
      if (_isLoading) return;
      setState(() => _isLoading = true);
      try {
         _storage.setSeen();
        if (!mounted) return;
        Get.offAllNamed(AppRoutes.login);
      } catch (_) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        Get.snackbar(
          'Erreur',
          'Une erreur est survenue, veuillez réessayer.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: _C.danger.withValues(alpha: 0.9),
          colorText: Colors.white,
        );
      }
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // ── UI ────────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentIndex];

    return Scaffold(
      backgroundColor: _C.bg,
      body: Stack(
        children: [
          // Halo d'ambiance animé selon la page
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: -100,
            right: -80,
            child: _Glow(
              color: page.accentColor.withValues(alpha: 0.15),
              size: 380,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: -80,
            left: -60,
            child: _Glow(
              color: page.accentColor.withValues(alpha: 0.08),
              size: 280,
            ),
          ),

          // Contenu principal
          SafeArea(
            child: Column(
              children: [
                // Bouton "Passer"
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, right: 20),
                    child: AnimatedOpacity(
                      opacity: _isLastPage ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: TextButton(
                        onPressed: _isLastPage ? null : _onNext,
                        child: Text(
                          'Passer',
                          style: TextStyle(
                            color: _C.textLow,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Pages
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemCount: _pages.length,
                    itemBuilder: (_, i) => _OnboardingSlide(data: _pages[i]),
                  ),
                ),

                // Indicateurs + bouton
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                  child: Column(
                    children: [
                      _PageIndicators(
                        count:        _pages.length,
                        currentIndex: _currentIndex,
                        activeColor:  page.accentColor,
                      ),
                      const SizedBox(height: 24),
                      _NextButton(
                        label:       _isLastPage ? "Commencer" : "Suivant",
                        accentColor: page.accentColor,
                        isLoading:   _isLoading,
                        scaleAnim:   _btnScale,
                        onTap:       _onNext,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Slide ─────────────────────────────────────────────────────────────────────

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({required this.data});

  final _OnboardingData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icône
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _C.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: data.accentColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: data.accentColor.withValues(alpha: 0.2),
                  blurRadius: 40,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Icon(data.icon, color: data.accentColor, size: 46),
          ),

          const SizedBox(height: 48),

          // Titre
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color:       _C.textHi,
              fontSize:    32,
              fontWeight:  FontWeight.w700,
              letterSpacing: -0.8,
              height:      1.1,
            ),
          ),

          const SizedBox(height: 16),

          // Sous-titre
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color:      _C.textMid,
              fontSize:   15,
              fontWeight: FontWeight.w400,
              height:     1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Indicateurs de page ───────────────────────────────────────────────────────

class _PageIndicators extends StatelessWidget {
  const _PageIndicators({
    required this.count,
    required this.currentIndex,
    required this.activeColor,
  });

  final int   count;
  final int   currentIndex;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width:  isActive ? 24 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: isActive
                ? activeColor
                : _C.border,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ── Bouton suivant ────────────────────────────────────────────────────────────

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.label,
    required this.accentColor,
    required this.isLoading,
    required this.scaleAnim,
    required this.onTap,
  });

  final String          label;
  final Color           accentColor;
  final bool            isLoading;
  final Animation<double> scaleAnim;
  final VoidCallback    onTap;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnim,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color:        accentColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color:       accentColor.withValues(alpha: 0.35),
                blurRadius:  20,
                offset:      const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color:       Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      label,
                      key: ValueKey(label),
                      style: const TextStyle(
                        color:      Colors.white,
                        fontSize:   16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Halo décoratif ────────────────────────────────────────────────────────────

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
  static const textHi  = Colors.white;
  static const textMid = Color(0x99FFFFFF);
  static const textLow = Color(0x50FFFFFF);
  static const border  = Color(0x1AFFFFFF);
  static const danger  = Color(0xFFE24B4A);
}