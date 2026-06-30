import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';
import '../config/env_config.dart';

final locator = GetIt.instance;

void setupLocator(Isar isar) {
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  locator.registerLazySingleton<NewsRepositoryImpl>(
    () => NewsRepositoryImpl(locator<Dio>(), isar),
  );

  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<NewsRepositoryImpl>()),
  );
}
