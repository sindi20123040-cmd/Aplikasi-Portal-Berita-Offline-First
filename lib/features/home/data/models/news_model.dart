import 'package:isar/isar.dart';

part 'news_model.g.dart';

@collection
class NewsModel {
  Id id = Isar.autoIncrement;

  late String title;
  late String description;
  late String urlToImage;
  late String publishedAt;

  NewsModel({
    this.title = '',
    this.description = '',
    this.urlToImage = '',
    this.publishedAt = '',
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
