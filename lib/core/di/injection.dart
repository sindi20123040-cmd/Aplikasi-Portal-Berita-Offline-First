import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart'; // Impor paket resmi Isar
import '../../features/home/data/repositories/news_repository_impl.dart';
import '../../features/home/presentation/cubit/news_cubit.dart';
import '../config/env_config.dart';

final locator = GetIt.instance;

// Kita terima objek 'isar' langsung dari main.dart di sini
void setupLocator(Isar isar) {
  // 1. Register Dio (Network)
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // 2. Register Repository (Menggunakan parameter 'isar' yang dioper)
  locator.registerLazySingleton<NewsRepositoryImpl>(
    () => NewsRepositoryImpl(locator<Dio>(), isar),
  );

  // 3. Register Cubit/BLoC
  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<NewsRepositoryImpl>()),
  );
}
