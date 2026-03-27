import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_storage/get_storage.dart';
import 'core/constants/app_config.dart';
import 'core/di/dependancy_injection.dart';
import 'core/network/network_bloc/network_cubit.dart';
import 'core/routes/app_pages.dart';
import 'logic/cubits/home_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();
 
  // GetX injections
  Get.put(Connectivity());
  Get.put(ConnectionCubit(Get.find<Connectivity>()));

  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<ConnectionCubit>(
          create: (_) => Get.find<ConnectionCubit>(),
        ),
      ],
      child: BlocListener<ConnectionCubit, NetworkState>(
        listener: (context, state) {
          if (state is NetworkDisconnected) {
            Get.snackbar(
              "Connexion perdue",
              "Veuillez vérifier votre connexion Internet.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
            );
          }

          if (state is NetworkConnected) {
            Get.snackbar(
              "Connexion rétablie",
              "Connexion OK.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.8),
              colorText: Colors.white,
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