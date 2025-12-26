import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startkit_app/core/di/dependancy_injection.dart';

import 'app_routes.dart';


// Pages
import 'package:startkit_app/features/auth/presentation/login/pages/login_page.dart';
import 'package:startkit_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:startkit_app/features/home/presentation/pages/home_page.dart';
import 'package:startkit_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:startkit_app/features/splash/splash_page.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    // SPLASH
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),

    // ONBOARDING
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
    ),

    // HOME
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),

    // LOGIN avec BlocProvider + injection GetIt
    GetPage(
      name: AppRoutes.login,
      page: () => BlocProvider(
        create: (_) => sl<LoginBloc>(),
        child: const LoginPage(),
      ),
    ),
  ];
}
