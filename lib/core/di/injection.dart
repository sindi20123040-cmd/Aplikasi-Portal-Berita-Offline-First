import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';
import '../../main.dart'; // Impor instance isar global
import '../config/env_config.dart';

final locator = GetIt.instance;

void setupLocator() {
  // 1. Register Dio (Network)
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // 2. Register Repository (Menggunakan singleton Dio dan Isar global)
  locator.registerLazySingleton<NewsRepositoryImpl>(
    () => NewsRepositoryImpl(locator<Dio>(), isar),
  );

  // 3. Register Cubit/BLoC
  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<NewsRepositoryImpl>()),
  );
}
