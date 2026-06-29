import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/config/env_config.dart';
import 'features/home/data/models/news_model.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();

  isar = await Isar.open([NewsModelSchema], directory: dir.path);

  setupLocator(isar);

  runApp(const FinalProjectApp());
}

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: !EnvConfig.isProduction,

      title: EnvConfig.getAppName('Sindi'),

      theme: ThemeData(
        useMaterial3: true,

        colorSchemeSeed: EnvConfig.isProduction
            ? const Color(0xFF0D47A1)
            : Colors.blue,
        brightness: Brightness.light,
      ),
      routerConfig: AppRouter.router,
    );
  }
}
