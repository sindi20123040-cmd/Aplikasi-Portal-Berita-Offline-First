import 'package:equatable/equatable.dart';
import '../../data/models/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {}

class NewsSuccess extends NewsState {
  final List<NewsModel> news;

  const NewsSuccess(this.news);

  @override
  List<Object?> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
