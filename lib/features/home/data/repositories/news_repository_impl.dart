import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../models/news_model.dart';

class NewsRepositoryImpl {
  final Dio _dio;
  final Isar _isar;

  NewsRepositoryImpl(this._dio, this._isar);

  Future<List<NewsModel>> fetchNews() async {
    try {
      final response = await _dio.get(
        'top-headlines?country=id&apiKey=GANTI_DENGAN_API_KEY_KAMU',
      );

      if (response.statusCode == 200) {
        final List articles = response.data['articles'] ?? [];
        List<NewsModel> newsList = articles
            .map((json) => NewsModel.fromJson(json))
            .toList();

        newsList.sort(
          (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
        );

        await _isar.writeTxn(() async {
          await _isar.newsModels.clear();
          await _isar.newsModels.putAll(newsList);
        });

        return newsList;
      }
      throw Exception('Gagal memuat berita');
    } catch (e) {
      final localNews = await _isar.newsModels.where().findAll();

      localNews.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );
      return localNews;
    }
  }
}
