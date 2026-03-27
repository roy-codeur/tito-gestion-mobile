import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:startkit_app/core/network/network_bloc/network_cubit.dart';
import 'package:startkit_app/core/network/network_info.dart';
import 'package:startkit_app/data/dao/auth_dao.dart';
import 'package:startkit_app/data/local/onboarding_storage.dart';
import 'package:startkit_app/data/repositories/auth_repository.dart';
import 'package:startkit_app/data/repositories/implementation/auth_repository.dart';
import 'package:startkit_app/logic/cubits/auth/login_cubit.dart';
import 'package:startkit_app/logic/cubits/home_cubit.dart';
import 'package:startkit_app/logic/observables/auth_observable.dart';
import '../api/api_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ---------------------------------------------------------------------------
  // CONNECTIVITY + NETWORK
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ConnectionCubit>(
    () => ConnectionCubit(sl<Connectivity>()),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<ConnectionCubit>()),
  );

  // ---------------------------------------------------------------------------
  // API CLIENT
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<DioClient>(() => DioClient.create());

  // ---------------------------------------------------------------------------
  // DATA SOURCES
  // ---------------------------------------------------------------------------
  // sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSource());
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(sl<DioClient>()),
  // );

  // ---------------------------------------------------------------------------
  // REPOSITORIES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<AuthRepository>(() => ApiAuthRepository());

  // ---------------------------------------------------------------------------
  // STORAGE
  // ---------------------------------------------------------------------------
  // STORAGE
sl.registerLazySingleton<GetStorage>(() => GetStorage());

sl.registerLazySingleton<OnboardingStorage>(() => OnboardingStorage(sl<GetStorage>()));

  

  // ---------------------------------------------------------------------------
  // BLOCS / CUBITS
  // — registerFactory : nouvelle instance à chaque injection
  //   → évite que l'état persiste entre les navigations
  // ---------------------------------------------------------------------------
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl<AuthRepository>()));
  sl.registerFactory<HomeCubit>(() => HomeCubit());

  // ---------------------------------------------------------------------------
  // OBSERVABLE
  // ---------------------------------------------------------------------------

  sl.registerLazySingleton<AuthObservable>(() => AuthDao());
 
}