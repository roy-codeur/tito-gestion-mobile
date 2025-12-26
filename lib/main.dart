import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:startkit_app/core/constants/app_config.dart';
import 'package:startkit_app/core/di/dependancy_injection.dart';
import 'package:startkit_app/core/network/network_bloc/network_cubit.dart';
import 'package:startkit_app/core/routes/app_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  // Ajouter le Connectivity dans GetX si pas déjà fait
  Get.put(Connectivity());

  // Ajouter ConnectionCubit dans GetX
  Get.put(ConnectionCubit(Get.find<Connectivity>()));

  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectionCubit>(
      create: (_) => Get.find<ConnectionCubit>(),
      child: BlocListener<ConnectionCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkDisconnected) {
            Get.snackbar(
              "Connexion perdue",
              "Veuillez vérifier votre connexion Internet.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
              margin: const EdgeInsets.all(12),
              duration: const Duration(seconds: 3),
            );
          }

          if (state is NetworkConnected) {
            Get.snackbar(
              "Connexion rétablie",
              "Votre appareil est de nouveau en ligne.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.8),
              colorText: Colors.white,
              margin: const EdgeInsets.all(12),
              duration: const Duration(seconds: 2),
            );
          }
        },
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
