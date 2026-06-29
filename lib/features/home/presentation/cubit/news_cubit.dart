import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/news_repository_impl.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepositoryImpl _repository;

  NewsCubit(this._repository) : super(NewsLoading());

  Future<void> getNews() async {
    emit(NewsLoading());
    try {
      final newsList = await _repository.fetchNews();
      if (newsList.isEmpty) {
        emit(
          const NewsError('Tidak ada berita tersedia (Offline & Cache Kosong)'),
        );
      } else {
        emit(NewsSuccess(newsList));
      }
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
