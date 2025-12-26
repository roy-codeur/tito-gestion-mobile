import 'package:get_it/get_it.dart';
import 'package:startkit_app/core/network/network_bloc/network_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:startkit_app/core/constants/app_config.dart';

import 'package:startkit_app/core/network/network_info.dart';

import 'package:startkit_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:startkit_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:startkit_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:startkit_app/features/auth/domain/usecases/login.dart';
import 'package:startkit_app/features/auth/presentation/login/bloc/login_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ---------------------------------------------------------------------------
  // SUPABASE
  // ---------------------------------------------------------------------------
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  // ---------------------------------------------------------------------------
  // CONNECTIVITY + NETWORK CUBIT
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ConnectionCubit>(
      () => ConnectionCubit(sl<Connectivity>()));
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<ConnectionCubit>()));

  // ---------------------------------------------------------------------------
  // DATA SOURCES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Supabase.instance.client));

  // ---------------------------------------------------------------------------
  // REPOSITORIES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remote: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // USE CASES
  // ---------------------------------------------------------------------------
  sl.registerLazySingleton<Login>(() => Login(sl<AuthRepository>()));

  // ---------------------------------------------------------------------------
  // BLOCS
  // ---------------------------------------------------------------------------
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl<Login>()));
}
