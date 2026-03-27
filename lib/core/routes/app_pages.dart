import 'package:get/route_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startkit_app/core/di/dependancy_injection.dart';
import 'package:startkit_app/logic/cubits/auth/login_cubit.dart';
// import 'package:startkit_app/features/auth/presentation/register/bloc/register_bloc.dart';
import 'package:startkit_app/views/pages/auth/login.dart';
import 'package:startkit_app/views/pages/home.dart';
import 'package:startkit_app/views/pages/onboarding.dart';
import 'package:startkit_app/views/pages/splash.dart';
import 'package:startkit_app/views/screens/home/home_screen.dart';

import 'app_routes.dart';

// import 'package:startkit_app/features/auth/presentation/register/pages/register_page.dart';
// import 'package:startkit_app/features/activity/presentation/pages/activity_page.dart';
// import 'package:startkit_app/features/history/presentation/pages/history_page.dart';
// import 'package:startkit_app/features/profil/presentation/pages/profil_page.dart';

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

    // GetPage(
    //   name: AppRoutes.history,
    //   page: () => const HistoryPage(),
    // ),

    // GetPage(
    //   name: AppRoutes.activity,
    //   page: () => const ActivityPage(),
    // ),

    // GetPage(
    //   name: AppRoutes.profil,
    //   page: () => const ProfilPage(),
    // ),

    // LOGIN avec BlocProvider + injection GetIt
    GetPage(
      name: AppRoutes.login,
      page: () => BlocProvider(
        create: (_) => sl<LoginCubit>(),
        child: const LoginPage(),
      ),
    ),
    // GetPage(
    //   name: AppRoutes.register,
    //   page: () => BlocProvider(
    //     create: (_) => sl<RegisterBloc>(),
    //     child: const RegisterPage(),
    //   ),
    // ),
  ];
}
