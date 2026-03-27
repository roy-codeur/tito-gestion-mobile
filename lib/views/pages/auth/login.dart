import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:startkit_app/config/app_colors.dart';
import 'package:startkit_app/core/di/dependancy_injection.dart';
import 'package:startkit_app/core/routes/app_routes.dart';
import 'package:startkit_app/logic/cubits/auth/login_cubit.dart';
import 'package:startkit_app/views/widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const String tag = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView>
    with SingleTickerProviderStateMixin {

  final _emailFocus    = FocusNode();
  final _passwordFocus = FocusNode();
  bool _emailFocused    = false;
  bool _passwordFocused = false;

  late final AnimationController _animCtrl;
  late final Animation<double>   _fade;
  late final Animation<Offset>   _slide;

  @override
  void initState() {
    super.initState();

    _emailFocus.addListener(
      () => setState(() => _emailFocused = _emailFocus.hasFocus),
    );
    _passwordFocus.addListener(
      () => setState(() => _passwordFocused = _passwordFocus.hasFocus),
    );

    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade  = CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end:   Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));

    _animCtrl.forward();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Scaffold(
      backgroundColor: ColorsPalette.bg,
      body: SafeArea(
        child: BlocListener<LoginCubit, LoginState>(
          // ✅ Écoute les changements de navigatedToHome et errorMessage
          listenWhen: (prev, curr) =>
              curr.navigatedToHome != prev.navigatedToHome ||
              curr.errorId != prev.errorId ,
          listener: (context, state) {
            // ✅ Navigation déclenchée par un flag dans le state
            if (state.navigatedToHome) {
              Get.offAllNamed(AppRoutes.home);
            }
            // ✅ Erreur affichée quand errorMessage change
            if (state.errorMessage != null) {
              Get.snackbar(
                'Erreur',
                state.errorMessage!,
                snackPosition:   SnackPosition.BOTTOM,
                backgroundColor: ColorsPalette.danger.withValues(alpha: 0.9),
                colorText:       Colors.white,
              );
            }
          },
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 56),

                    // ── Logo ─────────────────────────────────────────────
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 64, height: 64,
                            decoration: BoxDecoration(
                              color:        ColorsPalette.card,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.layers_outlined,
                              color: ColorsPalette.accent,
                              size:  28,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'PayTrack',
                            style: TextStyle(
                              color:         ColorsPalette.textHigh,
                              fontSize:      26,
                              fontWeight:    FontWeight.w700,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Connectez-vous à votre espace',
                            style: TextStyle(
                              color:    ColorsPalette.textMid,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // ── Champs — rebuild uniquement sur erreurs ────────────
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (prev, curr) =>
                          prev.emailError      != curr.emailError    ||
                          prev.passwordError   != curr.passwordError ||
                          prev.obscurePassword != curr.obscurePassword,
                      builder: (context, state) {
                        return Column(
                          children: [

                            appDarkTextField(
                              label:     'Identifiant',
                              hint:      'Entrez votre identifiant',
                              icon:      Icons.person_outline_rounded,
                              focusNode: _emailFocus,
                              focused:   _emailFocused,
                              errorText: state.emailError,
                              onChanged: cubit.setEmail,
                              validator: (_) => state.emailError,
                            ),

                            const SizedBox(height: 18),

                            appDarkTextField(
                              label:       'Mot de passe',
                              hint:        '••••••••',
                              icon:        Icons.lock_outline_rounded,
                              focusNode:   _passwordFocus,
                              focused:     _passwordFocused,
                              obscureText: state.obscurePassword,
                              errorText:   state.passwordError,
                              onChanged:   cubit.setPassword,
                              validator:   (_) => state.passwordError,
                              suffixIcon:  GestureDetector(
                                onTap: cubit.togglePasswordVisibility,
                                child: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: ColorsPalette.label,
                                  size:  18,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    // ── Mot de passe oublié ───────────────────────────────
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.home),
                        style: TextButton.styleFrom(
                          padding:       const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                          minimumSize:   Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(
                            color:      ColorsPalette.accent,
                            fontSize:   13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ── Bouton connexion — rebuild uniquement sur loading ──
                    BlocBuilder<LoginCubit, LoginState>(
                      buildWhen: (prev, curr) => prev.loading != curr.loading,
                      builder: (context, state) {
                        return SizedBox(
                          width:  double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: state.loading ? null : cubit.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:         ColorsPalette.accent,
                              disabledBackgroundColor: ColorsPalette.accent.withValues(alpha: 0.5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: state.loading
                                ? const SizedBox(
                                    width: 20, height: 20,
                                    child: CircularProgressIndicator(
                                      color:       Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Se connecter',
                                    style: TextStyle(
                                      color:         Colors.white,
                                      fontSize:      15,
                                      fontWeight:    FontWeight.w600,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // ── Lien inscription ──────────────────────────────────
                    Center(
                      child: GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.home),
                        child: const Text.rich(
                          TextSpan(
                            text:  'Pas de compte ?  ',
                            style: TextStyle(color: ColorsPalette.label, fontSize: 13),
                            children: [
                              TextSpan(
                                text:  'Créer un compte',
                                style: TextStyle(
                                  color:      ColorsPalette.accent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}