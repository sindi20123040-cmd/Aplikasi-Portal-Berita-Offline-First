import 'package:flutter/material.dart';
import 'package:isar/isar.dart'; // WAJIB DIIMPORT
import 'package:path_provider/path_provider.dart'; // WAJIB DIIMPORT
import 'core/di/injection.dart';
import 'core/routing/app_router.dart';
import 'core/config/env_config.dart';
import 'features/home/data/models/news_model.dart'; // Impor skema model berita

// 1. DEKLARASIKAN VARIABEL ISAR GLOBAL DI SINI
late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ambil direktori penyimpanan dokumen lokal HP
  final dir = await getApplicationDocumentsDirectory();

  // Buka database Isar dengan skema NewsModel yang sudah kita buat
  isar = await Isar.open([NewsModelSchema], directory: dir.path);

  // Oper variabel isar ke setupLocator di injection.dart untuk memutus circular dependency
  setupLocator(isar);

  runApp(const FinalProjectApp());
}

class FinalProjectApp extends StatelessWidget {
  const FinalProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: !EnvConfig.isProduction,
      // Menggunakan nama aplikasi dinamis sesuai spesifikasi Flavor NIM kamu
      title: EnvConfig.getAppName('Sindi'),

      theme: ThemeData(
        useMaterial3: true,
        // TANTANGAN ANTI-AI: Jika PROD wajib Biru Gelap, jika DEV bebas (misal: Blue)
        colorSchemeSeed: EnvConfig.isProduction
            ? const Color(0xFF0D47A1)
            : Colors.blue,
        brightness: Brightness
            .light, // NIM Akhiran Genap (0) Wajib Light Mode Permanen!
      ),
      routerConfig: AppRouter.router,
    );
  }
}
