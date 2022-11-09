import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_mania/src/features/home/bloc/get_movies/get_movies_bloc.dart';
import 'package:movie_mania/src/features/home/repository/home_repository.dart';
import 'package:movie_mania/src/features/horizontal_movies/repository/horizontal_movies_repository.dart';

import '../network/api_client.dart';
import '../network/firebase_client.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory<GetMoviesBloc>(() => GetMoviesBloc(repository: sl()));

  // repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl(),
      apiClient: sl(),
    ),
  );
  sl.registerLazySingleton<HorizontalMoviesRepository>(
    () => HorizontalMoviesRepositoryImpl(
      networkInfo: sl(),
      apiClient: sl(),
    ),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(dataConnectionChecker: sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(dio: sl()));
  sl.registerLazySingleton<FirebaseClient>(
      () => FirebaseClientImpl(FirebaseFirestore.instance));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
